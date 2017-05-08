#tukaj opravim uvoz tabele iz wikipedije
library(rvest)
library(gsubfn)
library(readr)
library(dplyr)

# Funkcija, ki uvozi Ĺˇtevilo medalj po drĹľavah iz Wikipedije
link <- "https://en.wikipedia.org/wiki/All-time_Olympic_Games_medal_table"
stran <- html_session(link) %>% read_html()
tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% 
.[[1]] %>% html_table(dec = ".") 
#pobriĹˇem odveÄŤne stolpce in vrstice tabela
[2] <- NULL 
tabela[5] <- NULL 
tabela[5] <- NULL 
tabela[8] <- NULL 
tabela[8] <- NULL 
tabela[8] <- NULL 
tabela[8] <- NULL 
tabela[8] <- NULL 
tabela[8] <- NULL 
tabela <- tabela[-c(1, nrow(tabela)), ]

colnames(tabela) <- c("drzave", "poletne_bronaste", "poletne_srebrne", "poletne_zlate", "zimske_bronaste",                       
                      "zimske_srebrne", "zimske_zlate") 
Encoding(tabela$drzave) <- "UTF-8"
tabela$drzave <- tabela$drzave %>% strapplyc("([[:alpha:] ]+)") %>% sapply(. %>% .[1])
sl <- locale("sl", decimal_mark = ".", grouping_mark = ",")
for (col in c("poletne_bronaste", "poletne_srebrne", "poletne_zlate", "zimske_bronaste",              
              "zimske_srebrne", "zimske_zlate")) {  
  tabela[[col]] <- parse_number(tabela[[col]], na = "-", locale = sl)}

View(tabela) 
