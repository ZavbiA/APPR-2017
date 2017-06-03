#uvoz tabele o krajih in letnicah zimskih oz.poletnih OI z wikipedije

library(rvest) 
library(gsubfn) 
library(readr) 
library(dplyr)

link4 <- "https://simple.wikipedia.org/wiki/Olympic_Games" 
stran4 <- html_session(link4) %>% read_html() 
tabela4 <- stran4 %>% html_nodes(xpath="//table[@class='wikitable']") %>% .[[1]] %>% html_table()
