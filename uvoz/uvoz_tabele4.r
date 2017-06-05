#uvoz tabele o krajih in letnicah zimskih oz.poletnih OI z wikipedije

library(rvest) 
library(gsubfn) 
library(readr) 
library(dplyr)
library(reshape2)

link4 <- "https://simple.wikipedia.org/wiki/Olympic_Games" 
stran4 <- html_session(link4) %>% read_html() 
tabela4 <- stran4 %>% html_nodes(xpath="//table[@class='wikitable']") %>% .[[1]] %>% html_table(fill = TRUE)
names(tabela4)[c(1, 3, 5)] <- c("leto", "kraj", "kraj")

tabela4.tidy <- rbind(tabela4[-1, c(1, 3)] %>% mutate(igre = "poletne"),
                      tabela4[-1, c(1, 5)] %>% mutate(igre = "zimske")) %>%
  filter(kraj != "", ! grepl("Cancelled", kraj))
Encoding(tabela4.tidy$kraj) <- "UTF-8"

tabela4.tidy$kraj <- gsub("(\\[| \\+).*$", "", tabela4.tidy$kraj)
tabela4.tidy$kraj <- gsub("^.*\\n ", "", tabela4.tidy$kraj)

tabela4.tidy <- tabela4.tidy %>% transmute(leto = parse_number(leto),
                                           mesto = kraj %>% strapplyc("^(.*),") %>% unlist(),
                                           drzava = kraj %>% strapplyc(", (.*)$") %>% unlist(),
                                           igre)