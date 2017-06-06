# 3. faza: Vizualizacija podatkov

library(sp)
library(maptools)
library(digest)
gpclibPermit()
library(rvest)
library(gsubfn)
library(readr)
library(dplyr)
library(ggplot2)
library(tibble)

# Uvozim zemljevid.
zemljevid <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                             "ne_50m_admin_0_countries", encoding = "Windows-1252") %>%
  pretvori.zemljevid()

ggplot() + geom_polygon(data = zemljevid, aes(x=long, y=lat, group=group, fill=id)) +
  guides(fill = FALSE)
