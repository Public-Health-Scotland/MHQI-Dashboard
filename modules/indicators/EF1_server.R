# EF1 Trends Plot(s) ----

# Two Graphs: 
# 1. HB trend graph - user selects up to 4 HBs to compare rate of emergency bed days per 100,000 over time
# 2. Measure graph for quarter - user selects calendar quarter to compare rates. 

# Tables: 
# Graphs show incidents per 1000 bed days, but tables also include "total bed days" and 
# "no. of incidents"


# Graph 1 - comparing HBs over time ---- 
## Health Board Selector ---- 
# Picker for user selecting up to 4 health boards
output$EF1_trendPlot_hbName_output <- renderUI({
  
  create_hb_picker(
    input_id = "EF1_trendPlot_hbName",
    choices = EF1_data$hb_name,
    selected = "NHS Scotland"
  )
  
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EF1_trendPlot_data <- reactive({
  EF1_data %>%
    filter(hb_name %in% input$EF1_trendPlot_hbName)
})


## Create the EF1 line chart ----
### Render plotly ----
output$EF1_trendPlot <- renderPlotly({
  
  create_trend_plot(
    data = EF1_trendPlot_data(),
    
    x_column = "year_months",
    y_column = "bedday_rate",
    group_column = "hb_name",
    
    y_axis_title = "Emergency psychiatric bed days per 100,000 population",
    tooltip_value_title = "Emergency psychiatric bed days per 100,000 population",
    tooltip_suffix = "",
    
    x_axis_title = "Quarter"
  )
  
})


## Table below graph 1 ----
output$EF1_1_table <- renderDataTable({
  datatable(EF1_trendPlot_data() %>% 
              # Add "NA" as a value to table on dashboard:
              #mutate(bedday_rate, ~replace(., is.na(.), 0)) %>% 
              # Add commas to large values but keep "NA" or "*" character values:
              mutate(bedday_rate = if_else(is.na(bedday_rate),
                                                        "NA", 
                                                        formatC(bedday_rate,
                                                                format = "f",
                                                                digits = 2, # digits after decimal point
                                                                big.mark =","))),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                           # Right align numeric columns - it's columns 3:5 but use 2:4 as rownames = FALSE
                           columnDefs = list(list(className = 'dt-right', targets = 2))), 
            colnames = c("NHS Health Board",
                         "Quarter",
                         "Emergency psychiatric bed days per 100,000 population"))
})

## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$EF1_1_table_download <- downloadHandler(
  filename = 'EF1 - Rate of emergency bed days for adults in psychiatric hospital beds.csv',
  content = function(file) {
    write.table(EF1_trendPlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("NHS Health Board",
                              "Quarter",
                              "Emergency psychiatric bed days per 100,000 population"),
                sep = ",")
  })


# Graph 2 - All HBs incidents by Quarter ----
## Picker for user selecting Quarter ----
output$EF1_plot2_quarter_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF1_plot2_quarter",
    label = "Select quarter:",
    choices = unique(EF1_data$year_months),
    selected = "Apr-Jun 2026")
})

## Selecting appropriate data for graph 2 ---- 
EF1_plot2_data <- reactive({
  EF1_data %>%
    filter(year_months %in% input$EF1_plot2_quarter) %>% 
    # for ordering graph by value:
    mutate(hb_name = fct_reorder(hb_name, bedday_rate, 
                                          .na_rm = FALSE)) %>% # This row is required or crashes    # For adding "NA" annotation to graph: 
    mutate(graph_value = if_else(is.na(bedday_rate), 
                                 0, bedday_rate), 
           graph_value_label = if_else(is.na(bedday_rate), 
                                       "NA", as.character(bedday_rate)))
})   

## Selecting appropriate data for table 2 ---- 
EF1_plot2_data_for_table <- reactive({
  EF1_data %>%
    filter(year_months %in% input$EF1_plot2_quarter)
})

## Graph 2 title ----
output$EF1_plot2_title <- renderUI({
  
  req(input$EF1_plot2_quarter)
  
  paste0("Rate of emergency psychiatric bed days for adults (per 100,000 population), by ", 
         "NHS health board, in ", input$EF1_plot2_quarter)
})

## Create the bar chart ----
output$EF1_plot2 <- renderPlotly({
  
  create_bar_plot(
    data = EF1_plot2_data(),
    
    x_column = "graph_value",
    y_column = "hb_name",
    
    board_column = "hb_name",
    
    x_axis_title = "Emergency psychiatric bed days per 100,000 population",
    y_axis_title = "",
    
    tooltip_1_column = "year_months",
    tooltip_1_title = "Quarter",
    
    tooltip_2_column = "hb_name",
    tooltip_2_title = "Health board",
    
    tooltip_3_column = "graph_value_label",
    tooltip_3_title = "Emergency psychiatric bed days per 100,000 population",
    tooltip_3_suffix = "",
    
    graph_height = 600
  )
  
})


## Table for graph 2 ----
output$EF1_2_table <- renderDataTable({
  datatable(
    EF1_plot2_data_for_table() %>% 
      # Add "NA" as a value to table on dashboard:
      #mutate(bedday_rate, ~replace(., is.na(.), 0)) %>% 
      # Add commas to large values but keep "NA" or "*" character values:
      mutate(bedday_rate = if_else(is.na(bedday_rate),
                                   "NA", 
                                   formatC(bedday_rate,
                                           format = "f",
                                           digits = 2, # digits after decimal point
                                           big.mark =","))),
    style = 'bootstrap', 
    class = 'table_bordered table-condensed',
    rownames = FALSE, 
    options = list(
      pageLength = 16, 
      autoWidth = FALSE, 
      dom = 'tip', 
      # Right align numeric columns - it's columns 3:5 but use 2:4 as rownames = FALSE
      columnDefs = list(list(className = 'dt-right', targets = 2))),
    colnames = c("NHS Health Board",
                 "Quarter",
                 "Emergency psychiatric bed days per 100,000 population")
  )
})

## Graph 2 data download button ----
# Allows users to the download tables in .csv format ----
output$EF1_2_table_download <- downloadHandler(
  filename = 'EF1 - Rate of emergency bed days for adults in psychiatric hospital beds.csv', 
  content = function(file) {
    write.table(EF1_plot2_data_for_table(),  
                file, 
                row.names = FALSE, 
                col.names = c("NHS Health Board",
                              "Quarter",
                              "Emergency psychiatric bed days per 100,000 population"), 
                sep = ",")
    
  }
)
