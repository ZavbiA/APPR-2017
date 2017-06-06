# 3. faza: Vizualizacija podatkov

library(sp)
library(maptools)
library(digest)
gpclibPermit()
library(rvest)
library(gsubfn)
library(readr)
library(dplyr) 

# Uvozim zemljevid.
zemljevid <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                             "ne_50m_admin_0_countries", encoding = "Windows-1252") %>%
  pretvori.zemljevid()
