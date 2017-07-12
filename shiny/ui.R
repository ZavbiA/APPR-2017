library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Olimpijske igre"),
  
  sidebarLayout(
      sidebarPanel(
        selectInput("leto", "Leto:", choises = c(2000,2002,2004,2006,2008,2010,2012,2014,2016),
                    multiple = TRUE, selected = c(2000)),
        hr(),
        helpText()
      ),
      mailPanel(
        plotOutput("graf_medalj")
      )
  )
))
