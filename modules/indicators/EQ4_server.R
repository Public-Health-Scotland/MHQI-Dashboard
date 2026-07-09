# EQ4 Trends Plot(s) ----

# Graphs: 
# 1.Bar chart showing total admissions and non CAMHs admissions at Scotland level 
# 2. HB trend graph - user selects up to 4 HBs to compare percentage of non camhs admissions

# Graph 1 - Scotland figures ----
output$EQ4_plot1 <- renderPlotly({
  
  EQ4_scot <- EQ4_data %>%
    filter(board == "NHS Scotland")
  
  #Assigning to an object so can add "NA" annotations after: 
  EQ4_plotly_graph1 <- plot_ly(data = EQ4_scot,
                              
                              x = ~quarter_fy, y = ~total_non_camhs, 
                              name = str_wrap("Admissions outwith CAMHs", 26),
                              ## Tooltip text
                              text = paste0(
                                "Financial quarter: ",
                                EQ4_scot$quarter_fy,
                                "<br>",
                                "Number of admissions outwith CAMHs: ", prettyNum(EQ4_scot$total_non_camhs, big.mark = ",")), 
                              hoverinfo = "text",
                              
                              ## Bar aesthetics
                              type = 'bar', 
                              marker = list(color = "#3393DD",
                                            size = 12),
                              textposition = "none", # remove small text on each bar
                              height = 600) %>% # Size of graph
    
    # Add the Total appointments trace
    add_trace(
      y = ~total_u18, 
      name = "Total admissions", 
      marker = list(color = "#B3D7F2"),
      text = paste0(
        "Calendar quarter: ",
        EQ4_scot$quarter_fy,
        "<br>",
        "Total number of admissions: ", prettyNum(EQ4_scot$total_u18, big.mark = ","))) %>% 
    
    layout(
      barmode = 'group', 
      font = list(size = 13), 
      yaxis = list(
        # Wrap the y axis title in spaces so it doesn't cover the tick labels.
        title = paste0(c(rep("&nbsp;", 20),
                         "Number of Admissions", 
                         rep("&nbsp;", 20),
                         rep("\n&nbsp;", 3)),
                       collapse = ""),
        exponentformat = "none",
        
        showline = TRUE, 
        ticks = "outside",
        tickformat=","  # Adds commas for thousands
      ),
      
      # Create diagonal x-axis ticks
      xaxis = list(tickangle = -45, 
                   title = paste0(c(rep("&nbsp;", 20),
                                    "<br>",
                                    "<br>",
                                    "Financial Quarter", 
                                    rep("&nbsp;", 20),
                                    rep("\n&nbsp;", 3)),
                                  collapse = ""),
                   showline = TRUE, 
                   ticks = "outside"),
      # Set the graph margins.
      margin = list(l = 90, r = 60, b = 170, t = 90)) %>%
    
    # Remove any buttons we don't need from the modebar.
    config(displayModeBar = TRUE,
           modeBarButtonsToRemove = list('select2d', 'lasso2d', 
                                         # 'zoomIn2d', 'zoomOut2d', 'autoScale2d', 
                                         'toggleSpikelines', 
                                         'hoverCompareCartesian', 
                                         'hoverClosestCartesian'), 
           displaylogo = F, editable = F)
})

# table below chart including HB ----
# Reactive expression for filtered & formatted data
EQ4_scot_table <- reactive({
  
  EQ4_data %>%
    filter(board == "NHS Scotland") %>%
    select("Board" = "board",
           "Financial Quarter" = "quarter_fy",
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
  shinyWidgets::pickerInput(
    "EQ4_trendPlot_hbName",
    label = "Select NHS health board(s) (Maximum 4):",
    choices = EQ4_hb_names,  # pulled out in data_preparation.R
    multiple = TRUE,
    options = list("max-options" = 4,
                   `selected-text-format` = "count > 1"),
    selected = "NHS Scotland")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EQ4_trendPlot_data <- reactive({
  req(input$EQ4_trendPlot_hbName)
  
  EQ4_data %>%
    select(board, quarter_fy, perc) %>% 
    filter(board %in% input$EQ4_trendPlot_hbName)
})


## Create the EF2 line chart ----

### Render plotly ----

output$EQ4_plot2 <- renderPlotly({ 
  EQ4_plotly_graph2 <- plot_ly(data = EQ4_trendPlot_data(),
                              
                              x = ~quarter_fy, 
                              y = ~perc, 
                              color = ~board, 
                              
                              # Tooltip text
                              text = paste0("Financial quarter: ",                
                                            EQ4_trendPlot_data()$quarter_fy, 
                                            "<br>",
                                            "Health board: ",
                                            EQ4_trendPlot_data()$board,
                                            "<br>",
                                            "Percentage of Admissons outwith CAMH wards: ",
                                            EQ4_trendPlot_data()$perc), 
                              hoverinfo = "text", 
                              
                              # Line aesthetics: 
                              type = 'scatter',
                              mode = 'lines+markers', 
                              line = list(width = 3), 
                              colors = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
                              linetype = ~board, 
                              linetypes = c("solid", "dashed", "solid", "dashed"), 
                              symbol = ~board,
                              symbols = c("circle", "square", "triangle-up", "triangle-down"),
                              marker = list(size = 12),
                              # Size of graph:
                              height = 600,
                              # Legend info:
                              name = ~str_wrap(board, 15)
  ) %>%
    
    layout(# graph title is in a box above the graph and Orkney/Shetland 
      # reminder title is below this code. 
      yaxis = list(exponentformat = "none",
                   range = c(0, max(EQ4_trendPlot_data()$perc, na.rm = TRUE) * 1.3), 
                   
                   
                   # Wrap the y axis title in spaces so it doesn't cover the tick labels.
                   title = paste0(c(rep("&nbsp;", 20),
                                    print("Percentage of Admissons outwith CAMH wards"), 
                                    rep("&nbsp;", 20),
                                    rep("\n&nbsp;", 3)),
                                  collapse = ""),
                   showline = TRUE, 
                   ticks = "outside"
      ),
      
      xaxis = list(tickangle = -45,                    # Diagonal x-axis ticks
                   title = paste0(c(rep("&nbsp;", 20),
                                    "<br>",
                                    "<br>",
                                    "Financial quarter",
                                    rep("&nbsp;", 20),
                                    rep("\n&nbsp;", 3)),
                                  collapse = ""),
                   # For range: we have 12 quarters up to Dec 2024 - this will 
                   # need to be updated when new quarters are added to the code. 
                   # Edit will be to add 1 to the second figure with each new 
                   # quarter (i.e. it will be (-0.5, 12.5) for July 2025 update)
                   # Starting at -0.5 and ending at 11.5 gives much nicer 
                   # spacing on the axis than "0, 12"
                   range = list(-0.5, 15.5),
                   showline = TRUE, 
                   ticks = "outside"),
      
      # Set the graph margins:
      margin = list(l = 90, r = 60, b = 170, t = 90),
      
      # Set the font sizes:
      font = list(size = 13),
      
      # Add a legend so that the user knows which colour, line type...
      # and symbol corresponds to which location of treatment.
      # Make the legend background and legend border white.              
      showlegend = TRUE,
      legend = list(
        x = 1,
        y = 0.8, 
        bgcolor = 'rgba(255, 255, 255, 0)', 
        bordercolor = 'rgba(255, 255, 255, 0)')
    ) %>%
    
    # Remove any buttons we don't need from the modebar.
    config(displayModeBar = TRUE,
           modeBarButtonsToRemove = list('select2d', 'lasso2d', 
                                         # 'zoomIn2d', 'zoomOut2d', 'autoScale2d', 
                                         'toggleSpikelines', 
                                         'hoverCompareCartesian', 
                                         'hoverClosestCartesian'), 
           displaylogo = F, 
           editable = F)
  
  
  ### Return the plot ----
  EQ4_plotly_graph2  
  
})


## Table below graph 2 ----
output$EQ4_table2 <- renderDataTable({
  datatable(
    EQ4_trendPlot_data() %>% 
      mutate(perc = paste0(formatC(perc,
                                   format = "f",
                                   #digits after decimal point
                                   digits = 1), " %")
      ),
    style = 'bootstrap',
    class = 'table-bordered table-condensed',
    rownames = FALSE,
    options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                   # Right align numeric columns - it's columns 4:5 but use 3:4 as rownames = FALSE
                   columnDefs = list(list(className = 'dt-right', targets = 2))), 
    colnames = c("Health Board",
                 "Financial quarter",
                 "Percentage of Admissons outwith CAMH wards"))
})


## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$download_EQ4_table2 <- downloadHandler(
  filename = 'EQ4 - Percentage of admissions outwith camhs.csv',
  content = function(file) {
    write.table(EQ4_trendPlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("NHS Health Board",
                              "Financial quarter",
                              "Percentage of Admissons outwith CAMH wards"),
                sep = ",")
  })
