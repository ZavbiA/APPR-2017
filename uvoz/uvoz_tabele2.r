library(rvest) 
library(gsubfn) 
library(readr) 
library(dplyr) 
library(tibble)
library(reshape2)


data <- read_csv("uvoz/populacija.csv",
                  skip = 4, locale = locale(encoding = "Windows-1250")) 

data[2] <- NULL
data[2] <- NULL
data[2] <- NULL



#data$drzava <- data$drzava %>% strapplyc("^([^/]*)") %>% unlist() %>% 
  #strapplyc("([^ ]+)") %>% sapply(paste, collapse = " ") %>% unlist() 
#data$st.prebivalcev <- as.numeric(data$st.prebivalcev) 
#data$drzava <- factor(data$drzava, levels = drzava) 

