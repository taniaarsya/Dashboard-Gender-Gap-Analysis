function(input, output) {
  
  output$plot_col <- renderPlotly({
    data_agg1 <- workers_clean %>%
      filter(year == input$year) %>% 
      group_by(major_category) %>%
      summarise(median_gap = median(total_earnings_male-total_earnings_female))
    
    plot_ranking <- data_agg1 %>% 
      ggplot(aes(x = median_gap, 
                 y = reorder(major_category, median_gap),
                 text = glue("{major_category}
                         median gap: {dollar(median_gap)}"))) +
      geom_col(fill = "dodgerblue4") +
      geom_col(data = data_agg1 %>% filter(major_category == "Computer, Engineering, and Science"), fill = "firebrick") +
      labs(title = glue("Gap earnings on male and female {input$year}"),
           x = NULL,
           y = NULL) +
      scale_y_discrete(labels = wrap_format(30)) +
      scale_x_continuous(labels = dollar_format(),
                         breaks = seq(0,12000,5000)) +
      theme_algoritma
    
    ggplotly(plot_ranking, tooltip = "text")
    
  })
  
  output$plot_corr <- renderPlotly({
    
    
    plot_dist <- workers_clean %>% 
      ggplot(aes_string(x = "total_earnings_male", 
                        y = input$yvar %>% 
                          str_to_lower() %>% str_replace_all(" ", "_"))) +
      geom_jitter(aes(col = major_category,
                      text = glue("{str_to_upper(major_category)}
                         Earnings Male: {total_earnings_male}
                         Earnings Female: {total_earnings_female}"))) +
      geom_smooth() +
      labs(y = glue("{input$yvar}"),
           x = "Total Earnings Male",
           title = "Distribution of Plot Earnings") +
      scale_color_brewer(palette = "Set3") +
      theme_algoritma +
      theme(legend.position = "none")
    
    ggplotly(plot_dist, tooltip = "text")
  })
  
  output$data_workers <- renderDataTable({
    DT::datatable(data = workers_clean, options = list(scrollX = T))
  })
  
  
  
}