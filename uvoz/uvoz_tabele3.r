library(rvest) 
library(gsubfn) 
library(readr) 
library(dplyr) 


# Funkcija, ki uvozi tabele slovenskih medalistov
link1 <- "http://www.olympic.si/olimpijski-wiki/olimpijske-igre" 
stran1 <- html_session(link1) %>% read_html(encoding = "UTF-8") 
tabele <- stran1 %>% html_nodes(xpath="//div[@id='vsebina259']/table")
OI <- stran1 %>% html_nodes(xpath="//div[@id='vsebina259']//caption") %>% html_text() %>% c("POI Rio 2016")
podatki <- lapply(tabele, . %>% html_table)
slo.medalje <- lapply(1:length(OI), . %>% data.frame(podatki[[.]][-1,], OI = OI[.],
                                                     stringsAsFactors = FALSE)) %>% bind_rows()
for (i in 1:ncol(slo.medalje)) {
  if (is.character(slo.medalje[[i]])) {
    Encoding(slo.medalje[[i]]) <- "UTF-8"
  }
}

slo.medalje[1] <- NULL 
colnames(slo.medalje) <- c("ime in priimek", "sport", "disciplina", "uvrstitev", "igre")

slo.medalje <- slo.medalje %>%
  mutate(uvrstitev = uvrstitev %>% strapplyc("^(.)") %>% unlist() %>% parse_number(),
         tip = igre %>% strapplyc("^(.)") %>% unlist(),
         leto = igre %>% strapplyc("([0-9]+)$") %>% unlist() %>% parse_number()) %>%
  select(-igre)
