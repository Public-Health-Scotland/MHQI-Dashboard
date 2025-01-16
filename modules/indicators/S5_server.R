### S5 Trends Plot(s) ----

## Health Board selector ---- 

output$S5_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "S5_trendPlot_hbName",
      label = "Select NHS Health Board:",
      choices = S5_hb_names,
      selected = "NHS Scotland")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
S5_trendPlot_data <- reactive({
   S5_data %>%
      filter(hb_name %in% input$S5_trendPlot_hbName)
})


# Create the S5 line chart ----

### Render plotly ----

output$S5_trendPlot <- renderPlotly({ 
   
   ### Create reactive ggplot graph ----
   
   S5_plot_graph <- reactive ({
      
      
      
      
      
      
   })
   
   ### Run ggplot graph through plotly ----
   
   ggplotly(S5_plot_graph(),
            tooltip = "text") %>%        # uses text set up in ggplot aes above. 
      ### Remove unnecessary buttons from the modebar ----
   config(displayModeBar = TRUE,
          modeBarButtonsToRemove = bttn_remove,
          displaylogo = F, editable = F)
   
   
})



### Table below graph ----

output$S5_table <- renderDataTable({
   datatable(S5_trendPlot_data(),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("Year Quarter",
                          "Health Board",
                          "XX Value XX"))
})

# Create download button that allows users to download tables in .csv format.
output$S5_table_download <- downloadHandler(
   filename = 'S5 - Physical violence.csv',
   content = function(file) {
      write.table(S5_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Year Quarter",
                                "Health Board",
                                "XX Value XX"),
                  sep = ",")
   })