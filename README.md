# Analiza podatkov s programom R, 2016/17

Avtorica: Anja Žavbi Kunaver

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2016/17

## Tematika
V svojem projektu bom analizirala podatke olimpijskih iger. Najprej bom analizirala uspešnost držav na poletnih in zimskih olimpijskih igrah od leta 1896 do 2016 in sicer glede na število zlatih, srebrnih in bronastih medalj ter vseh skupaj. Upoštevala bom tudi število prebivalcev posamezne države. Tabele s podatki sem našla na wikipediji (https://en.wikipedia.org/wiki/All-time_Olympic_Games_medal_table) in Eurostatu (oblika CSV). Po vrsticah bodo podatki za vsako državo posebej in sicer število bronastih, srebrnih in zlatih medalj na poletnih in zimskih olimpijskih igrah. Posebej bo tabela iz Eurostata s številom prebivalcev vsake države.

Posebej bom analizirala slovenske medaliste na olimpijskih igrah. Ti podatki so dostopni na http://www.olympic.si/olimpijski-wiki/olimpijske-igre. Zanimali me bodo podatki glede na športno panogo. Torej bo tabela po stolpcih imela športne panoge, disciplino, ime in priimek športnika, leto osvojitve medalje ter mesto (1-3). Tukaj bo potrebno združiti več tabel skupaj in dodati stolpec z letnicami.

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
