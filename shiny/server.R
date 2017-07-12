library(shiny)

shinyServer(function(input,output) {
  output$graf_medalj <- renderPlot({
    
    medalje <- skupna_tabela %>% filter(leto %in% input$leto) %>%
      group_by(drzava, lesk) %>% summarise(stevilo = sum(stevilo))
    maxst <- medalje %>% group_by(drzava) %>% summarise(stevilo = sum(stevilo)) %>%
      summarise(stevilo = max(stevilo)) %>% .$stevilo
    ggplot(medalje,
           aes(x = reorder(drzava,
                           -sapply(drzava,
                                   . %>% { filter(medalje, drzava == .) %>%
                                          arrange(desc(lesk)) %>% .$stevilo } %>%
                                   { .[1]*maxst^2 + .[2]*maxst + .[3] })),
               y = stevilo, fill = factor(lesk, c("zlate", "srebrne", "bronaste")))) +
    geom_col(position = "dodge") + ylab("Število osvojenih medalj") + xlab("Država") +
    guides(fill = guide_legend(title = "Medalje"))
  })
}
)
