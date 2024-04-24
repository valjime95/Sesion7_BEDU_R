# Ejemplo 2

install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")

library(DBI)
library(RMySQL)
library(dplyr)

# creacion de una conexion a una bd 
base <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

dbListTables(base)

dbListFields(base, "City")

# query

?dbGetQuery
df <- dbGetQuery(base,"Select * from City where Population > 5000")
class(df) # function
typeof(df) # closure

mean(df$Population)

df %>% filter( CountryCode == 'MEX') %>% head(5)

install.packages("pool")
install.packages("dbplyr")

library(pool)
library(dbplyr)

db_pool <- dbPool(
  RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

dbListTables(db_pool)

db_pool %>% tbl("Country") %>% head(5)

db_pool %>% tbl("CountryLanguage") %>% head(5)

db_3 <- dbConnect(
  RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

rs <- dbSendQuery(db_3, "SELECT * FROM City LIMIT 5")
rs




city_df <- dbFetch(rs)

# desconectarnos de la base 
dbClearResult(rs)
dbDisconnect(db_3)

#EJEMPLO
install.packages("rjson")
library(rjson)

json <- fromJSON(file = "json_ejemplo4.json")
json

class(json)

str(json)

json$Pets[2]

as.data.frame(json)


# XML
install.packages("XML")
library(XML)

link <- "http://www-db.deis.unibo.it/courses/TW/DOCS/w3schools/xml/cd_catalog.xml"
xml_file <- xmlTreeParse(link)

xml_file

summary(xml_file)

top_xml <- xmlSApply(xml_file, function(x) xmlSApply(x, xmlValue))

xml_df <- data.frame(t(top_xml), row.names = NULL)
xml_df

str(xml_df)
xml_df$PRICE <-as.numeric(xml_df$PRICE)


# html

install.packages("rvest")
library("rvest")

url <- "https://solarviews.com/span/data2.htm"
html <- read_html(url)

tables <- html_nodes(html, "table")
tables

table_html <- html_table(tables[4], fill=TRUE)
table_html
