library(shiny)

function(input,output) {
  output$graf_medalj <- renderPlot({
    barplot(skupna_tabela[,input$leto],
            main=input$leto,
            ylab="Število osvojenih medalj",
            xlab="Država")
  })
}
