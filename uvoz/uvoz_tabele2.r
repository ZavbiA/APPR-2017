library(rvest) 
library(gsubfn) 
library(readr) 
library(dplyr) 
library(tibble)
library(reshape2)

#tukaj opravim uvoz tabele drzav s stevilom prebivalcev v letih OI
data <- read_csv("podatki/populacija.csv",
                  skip = 4, locale = locale(encoding = "UTF-8")) 

data[2] <- NULL
data[2] <- NULL
data[2] <- NULL

#pobrisati moram stolpce z leti, v katerih ni bilo olimpijskih iger
data[3:5] <- NULL
data[4:6] <- NULL
data[5:7] <- NULL
data[6:8] <- NULL
data[7:9] <- NULL
data[8:10] <- NULL
data[9:11] <- NULL
data[10:12] <- NULL #od tu naprej so OI na 2 leti
data[11] <- NULL
data[12] <- NULL
data[13] <- NULL
data[14] <- NULL
data[15] <- NULL
data[16] <- NULL
data[17] <- NULL
data[18] <- NULL
data[19] <- NULL
data[20] <- NULL
data[21] <- NULL
data[22] <- NULL
data[22] <- NULL
data[22] <- NULL

tabela2.tidy <- melt(data, value.name = "stevilo_prebivalcev")
names(tabela2.tidy) <- c("drzava","leto","stevilo_prebivalcev")
tabela2.tidy$leto <- parse_number(tabela2.tidy$leto)
tabela2.tidy$stevilo_prebivalcev <- parse_number(tabela2.tidy$stevilo_prebivalcev)

tabela2.tidy$drzava <- gsub("Slovak Republic", "Slovakia", tabela2.tidy$drzava)
tabela2.tidy$drzava <- gsub("Egypt, Arab Rep.", "Egypt", tabela2.tidy$drzava)
tabela2.tidy$drzava <- gsub("Venezuela, RB", "Venezuela", tabela2.tidy$drzava)
tabela2.tidy$drzava <- gsub("Cote d'Ivoire", "Côte d'Ivoire", tabela2.tidy$drzava)
tabela2.tidy$drzava <- gsub("Bahamas, The", "Bahamas", tabela2.tidy$drzava)
tabela2.tidy$drzava <- gsub("Syrian Arab Republic", "Syria", tabela2.tidy$drzava)
tabela2.tidy$drzava <- gsub("Hong Kong SAR, China", "Hong Kong", tabela2.tidy$drzava)
tabela2.tidy$drzava <- gsub("Iran, Islamic Rep.", "Iran", tabela2.tidy$drzava)
tabela2.tidy$drzava <- gsub("Kyrgyz Republic", "Kyrgyzstan", tabela2.tidy$drzava)
tabela2.tidy$drzava <- gsub("Macedonia, FYR", "Macedonia", tabela2.tidy$drzava)
tabela2.tidy$drzava <- gsub("Virgin Islands (U.S.)", "United States Virgin Islands", tabela2.tidy$drzava)
