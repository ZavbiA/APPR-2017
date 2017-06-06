#tukaj opravim uvoz tabele iz wikipedije
library(rvest)
library(gsubfn)
library(readr)
library(dplyr)

# Funkcija, ki uvozi stevilo medalj po drzavah iz Wikipedije
link <- "https://en.wikipedia.org/wiki/All-time_Olympic_Games_medal_table"
stran <- html_session(link) %>% read_html()
tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
.[[1]] %>% html_table(dec = ".")

#pobrisem odvecne stolpce in vrstice tabela
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

colnames(tabela) <- c("drzava", "poletne_bronaste", "poletne_srebrne", "poletne_zlate", "zimske_bronaste",
                      "zimske_srebrne", "zimske_zlate")
Encoding(tabela$drzava) <- "UTF-8"
tabela$drzava <- tabela$drzava %>% strapplyc("([[:alpha:]' ]+)") %>% sapply(. %>% .[1])
sl <- locale("sl", decimal_mark = ".", grouping_mark = ",")
for (col in c("poletne_bronaste", "poletne_srebrne", "poletne_zlate", "zimske_bronaste",
              "zimske_srebrne", "zimske_zlate")) {
  tabela[[col]] <- parse_number(tabela[[col]], na = "-", locale = sl)}

tabela1.tidy <- melt(tabela, value.name = "stevilo") %>%
  transmute(drzava, tip = variable %>% parse_character() %>% strapplyc("^(.*)_") %>% unlist(),
            medalja = variable %>% parse_character() %>%strapplyc("_(.*)$") %>% unlist(), stevilo)

tabela1.tidy$drzava <- gsub("Russia", "Russian Federation", tabela1.tidy$drzava)
tabela1.tidy$drzava <- gsub("Great Britain", "United Kingdom", tabela1.tidy$drzava)
tabela1.tidy$drzava <- gsub("Virgin Islands", "United States Virgin Islands", tabela1.tidy$drzava)
