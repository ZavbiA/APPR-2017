library(rvest) 
library(gsubfn) 
library(readr) 
library(dplyr) 
library(tibble)
library(reshape2)
library(gsubfn)
library(tidyr)

tabela5.tidy <- read_csv("podatki/stroski.csv",
                  locale = locale(encoding = "UTF-8")) 

names(tabela5.tidy) <- c("mesto","leto","drzava","tip","st_dogodkov","st_nastopajocih","stroski")
tabela5.tidy <- tabela5.tidy %>% filter(! mesto %in% c("Average", "Median"))
tabela5.tidy <- tabela5.tidy[-c(1), ]
tabela5.tidy$tip <- gsub("Summer", "P", tabela5.tidy$tip)
tabela5.tidy$tip <- gsub("Winter", "Z", tabela5.tidy$tip)
tabela5.tidy$stroski <- parse_number(tabela5.tidy$stroski)
tabela5.tidy$leto <- parse_number(tabela5.tidy$leto)
