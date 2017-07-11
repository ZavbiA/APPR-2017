library(shiny)

fluidPage(
  
  titlePanel("Olimpijske igre"),
  
  sidebarLayout(
      sidebarPanel(
        selectInput("leto", "Leto:", names(skupna_tabela)),
        hr(),
        helpText()
      ),
      mailPanel(
        plotOutput("graf_medalj")
      )
  )
)
