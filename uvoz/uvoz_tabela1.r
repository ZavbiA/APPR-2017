# 2. faza: Uvoz podatkov

library(rvest)
library(gsubfn)
library(readr)
library(dplyr)

# Funkcija, ki uvozi število medalj po državah iz Wikipedije
link <- "https://en.wikipedia.org/wiki/All-time_Olympic_Games_medal_table"
stran <- html_session(link) %>% read_html()
tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
.[[1]] %>% html_table(dec = ".")

#pobrišem odvečne stolpce in vrstice
tabela[2] <- NULL
tabela[5] <- NULL
tabela[5] <- NULL
tabela[8] <- NULL
tabela[8] <- NULL
tabela[8] <- NULL
tabela[8] <- NULL
tabela[8] <- NULL
tabela[8] <- NULL
tabela <- tabela[-c(1, nrow(tabela)), ]

colnames(tabela) <- c("države", "zimske_bronaste", "zimske_srebrne", "zimske_zlate", "poletne_bronaste",
                      "poletne_srebrne", "poletne_zlate") 
Encoding(tabela$države) <- "UTF-8"
tabela$države <- tabela$države %>% strapplyc("([[:alpha:] ]+)") %>% sapply(. %>% .[1])
  
View(tabela)
