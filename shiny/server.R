library(shiny)

if ("server.R" %in% dir()) {
  setwd("..")
}

source("lib/libraries.r", encoding = "UTF-8")

source("uvoz/uvoz_tabele4.r", encoding = "UTF-8")
source("uvoz/uvoz_tabele5.r", encoding = "UTF-8")
source("uvoz/uvoz_shiny.r", encoding = "UTF-8")

function(input,output) {
  output$graf_medalj <- renderPlot({
    
    ggplot(filter(skupna_tabela, Leto==input$leto)) + geom_bar() +
    ylab="Število osvojenih medalj" + xlab="Država"
  })
}
