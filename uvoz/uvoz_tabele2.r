library(rvest) 
library(gsubfn) 
library(readr) 
library(dplyr) 
library(tibble)
library(reshape2)

#tukaj opravim uvoz tabele drzav s stevilom prebivalcev v letih OI
data <- read_csv("uvoz/populacija.csv",
                  skip = 4, locale = locale(encoding = "Windows-1250")) 

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
