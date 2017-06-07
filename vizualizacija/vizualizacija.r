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

msp <- tabela1.tidy %>% group_by(drzava) %>% summarise(medalje = sum(stevilo)) %>%
  inner_join(tabela2.tidy %>% filter(leto == 2014)) %>%
  transmute(drzava = parse_factor(drzava, levels(zemljevid$name_long)),
            msp = medalje / stevilo_prebivalcev)
g <- ggplot() + geom_polygon(data = zemljevid %>% left_join(msp, by = c("name_long" = "drzava")),
                        aes(x=long, y=lat, group=group, fill = msp * 1000000)) +
  guides(fill = guide_colorbar(title = "Medalje na milijon prebivalcev")) +
  scale_fill_gradient(limits = c(0, 100))
