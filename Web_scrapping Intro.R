# web scrapping#

install.packages("selectr")
install.packages("xml2")
install.packages("rvest")
install.packages("stringr")
install.packages("jsonlite")

library(xml2)
library(rvest)
library(stringr)

#EJEMPLO: LEER CONTENIDO EN AMAZON ##
url <- "https://www.amazon.in/OnePlus-Midnight-Black-128GB-Storage/dp/B07DJHY82F/ref=pd_cp_107_1/257-8976041-9230108?_encoding=UTF8&pd_rd_i=B07DJHY82F&pd_rd_r=439b84c5-8628-11e9-8485-0974c0711c2f&pd_rd_w=k0vDB&pd_rd_wg=UycX6&pf_rd_p=cf49abc6-2d3e-4a22-9a85-f5ff7f5942fa&pf_rd_r=MA0GAHAYZWS2JBHX2NF3&psc=1&refRID=MA0GAHAYZWS2JBHX2NF3"
webpage <- read_html(url)

# extraer título
title_html <- html_nodes(webpage,"h1#title")
title<- html_text(title_html)
head(title)

# quitar carácteres no deseados
title<-str_replace_all(title,"[\r\n]"," ")

# extraer precio
price_html<- html_nodes(webpage,"span#priceblock_ourprice")
price <- html_text(price_html)
price <-str_replace_all(price,"[\r\n]"," ")
head(price)

#extraer descripción
desc_html<- html_nodes(webpage,"div#productDescription")
desc<- html_text(desc_html)
desc<-str_replace_all(desc,"[r\n\t]"," ")
desc<-str_trim(desc)
head(desc)

#extraer rating
rate_html<- html_nodes(webpage,"span#acrPopover")
rate<- html_text(rate_html)
rate<-str_replace_all(desc,"[\r\n\]"," ")
rate<-str_trim(rate)
head(rate)


# Combinar en tabla
product_data <- data.frame(Title=title, Price=price, Description=desc, Rating=rate)
str(product_data)

library(jsonlite)
json_data<-toJSON(product_data)
cat(json_data)

print("fine")
