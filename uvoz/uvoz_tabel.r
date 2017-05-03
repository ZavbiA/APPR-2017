# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi število medalj po državah iz Wikipedije
uvozi.medalje <- function() {
  link <- "https://en.wikipedia.org/wiki/All-time_Olympic_Games_medal_table"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[1]] %>% html_table(dec = ".")
  colnames(tabela) <- c("države", "zimske_bronaste", "zimske_srebrne", "zimske_zlate", "poletne_bronaste",                        
  "poletne_srebrne", "poletne_zlate")  
  return(tabela)}
  
View(tabela)
  
# Funkcija, ki uvozi podatke iz datoteke populacija.csv
uvozi.populacija <- function(populacija) {  
  return(data)}
  
# Zapišimo podatke v razpredelnico medalje
  medalje <- uvozi.medalje()
# Zapišimo podatke v razpredelnico slovenija
  slovenija <- uvozi.slovenija()
# Zapišimo podatke v razpredelnico populacija
  populacija <- uvozi.populacija(levels(populacija$populacija))
  
  
  
  
