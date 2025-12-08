# S5 Trends Plot(s) ----

# Two Graphs: 
# 1. HB trend graph - user selects up to 4 HBs to compare incidents per 1000 bed days over time
# 2. Measure graph for quarter - user selects calendar quarter to compare HB's incidents. 

# Graph 1 - comparing HBs over time ---- 

## Health Board Selector ---- 
# Picker for user selecting up to 4 health boards

output$EF2_trendPlot_hbName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF2_trendPlot_hbName",
    label = "Select NHS health board(s) (Maximum 4):",
    choices = EF2_hb_names,  # pulled out in data_preparation.R
    multiple = TRUE,
    options = list("max-options" = 4,
                   `selected-text-format` = "count > 1"),
    # No Scotland data has been calculated for HB returns indicators: S2, S5, EF5
    selected = "NHS Ayrshire & Arran")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EF2_trendPlot_data <- reactive({
  EF2_data %>%
    select(Board, year_months, x28_days_readmission_rate_percentage_quarter) %>% 
    filter(Board %in% input$EF2_trendPlot_hbName)
})


## Create the EF2 line chart ----

### Render plotly ----

output$EF2_trendPlot <- renderPlotly({ 
    EF2_plot1_plotly <- plot_ly(data = EF2_trendPlot_data(), 
                             
                             x = ~year_months, 
                             y = ~x28_days_readmission_rate_percentage_quarter, 
                             color = ~Board, 
                             
                             # Tooltip text
                             text = paste0("Calendar quarter: ",                
                                           EF2_trendPlot_data()$year_months, 
                                           "<br>",
                                           "Health board: ",
                                           EF2_trendPlot_data()$Board,
                                           "<br>",
                                           "Percentage of Readmissions: ",
                                           EF2_trendPlot_data()$x28_days_readmission_rate_percentage_quarter), 
                             hoverinfo = "text", 
                             
                             # Line aesthetics: 
                             type = 'scatter',
                             mode = 'lines+markers', 
                             line = list(width = 3), 
                             colors = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
                             linetype = ~Board, 
                             linetypes = c("solid", "dashed", "solid", "dashed"), 
                             symbol = ~Board,
                             symbols = c("circle", "square", "triangle-up", "triangle-down"),
                             marker = list(size = 12),
                             # Size of graph:
                             height = 600,
                             # Legend info:
                             name = ~str_wrap(Board, 15)) %>%
    
    layout(# graph title is in a box above the graph and Orkney/Shetland 
      # reminder title is below this code. 
      yaxis = list(exponentformat = "none",
                   separatethousands = TRUE,  # it's per 1,000 so do we need to do this? 
                   range = c(0, max(EF2_trendPlot_data()$x28_days_readmission_rate_percentage_quarter, na.rm = TRUE) * 1.3), 
                   
                   
                   # Wrap the y axis title in spaces so it doesn't cover the tick labels.
                   title = paste0(c(rep("&nbsp;", 20),
                                    print("Percentage of Readmissions"), 
                                    rep("&nbsp;", 20),
                                    rep("\n&nbsp;", 3)),
                                  collapse = ""),#),
                   showline = TRUE, 
                   ticks = "outside"
      ),
      
      xaxis = list(tickangle = -45,                    # Diagonal x-axis ticks
                   title = paste0(c(rep("&nbsp;", 20),
                                    "<br>",
                                    "<br>",
                                    "Calendar quarter",
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
      legend = list(x = 1, 
                    y = 0.8, 
                    bgcolor = 'rgba(255, 255, 255, 0)', 
                    bordercolor = 'rgba(255, 255, 255, 0)')) %>%
    
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
  EF2_plot1_plotly  
  
})


## Table below graph 1 ----
output$EF2_1_table <- renderDataTable({
  datatable(EF2_trendPlot_data() %>% 
              # Add commas to large numbers but keep "NA" as a visible value on dashboard:
              mutate(x28_days_readmission_rate_percentage_quarter = if_else(is.na(x28_days_readmission_rate_percentage_quarter), 
                                           "NA", 
                                           formatC(x28_days_readmission_rate_percentage_quarter,
                                                   format = "f",
                                                  digits = 1, # digits after decimal point
                                                   big.mark =","))),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                           # Right align numeric columns - it's columns 4:5 but use 3:4 as rownames = FALSE
                           columnDefs = list(list(className = 'dt-right', targets = 2))), 
            colnames = c("Health Board",
                         "Financial Year",
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
                              "Calendar Quarter",
                              "Percentage of Readmissions"),
                sep = ",")
  })

# PLOT 2 ----
# Graph 2 - All HBs incidents by Quarter ----


## Picker for user selecting Quarter ----
output$EF2_plot2_quarter_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF2_plot2_quarter",
    label = "Select calendar quarter:",
    choices = unique(EF2_data$year_months),
    selected = "Jul-Sep 2025")
})

## Selecting appropriate data for graph 2 ---- 

EF2_plot2_data <- reactive({
  EF2_data %>%
    filter(year_months %in% input$EF2_plot2_quarter) %>% 
    # for ordering graph by value:
    mutate(Board = fct_reorder(Board, x28_days_readmission_rate_percentage_quarter, 
                                 .na_rm = FALSE)) %>%  # This row is required or crashes
    # For adding "NA" annotation to graph: 
    mutate(graph_value = if_else(is.na(x28_days_readmission_rate_percentage_quarter), 
                                 0, x28_days_readmission_rate_percentage_quarter), 
           graph_value_label = if_else(is.na(x28_days_readmission_rate_percentage_quarter), 
                                       "NA", as.character(x28_days_readmission_rate_percentage_quarter)))
}) 

## Selecting appropriate data for table 2 ---- 
EF2_plot2_data_for_table <- reactive({
  EF2_data %>%
    #select(!"year_months") %>% 
    #select(!c("year_months")) %>%  
    filter(year_months %in% input$EF2_plot2_quarter)
})


## Graph 2 title ----
output$EF2_plot2_title <- renderUI({
  
  req(input$EF2_plot2_quarter)
  
  paste0("Percentage of mental healh emergency readmissions to hosptial within 28 days of discharge, by ", 
         "NHS health board, in ", input$EF2_plot2_quarter)
})


## Create the bar chart ----

output$EF2_plot2 <- renderPlotly({
  
  # Assigning to an object so can add "NA" annotations after: 
  EF2_plotly_graph2 <- plot_ly(data = EF2_plot2_data(),
                               x = ~graph_value,
                               y = ~Board,
                               # Tooltip text: 
                               text = paste0("Calendar quarter: ", EF2_plot2_data()$year_months,        
                                             "<br>",
                                             "Health board: ", EF2_plot2_data()$Board,
                                             "<br>",
                                             "Percentage of Readmissions: ", EF2_plot2_data()$graph_value_label), 
                               hoverinfo = "text", 
                               
                               # Bar aesthetics:
                               type = 'bar', 
                               marker = list(color = '#0078D4', 
                                             size = 12), 
                               textposition = "none", # removes small text on each bar
                               # Size of graph: 
                               height = 600) %>% 
    
    layout(font = list(size = 13), 
           yaxis = list(title = "",  # set as an empty string as is not needed
                        exponentformat = "none",
                        showline = TRUE, 
                        ticks = "outside"), 
           # Wrap the x axis title in spaces so it doesn't cover the tick labels.
           xaxis = list(title = paste0(c(rep("&nbsp;", 20),
                                         "<br>",
                                         "<br>",
                                         "Percentage of Readmissions", 
                                         rep("&nbsp;", 20),
                                         rep("\n&nbsp;", 3)),
                                       collapse = ""),
                        range = c(0, max(EF2_plot2_data()$x28_days_readmission_rate_percentage_quarter, na.rm = TRUE) * 1.2), 
                        # re: range - "*1.2" is showing the final tick on the axis for all quarters (in April 2025 release) 
                        showline = TRUE, 
                        ticks = "outside"),
           # Set graph margins:
           margin = list(l = 90, r = 60, b = 170, t = 90)) %>%
    
    # Remove any buttons we don't need from the modebar:
    config(displayModeBar = TRUE,
           modeBarButtonsToRemove = list('select2d', 'lasso2d', 
                                         # 'zoomIn2d', 'zoomOut2d', 'autoScale2d', 
                                         'toggleSpikelines', 
                                         'hoverCompareCartesian', 
                                         'hoverClosestCartesian'), 
           displaylogo = F, editable = F)
  # Add annotations for the "NA" labels at the appropriate positions
  for (i in 1:nrow(EF2_plot2_data())) {
    
    if (is.na(EF2_plot2_data()$x28_days_readmission_rate_percentage_quarter[i])) {
      
      EF2_plotly_graph2 <- EF2_plotly_graph2 %>%
        add_annotations(
          # Position on x-axis: (if you use x = 0 the x axis goes into minus 
          # values as the position of "NA" is from its center)
          # Big variation in some graphs - below values work on small screens, 
          # would prefer closer to y axis on bigger screens though...
          x = case_when(max(EF2_plot2_data()$graph_value) < 30 ~ 0.5, 
                        max(EF2_plot2_data()$graph_value) <= 50 ~ 1,
                        max(EF2_plot2_data()$graph_value) > 50 ~ 3), 
          y = EF2_plot2_data()$Board[i],  # Position according to the correct category
          text = "NA",  # The text to display
          showarrow = FALSE,  # No arrow pointing to the text
          font = list(size = 13, 
                      color = "black"))
    }
  }
  
  # Run plotly graph with added NA annotations:
  EF2_plotly_graph2
  
})

## Table for graph 2 ----

output$EF2_2_table <- renderDataTable({
  datatable(
    EF2_plot2_data_for_table() %>% 
      # Add "NA" as a value to table on dashboard:
      #mutate(bedday_rate, ~replace(., is.na(.), 0)) %>% 
      # Add commas to large values but keep "NA" or "*" character values:
      mutate(x28_days_readmission_rate_percentage_quarter = if_else(is.na(x28_days_readmission_rate_percentage_quarter),
                                   "NA", 
                                   formatC(x28_days_readmission_rate_percentage_quarter,
                                           format = "f",
                                           digits = 1, # digits after decimal point
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
                 "Calendar Quarter",
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
                              "Calendar Quarter",
                              "Percentage of Readmmissions"), 
                sep = ",")
    
  }
)
