# 3. faza: Vizualizacija podatkov

# Uvozim zemljevid.
zemljevid <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                             "ne_50m_admin_0_countries", encoding = "Windows-1252") %>%
  pretvori.zemljevid()
