#tukaj opravim uvoz tabele iz wikipedije
library(rvest)
library(gsubfn)
library(readr)
library(dplyr)
library(tidyr)
library(tibble)

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
tabela1.tidy$drzava <- gsub("East Germany", "Germany", tabela1.tidy$drzava)
tabela1.tidy$drzava <- gsub("West Germany", "Germany", tabela1.tidy$drzava)
tabela1.tidy$drzava <- gsub("United Team of Germany", "Germany", tabela1.tidy$drzava)
tabela1.tidy$drzava <- gsub("North Korea", "Republic of Korea", tabela1.tidy$drzava)
tabela1.tidy$drzava <- gsub("South Korea", "Republic of Korea", tabela1.tidy$drzava)

#pobrisem vrstice, kjer se ponovijo imena drzav
tabela1.tidy <- tabela1.tidy[-c(
  46:49, 73:74, 197:200, 224:225, 348:351, 375:376, 499:502, 526:527, 650:653, 677:678, 801:804, 828:829), ]

#dodam vrstice s sestevkom medalj
tabela1.tidy <- tabela1.tidy %>%
  add_row(drzava = "Germany", tip = "poletne", medalja = "bronaste", stevilo = 428) %>%
  add_row(drzava = "Germany", tip = "poletne", medalja = "srebrne", stevilo = 442) %>%
  add_row(drzava = "Germany", tip = "poletne", medalja = "zlate", stevilo = 476) %>%
  add_row(drzava = "Germany", tip = "zimske", medalja = "bronaste", stevilo = 136) %>%
  add_row(drzava = "Germany", tip = "zimske", medalja = "srebrne", stevilo = 135) %>%
  add_row(drzava = "Germany", tip = "zimske", medalja = "zlate", stevilo = 106) %>%
  add_row(drzava = "Republic of Korea", tip = "poletne", medalja = "bronaste", stevilo = 106) %>%
  add_row(drzava = "Republic of Korea", tip = "poletne", medalja = "srebrne", stevilo = 100) %>%
  add_row(drzava = "Republic of Korea", tip = "poletne", medalja = "zlate", stevilo = 112) %>%
  add_row(drzava = "Republic of Korea", tip = "zimske", medalja = "bronaste", stevilo = 26) %>%
  add_row(drzava = "Republic of Korea", tip = "zimske", medalja = "srebrne", stevilo = 18) %>%
  add_row(drzava = "Republic of Korea", tip = "zimske", medalja = "zlate", stevilo = 11)
