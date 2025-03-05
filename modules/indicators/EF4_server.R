### EF4 Trends Plot ----

## Health Board selector ----
output$EF4_trendPlot_hbName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF4_trendPlot_hbName",
    label = "Select NHS health board:",
    choices = EF4_hb_names,
    selected = "NHS Scotland")
})

## Measure selector ----
output$EF4_trendPlot_measure_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF4_trendPlot_measure",
    label = "Select measure(s):",
    choices = EF4_trend_measures,
    selected = "Mental Health Expenditure (%)",
    multiple = TRUE)
})

## Graph Data Reactive ---- 
# to create graph data based on HB and Measure selection
EF4_trendPlot_data <- reactive({
  EF4_data %>%
    filter(hb_name %in% input$EF4_trendPlot_hbName &
           measure %in% input$EF4_trendPlot_measure)
})



# Create the EF4 line chart ----

 ### Render plotly ----

 output$EF4_trendPlot <- renderPlotly({

  ### Create reactive ggplot graph ----

    EF4_plot_graph <- reactive ({

       ggplot(data = EF4_trendPlot_data(),
              aes(x = fyear,
                  y = value,
                  text = paste0("Financial Year: ",         # for tooltip in ggplotly - shows values on hover
                                EF4_trendPlot_data()$fyear,
                                "<br>",
                                "Health Board: ",
                                EF4_trendPlot_data()$hb_name,
                                "<br>",
                                EF4_trendPlot_data()$measure,": ",
                                EF4_trendPlot_data()$value))) +
          geom_line() +
          geom_point(size = 2.5) +
          aes(group = measure,            # Have to do this outside so that the legends shows and so that there aren't 3 legends
              linetype = measure,
              color = measure,
              shape = measure) +
          scale_color_discrete_phs(name = "Measure Name",
                                   palette = "main-blues",
                                   labels = ~ stringr::str_wrap(.x, width = 15)) + # this isn't working - trying to wrap the legend text
          # scale_color_manual(name = "Measure Name",
          #                    values = c("#0078D4", "#3393DD"),               # colour for lines
          #                   labels = ~ stringr::str_wrap(.x, width = 15)) +  
          scale_linetype_manual(name = "Measure Name",               # have to add it into each one or the legend duplicates
                                values = c("solid", "dashed"),
                                labels = ~ stringr::str_wrap(.x, width = 15)) +
          scale_shape_manual(name = "Measure Name",
                             values = c("circle", "triangle-up"),         # shape for points
                             labels = ~ stringr::str_wrap(.x, width = 15)) +   # this isn't working - trying to wrap the legend text
          theme_classic()+
          theme(panel.grid.major.x = element_line(),         # Shows vertical grid lines
                panel.grid.major.y = element_line(),         # Shows horizontal grid lines
                axis.title.x = element_text(size = 12,
                                            color = "black",
                                            face = "bold"),
                axis.text.x = element_text(angle = 25),
                axis.title.y = element_text(size = 12,
                                            color = "black",
                                            face = "bold"),
                legend.text = element_text(size = 8,
                                           colour = "black"),
                legend.title = element_text(size = 9,
                                            colour = "black",
                                            face = "bold")) +
        #  guides(fill = guide_legend(label.theme = element_text(size = 10, lineheight = 0.8))) + # Trying to wrap the legend text
          labs(x = "Financial Year",
               y = "Percentage (%)") +
          scale_y_continuous(expand = c(0, 0),           # y axis will always start from zero
                             limits = c(0, (max(EF4_trendPlot_data()$value)
                                            + 0.5*max(EF4_trendPlot_data()$value)))) # maximum y axis value should always show

    })


 ### Run ggplot graph through plotly ----

    ggplotly(EF4_plot_graph(),
             tooltip = "text") %>%        # uses text set up in ggplot aes above. 
    ### Remove unnecessary buttons from the modebar ----
    config(displayModeBar = TRUE,
           modeBarButtonsToRemove = bttn_remove,
           displaylogo = F, editable = F)

 })



 ### Table below graph ----
 
  output$EF4_table <- renderDataTable({
    datatable(EF4_trendPlot_data(),
              style = 'bootstrap',
              class = 'table-bordered table-condensed',
              rownames = FALSE,
              options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
              colnames = c("Financial year",
                           "Health Board",
                           "Measure Name",
                           "Value"))
  })
 
  # Create download button that allows users to download tables in .csv format.
  output$EF4_table_download <- downloadHandler(
    filename = 'EF4 - Mental health spend.csv',
    content = function(file) {
      write.table(EF4_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Financial year",
                                "Health Board",
                                "Measure Name",
                                "Value"),
                  sep = ",")
    }
  )
  
  
