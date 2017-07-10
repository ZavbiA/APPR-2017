library(rvest) 
library(gsubfn) 
library(readr) 
library(dplyr)
library(reshape2)
library(tidyr)
library(tibble)

uvoz_tabel_wiki <- function(leto) {
  if(leto==2016) {link <- "https://en.wikipedia.org/wiki/2016_Summer_Olympics_medal_table"}
  if(leto==2014) {link <- "https://en.wikipedia.org/wiki/2014_Winter_Olympics_medal_table"}
  if(leto==2012) {link <- "https://en.wikipedia.org/wiki/2012_Summer_Olympics_medal_table"}
  if(leto==2010) {link <- "https://en.wikipedia.org/wiki/2010_Winter_Olympics_medal_table"}
  if(leto==2008) {link <- "https://en.wikipedia.org/wiki/2008_Summer_Olympics_medal_table"}
  if(leto==2006) {link <- "https://en.wikipedia.org/wiki/2006_Winter_Olympics_medal_table"}
  if(leto==2004) {link <- "https://en.wikipedia.org/wiki/2004_Summer_Olympics_medal_table"}
  if(leto==2002) {link <- "https://en.wikipedia.org/wiki/2002_Winter_Olympics_medal_table"}
  if(leto==2000) {link <- "https://en.wikipedia.org/wiki/2000_Summer_Olympics_medal_table"}
  
  stran <- html_session(link) %>% read_html(encoding = "UTF-8")
  
  if(leto==2016) {tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable plainrowheaders']") %>% 
    .[[1]] %>% html_table(fill=TRUE)}
  if(leto==2014) {tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% 
    .[[1]] %>% html_table(dec = ".")}
  if(leto==2012) {tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable plainrowheaders']") %>% 
    .[[1]] %>% html_table(fill=TRUE)}
  if(leto==2010) {tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% 
    .[[1]] %>% html_table(fill=TRUE)}
  if(leto==2008) {tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable plainrowheaders']") %>% 
    .[[1]] %>% html_table(fill=TRUE)}
  if(leto==2006) {tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% 
    .[[1]] %>% html_table(fill=TRUE)}
  if(leto==2004) {tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable plainrowheaders']") %>% 
    .[[1]] %>% html_table(fill=TRUE)}
  if(leto==2002) {tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% 
    .[[1]] %>% html_table(fill=TRUE)}
  if(leto==2000) {tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable plainrowheaders']") %>% 
    .[[1]] %>% html_table(fill=TRUE)}
  
  tabela[1] <- NULL
  tabela[5] <- NULL
  if(leto==2010) {tabela <- tabela[c(1,2,3,4,5,6,7,9,10), ]
  tabela <- tabela %>% add_row(NOC = "Â SwedenÂ (SWE)", Gold=5, Silver=2, Bronze=4)}
  else {tabela <- tabela[c(1,2,3,4,5,6,7,8,9,10), ]}
  colnames(tabela) <- c("drzava", "zlate", "srebrne", "bronaste") 
  tabela <- melt(tabela, value.name = "stevilo")
  
  if(leto==2016) {tabela[4] <- "2016"}
  if(leto==2014) {tabela[4] <- "2014"}
  if(leto==2012) {tabela[4] <- "2012"}
  if(leto==2010) {tabela[4] <- "2010"}
  if(leto==2008) {tabela[4] <- "2008"}
  if(leto==2006) {tabela[4] <- "2006"}
  if(leto==2004) {tabela[4] <- "2004"}
  if(leto==2002) {tabela[4] <- "2002"}
  if(leto==2000) {tabela[4] <- "2000"}
  
  colnames(tabela) <- c("drzava", "lesk","stevilo", "leto") 
  tabela$leto <- parse_number(tabela$leto)
  tabela$drzava <- gsub("Â", "", tabela$drzava)
  tabela$drzava <- gsub("[[:punct:]]", "", tabela$drzava)
  tabela$drzava <- gsub("[[:upper:]][[:upper:]][[:upper:]]", "", tabela$drzava)
  tabela$drzava <- gsub("^.*\\n", "", tabela$drzava)
  tabela$lesk <- parse_character(tabela$lesk)
}

#vektor letnic OI 21.stoletja
letnice <- c(2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016)

skupna_tabela <- lapply(letnice,uvoz_tabel_wiki)
bind_rows(skupna_tabela)