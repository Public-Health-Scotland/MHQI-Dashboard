# EF2 Trends Plot(s) ----

# Two Graphs: 
# 1. HB trend graph - user selects up to 4 HBs to compare readmissions over time
# 2. Measure graph for quarter - user selects calendar quarter to compare HB's incidents. 

# Graph 1 - comparing HBs over time ---- 

## Health Board Selector ---- 
# Picker for user selecting up to 4 health boards
output$EF2_trendPlot_hbName_output <- renderUI({
  
  create_hb_picker(
    input_id = "EF2_trendPlot_hbName",
    choices = EF2_data$Board,
    selected = "NHS Scotland"
  )
  
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EF2_trendPlot_data <- reactive({
  EF2_data %>%
    select(Board, year_months, x28_days_readmission_rate_percentage_quarter) %>% 
    filter(Board %in% input$EF2_trendPlot_hbName)
})


## Create the EF2 line chart ----
# Render plotly ----
output$EF2_trendPlot <- renderPlotly({
  
  create_trend_plot(
    data = EF2_trendPlot_data(),
    
    x_column = "year_months",
    y_column = "x28_days_readmission_rate_percentage_quarter",
    group_column = "Board",
    
    y_axis_title = "Percentage of Readmissions",
    tooltip_value_title = "Percentage of readmissions",
    tooltip_suffix = "%",
    
    x_axis_title = "Quarter"
  )
  
})


## Table below graph 1 ----
output$EF2_1_table <- renderDataTable({
  datatable(EF2_trendPlot_data() %>% 
              # Add commas to large numbers but keep "NA" as a visible value on dashboard:
              mutate(
                x28_days_readmission_rate_percentage_quarter = if_else(
                  is.na(x28_days_readmission_rate_percentage_quarter),
                  "NA",
                  paste0(
                    formatC(
                      x28_days_readmission_rate_percentage_quarter,
                      format = "f",
                      digits = 1,
                      big.mark = ","
                    ),
                    "%"
                  )
                )
              ),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                           # Right align numeric columns - it's columns 4:5 but use 3:4 as rownames = FALSE
                           columnDefs = list(list(className = 'dt-right', targets = 2))), 
            colnames = c("Health Board",
                         "Quarter",
                         "Percentage of Readmissions"))
})



## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$EF2_1_table_download <- downloadHandler(
  filename = 'EF2 - Percentage of readmissions.csv',
  content = function(file) {
    write.table(EF2_trendPlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("NHS Health Board",
                              "Quarter",
                              "Percentage of Readmissions"),
                sep = ",")
  })

# PLOT 2 ----
# Graph 2 - All HBs incidents by Quarter ----
## Picker for user selecting Quarter ----
output$EF2_plot2_quarter_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF2_plot2_quarter",
    label = "Select quarter:",
    choices = unique(EF2_data$year_months),
    selected = "Apr-Jun 2026")
})

## Selecting appropriate data for graph 2 ---- 
EF2_plot2_data <- reactive({
    EF2_data %>%
    filter(year_months %in% input$EF2_plot2_quarter) %>%
    # for ordering graph by value:
    mutate(Board = fct_reorder(Board, x28_days_readmission_rate_percentage_quarter,
                                 .na_rm = FALSE)) %>% # This row is required or crashes
    mutate(to_highlight = if_else(Board == "NHS Scotland", # for highlighting NHS Scotland
                                  "#3F3685", "#0078D4"))  %>%
    # For adding "NA" annotation to graph:
    mutate(graph_value = if_else(is.na(x28_days_readmission_rate_percentage_quarter),
                                 0, x28_days_readmission_rate_percentage_quarter),
           graph_value_label = if_else(is.na(x28_days_readmission_rate_percentage_quarter),
                                       "NA", as.character(x28_days_readmission_rate_percentage_quarter)))
})



## Selecting appropriate data for table 2 ---- 
EF2_plot2_data_for_table <- reactive({
  EF2_data %>%
     filter(year_months %in% input$EF2_plot2_quarter)
})


## Graph 2 title ----
output$EF2_plot2_title <- renderUI({
  
  req(input$EF2_plot2_quarter)
  
  paste0("Percentage of mental health emergency readmissions to hosptial within 28 days of discharge, by ", 
         "NHS health board, in ", input$EF2_plot2_quarter)
})


## Create the bar chart ----
output$EF2_plot2 <- renderPlotly({
  
  create_bar_plot(
    data = EF2_plot2_data(),
    
    x_column = "graph_value",
    y_column = "Board",
    
    board_column = "Board",
    
    x_axis_title = "Percentage of Readmissions",
    y_axis_title = "",
    
    tooltip_1_column = "year_months",
    tooltip_1_title = "Quarter",
    
    tooltip_2_column = "Board",
    tooltip_2_title = "Health board",
    
    tooltip_3_column = "graph_value_label",
    tooltip_3_title = "Percentage of readmissions",
    tooltip_3_suffix = "%",
    
    graph_height = 600
  )
  
})


## Table for graph 2 ----

output$EF2_2_table <- renderDataTable({
  datatable(
    EF2_plot2_data_for_table() %>% 
      mutate(
        x28_days_readmission_rate_percentage_quarter = if_else(
          is.na(x28_days_readmission_rate_percentage_quarter),
          "NA",
          paste0(
            formatC(
              x28_days_readmission_rate_percentage_quarter,
              format = "f",
              digits = 1,
              big.mark = ","
            ),
            "%"
          )
        )
      ),
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
                 "Percentage of Readmissions")
  )
})

## Graph 2 data download button ----
# Allows users to the download tables in .csv format ----
output$EF2_2_table_download <- downloadHandler(
  filename = 'EF2 - Mental health emergency readmissions to hospital within 28 days of discharge.csv', 
  content = function(file) {
    write.table(EF2_plot2_data_for_table(),  
                file, 
                row.names = FALSE, 
                col.names = c("NHS Health Board",
                              "Quarter",
                              "Percentage of Readmmissions"), 
                sep = ",")
    
  }
)
