### S2 Trends Plot(s) ----

## Health Board selector ---- 

output$S2_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "S2_trendPlot_hbName",
      label = "Select NHS Health Board:",
      choices = S2_hb_names,
      selected = "NHS Scotland")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
S2_trendPlot_data <- reactive({
   S2_data %>%
      filter(hb_name %in% input$S2_trendPlot_hbName)
})


# Create the S2 line chart ----

### Render plotly ----

output$S2_trendPlot <- renderPlotly({ 
   
   ### Create reactive ggplot graph ----
   
   S2_plot_graph <- reactive ({
      
      
      
      
      
      
   })
   
   ### Run ggplot graph through plotly ----
   
   ggplotly(S2_plot_graph(),
            tooltip = "text") %>%        # uses text set up in ggplot aes above. 
      ### Remove unnecessary buttons from the modebar ----
   config(displayModeBar = TRUE,
          modeBarButtonsToRemove = bttn_remove,
          displaylogo = F, editable = F)
   
   
})



### Table below graph ----

output$S2_table <- renderDataTable({
   datatable(S2_trendPlot_data(),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("Year Quarter",
                          "Health Board",
                          "XX Value XX"))
})

# Create download button that allows users to download tables in .csv format.
output$S2_table_download <- downloadHandler(
   filename = 'S2 - Discharge followed up.csv',
   content = function(file) {
      write.table(S2_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Year Quarter",
                                "Health Board",
                                "XX Value XX"),
                  sep = ",")
   })