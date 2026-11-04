# EF4 ---- 

# One Graph: User selects HB and measure(s) (MH expend % and/or CAMHS expend %) 
# to see changes over time. 

# One Table: Financial year, HB, Measure Name, Value (%)
# EF4 Trends Plot ----
## Health Board selector ----
output$EF4_trendPlot_hbName_output <- renderUI({
    create_hb_picker(
    input_id = "EF4_trendPlot_hbName",
    choices = EF4_data$hb_name,
    selected = "NHS Scotland")
})

## Measure selector ----
output$EF4_trendPlot_measure_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF4_trendPlot_measure",
    label = "Select measure(s):",
    choices = EF4_trend_measures,
    selected = "Mental Health Expenditure",
    multiple = TRUE)
})

## Graph title ----
output$EF4_trendPlot_title <- renderUI({
  
  # Measures section
  req(input$EF4_trendPlot_measure)
  
  EF4_selected_measures <- input$EF4_trendPlot_measure
  
  EF4_measure_text <- if (length(EF4_selected_measures) == 1) {
    EF4_selected_measures
  } else if (length(EF4_selected_measures) == 2) {
    paste(EF4_selected_measures, collapse = " and ")
  } else {
    paste(
      paste(EF4_selected_measures[-length(EF4_selected_measures)], collapse = ", "),
      "and", 
      EF4_selected_measures[length(EF4_selected_measures)]
    )
  }
  
  # HB section
  req(input$EF4_trendPlot_hbName)
  paste0("Percentage of total spend attributed to ", EF4_measure_text, 
         ", by financial year, in ", input$EF4_trendPlot_hbName)
  
})

## Graph Data Reactive ---- 
# to create graph data based on HB and Measure selection
EF4_trendPlot_data <- reactive({
  EF4_data %>%
    select(-year_month) %>% 
    filter(hb_name %in% input$EF4_trendPlot_hbName &
           measure %in% input$EF4_trendPlot_measure )
})


## Create the EF4 line chart ----
 ### Render plotly ----
output$EF4_trendPlot <- renderPlotly({
  create_trend_plot1(
    data = EF4_trendPlot_data(),
    x_column = "fyear",
    y_column = "value",
    group_column = "measure",
    x_axis_title = "Financial Year",
    y_axis_title = "Percentage (%)",
    group_title = NULL,
    tooltip_value_title = NULL,
    tooltip_suffix = "% of board's total spend",
    tooltip_4_column = "hb_name",
    tooltip_4_title = "Health Board"
  )
  
})


## Table below graph ----
    output$EF4_table <- renderDataTable({
    datatable(EF4_trendPlot_data() %>% 
                 mutate(value = sprintf("%.2f%%", value)),
              style = 'bootstrap',
              class = 'table-bordered table-condensed',
              rownames = FALSE,
              options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                             # Right align numeric column - it's columns 4 but use 3 as rownames = FALSE
                             columnDefs = list(list(className = 'dt-right', targets = 3))),
              colnames = c("Financial Year",
                           "Health Board",
                           "Measure Name",
                           "Percentage of Board's Total Expenditure"))
  })
 
  # Create download button that allows users to download tables in .csv format.
  output$EF4_table_download <- downloadHandler(
    filename = 'EF4 - Mental health spend.csv',
    content = function(file) {
      write.table(EF4_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Financial Year",
                                "Health Board",
                                "Measure Name",
                                "Percentage of Board's Total Expenditure"),
                  sep = ",")
    }
  )
  