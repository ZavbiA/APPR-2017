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
    geom_bar(stat = "identity") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
    ylab("Število osvojenih medalj") + xlab("Država") +
    guides(fill = guide_legend(title = "Medalje")) +
    scale_fill_manual(values=c("darkgoldenrod1", "darkgray", "lightsalmon4")) +
    guides(fill = guide_legend(title = "Medalje"))
  })
  
  output$podatki <- renderDataTable({
    info <- tabela4.tidy %>% filter(leto %in% input$leto)
    info[1] <- NULL
    info
  })
}
)
