### EF5 Trends Plot(s) ----

## Health Board selector ---- 

output$EF5_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "EF5_trendPlot_hbName",
      label = "Select NHS Health Board:",
      choices = EF5_hb_names,
      selected = "NHS Scotland")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EF5_trendPlot_data <- reactive({
   EF5_data %>%
      filter(hb_name %in% input$EF5_trendPlot_hbName)
})


# Create the EF5 line chart ----

### Render plotly ----

output$EF5_trendPlot <- renderPlotly({ 
   
   ### Create reactive ggplot graph ----
   
   EF5_plot_graph <- reactive ({
      
      
      
      
      
      
   })
   
   ### Run ggplot graph through plotly ----
   
   ggplotly(EF5_plot_graph(),
            tooltip = "text") %>%        # uses text set up in ggplot aes above. 
      ### Remove unnecessary buttons from the modebar ----
   config(displayModeBar = TRUE,
          modeBarButtonsToRemove = bttn_remove,
          displaylogo = F, editable = F)
   
   
   })



### Table below graph ----

output$EF5_table <- renderDataTable({
   datatable(EF5_trendPlot_data(),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("Year Quarter",
                          "Health Board",
                          "XX Value XX"))
})

# Create download button that allows users to download tables in .csv format.
output$EF5_table_download <- downloadHandler(
   filename = 'EF5 - Did not attend.csv',
   content = function(file) {
      write.table(EF5_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Year Quarter",
                          "Health Board",
                          "XX Value XX"),
                  sep = ",")
      })