# EQ4 Trends Plot(s) ----

# Graphs: 
# 1.Bar chart showing total admissions and non CAMHs admissions at Scotland level 
# 2. HB trend graph - user selects up to 4 HBs to compare percentage of non camhs admissions

# Graph 1 - Scotland figures plot ----
output$EQ4_plot1 <- renderPlotly({
  
  EQ4_scot <- EQ4_data %>%
    filter(board == "NHS Scotland")
  
  create_grouped_bar_plot(
    data = EQ4_scot,
    x_column = "quarter_end",
    y1_column = "total_non_camhs",
    y2_column = "total_u18",
    y1_name = "Admissions outwith CAMHS",
    y2_name = "Total admissions"
  )
  
})


# table below chart including HB ----
# Reactive expression for filtered & formatted data
EQ4_scot_table <- reactive({
  
  EQ4_data %>%
    filter(board == "NHS Scotland") %>%
    select("Board" = "board",
           "Quarter" = "quarter_end",
           "Admissions outwith CAMHs" = "total_non_camhs",
           "Total Admissions" = "total_u18")
})

# Render the table
output$EQ4_table1 <- DT::renderDataTable({
  DT::datatable(
    EQ4_scot_table(),
    style = "bootstrap",
    class = "table-bordered table-condensed",
    rownames = FALSE,
    options = list(
      pageLength = 16,
      autoWidth = FALSE,
      dom = "tip",
      columnDefs = list(
        list(className = "dt-right", targets = 1:3)
      )
    )
  )
})

# Download handler for filtered data
output$download_EQ4_table1 <- downloadHandler(
  filename = "EQ4 - Admissions outwith camhs.csv",
  content = function(file) {
    # Get filtered data
    df <- EQ4_scot_table()
    
    # Validate data before writing
    if (nrow(df) == 0) {
      stop("No data available to download.")
    }
    
    # Write CSV with renamed columns
    write.csv(df, file, row.names = FALSE)
  }
)


# Graph 2 - comparing HBs over time ---- 

## Health Board Selector ---- 
# Picker for user selecting up to 4 health boards
output$EQ4_trendPlot_hbName_output <- renderUI({
  create_hb_picker(
    input_id = "EQ4_trendPlot_hbName",
    choices = EQ4_data$board,
    selected = "NHS Scotland")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EQ4_trendPlot_data <- reactive({
  req(input$EQ4_trendPlot_hbName)
  
  EQ4_data %>%
    select(board, quarter_end, perc) %>% 
    filter(board %in% input$EQ4_trendPlot_hbName)
})


## Create the EF2 line chart ----

### Render plotly ----
output$EQ4_plot2 <- renderPlotly({
  create_trend_plot(
    data = EQ4_trendPlot_data(),
    x_column = "quarter_end",
    y_column = "perc",
    group_column = "board",
    y_axis_title = "Percentage of admissons outwith CAMH wards",
    tooltip_value_title = "Percentage of admissons outwith CAMH wards",
    tooltip_value_comma = FALSE,
        tooltip_suffix = "%",
    x_axis_title = "Quarter")
})
 

## Table below graph 2 ----
output$EQ4_table2 <- renderDataTable({
  datatable(
    EQ4_trendPlot_data() %>% 
      mutate(perc = paste0(formatC(perc,
                                   format = "f",
                                   #digits after decimal point
                                   digits = 1), "%")
      ),
    style = 'bootstrap',
    class = 'table-bordered table-condensed',
    rownames = FALSE,
    options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                   # Right align numeric columns - it's columns 4:5 but use 3:4 as rownames = FALSE
                   columnDefs = list(list(className = 'dt-right', targets = 2))), 
    colnames = c("Health Board",
                 "Quarter",
                 "Percentage of Admissons outwith CAMH wards"))
})


## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$download_EQ4_table2 <- downloadHandler(
  filename = 'EQ4 - Percentage of admissions outwith CAMHS.csv',
  content = function(file) {
    write.table(EQ4_trendPlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("NHS Health Board",
                              "Quarter",
                              "Percentage of Admissons outwith CAMH wards"),
                sep = ",")
  })