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
    barplot(skupna_tabela[,input$leto],
            main=input$leto,
            ylab="Število osvojenih medalj",
            xlab="Država")
  })
}
