# Graph 1 - comparing HBs over time ---- 

## Health Board Selector ---- 
# Picker for user selecting up to 4 health boards
output$EF3_trendPlot_hbName_output <- renderUI({
    create_hb_picker(
    input_id = "EF3_trendPlot_hbName",
    choices = EF3_data$hb,
    selected = "NHS Scotland")
  })


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EF3_trendPlot_data <- reactive({
  EF3_data %>%
    select(hb, year, bed_days, rate) %>% 
    filter(hb %in% input$EF3_trendPlot_hbName)
})


## Create the EF3 line chart ----
### Render plotly ----
output$EF3_trendPlot <- renderPlotly({
    create_trend_plot(
    data = EF3_trendPlot_data(),
    x_column = "year",
    y_column = "rate",
    group_column = "hb",
    y_axis_title = "Rate of psychiatric inpatient beds per 100,000 population",
    tooltip_value_title = "Rate of psychiatric inpatient beds per 100,000 population",
    tooltip_suffix = "",
    tooltip_4_column = "bed_days",
    tooltip_4_title = "Average available staffed beds",
    x_axis_title = "Financial Year")
  })


## Table below graph 1 ----
output$EF3_1_table <- renderDataTable({
  datatable(
    EF3_trendPlot_data() %>%
      mutate(
        rate = if_else(
          is.na(rate),
          "NA",
          formatC(
            rate,
            format = "f",
            digits = 1
          )
        )
      ),
    style = 'bootstrap',
    class = 'table-bordered table-condensed',
    rownames = FALSE,
    options = list(
      pageLength = 16,
      autoWidth = FALSE,
      dom = 'tip',
      columnDefs = list(
        list(className = 'dt-right', targets = c(2, 3))
      )
    ),
    colnames = c(
      "Health Board",
      "Financial Year",
      "Average Available Staffed Beds",
      "Rate per 100,000 Population"
    )
  )
})


## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$EF3_1_table_download <- downloadHandler(
  filename = 'EF3 - Total psychiatric inpatient beds per 100,000 population (NRAC adjusted).csv',
  content = function(file) {
    write.table(EF3_trendPlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("NHS Health Board",
                              "Financial Year",
                              "Average Available Staffed Beds",
                              "Rate per 100,000 Population"),
                sep = ",")
  })