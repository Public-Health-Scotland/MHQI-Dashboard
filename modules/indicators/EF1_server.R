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
  shinyWidgets::pickerInput(
    "EF1_trendPlot_hbName",
    label = "Select NHS health board(s) (Maximum 4):",
    choices = EF1_hb_names,  # pulled out in data_preparation.R
    multiple = TRUE,
    options = list("max-options" = 4,
                   `selected-text-format` = "count > 1"),
    # No Scotland data has been calculated for HB returns indicators: S2, S5, EF5
    selected = "NHS Ayrshire & Arran")
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
  
  EF1_plot1_plotly <- plot_ly(data = EF1_trendPlot_data(), 
                             
                             x = ~year_months, 
                             y = ~bedday_rate, 
                             color = ~hb_name, 
                             
                             # Tooltip text
                             text = paste0("Calendar quarter: ",                
                                           EF1_trendPlot_data()$year_months, 
                                           "<br>",
                                           "Health board: ",
                                           EF1_trendPlot_data()$hb_name,
                                           "<br>",
                                           "Incidents per 1,000 occupied psychiatric bed days: ",
                                           EF1_trendPlot_data()$bedday_rate), 
                             hoverinfo = "text", 
                             
                             # Line aesthetics: 
                             type = 'scatter',
                             mode = 'lines+markers', 
                             line = list(width = 3), 
                             #colors = c("#12436D", "#28A197", "#801650", "#F46A25"),
                             colors = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
                             linetype = ~hb_name, 
                             linetypes = c("solid", "dashed", "solid", "dashed"), 
                             symbol = ~hb_name,
                             symbols = c("circle", "square", "triangle-up", "triangle-down"),
                             marker = list(size = 12),
                             # Size of graph:
                             height = 600,
                             # Legend info:
                             name = ~str_wrap(hb_name, 15)) %>%
    
    layout(# graph title is in a box above the graph 
      # reminder title is below this code. 
      yaxis = list(exponentformat = "none",
                   separatethousands = TRUE,  # it's per 1,000 so do we need to do this? 
                   range = c(0, max(EF1_trendPlot_data()$bedday_rate, na.rm = TRUE) * 1.3), 
                   
                   
                   # Wrap the y axis title in spaces so it doesn't cover the tick labels.
                   title = paste0(c(rep("&nbsp;", 20),
                                    print("Incidents per 1,000 occupied psychiatric bed days"), 
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
                   range = list(-0.5, 13.5),
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
  EF1_plot1_plotly  
  
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
                         "Calendar Quarter",
                         "Incidents per 1,000 Bed Days"))
})

## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$EF1_1_table_download <- downloadHandler(
  filename = 'EF1 - Incidences of physical violence.csv',
  content = function(file) {
    write.table(EF1_trendPlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("NHS Health Board",
                              "Calendar Quarter",
                              "Incidents per 1,000 Bed Days"),
                sep = ",")
  })


# Graph 2 - All HBs incidents by Quarter ----


## Picker for user selecting Quarter ----

output$EF1_plot2_quarter_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF1_plot2_quarter",
    label = "Select calendar quarter:",
    choices = unique(EF1_data$year_months),
    selected = "Jul-Sep 2025")
})

## Selecting appropriate data for graph 2 ---- 

EF1_plot2_data <- reactive({
  EF1_data %>%
    filter(year_months %in% input$EF1_plot2_quarter) %>% 
    # for ordering graph by value:
    mutate(hb_name = fct_reorder(hb_name, bedday_rate, 
                                          .na_rm = FALSE)) %>%  # This row is required or crashes
    # For adding "NA" annotation to graph: 
    mutate(graph_value = if_else(is.na(bedday_rate), 
                                 0, bedday_rate), 
           graph_value_label = if_else(is.na(bedday_rate), 
                                       "NA", as.character(bedday_rate)))
})   

## Selecting appropriate data for table 2 ---- 
EF1_plot2_data_for_table <- reactive({
  EF1_data %>%
    #select(!"year_months") %>% 
    #select(!c("year_months")) %>%  
    filter(year_months %in% input$EF1_plot2_quarter)
})

## Graph 2 title ----
output$EF1_plot2_title <- renderUI({
  
  req(input$EF1_plot2_quarter)
  
  paste0("Incidents of physical violence per 1,000 occupied psychiatric bed days, by ", 
         "NHS health board, in ", input$EF1_plot2_quarter)
})

## Create the bar chart ----

output$EF1_plot2 <- renderPlotly({
  
  # Assigning to an object so can add "NA" annotations after: 
  EF1_plotly_graph2 <- plot_ly(data = EF1_plot2_data(),
                              x = ~graph_value,
                              y = ~hb_name,
                              # Tooltip text: 
                              text = paste0("Calendar quarter: ", EF1_plot2_data()$year_months,        
                                            "<br>",
                                            "Health board: ", EF1_plot2_data()$hb_name,
                                            "<br>",
                                            "Incidents per 1,000 occupied psychiatric bed days: ", EF1_plot2_data()$graph_value_label), 
                              hoverinfo = "text", 
                              
                              # Bar aesthetics:
                              type = 'bar', 
                              marker = list(color = '#12436D', 
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
                                         "Incidents per 1,000 occupied psychiatric bed days", 
                                         rep("&nbsp;", 20),
                                         rep("\n&nbsp;", 3)),
                                       collapse = ""),
                        range = c(0, max(EF1_plot2_data()$bedday_rate, na.rm = TRUE) * 1.2), 
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
  for (i in 1:nrow(EF1_plot2_data())) {
    
    if (is.na(EF1_plot2_data()$bedday_rate[i])) {
      
      EF1_plotly_graph2 <- EF1_plotly_graph2 %>%
        add_annotations(
          # Position on x-axis: (if you use x = 0 the x axis goes into minus 
          # values as the position of "NA" is from its center)
          # Big variation in some graphs - below values work on small screens, 
          # would prefer closer to y axis on bigger screens though...
          x = case_when(max(EF1_plot2_data()$graph_value) < 30 ~ 0.5, 
                        max(EF1_plot2_data()$graph_value) <= 50 ~ 1,
                        max(EF1_plot2_data()$graph_value) > 50 ~ 3), 
          y = EF1_plot2_data()$hb_name[i],  # Position according to the correct category
          text = "NA",  # The text to display
          showarrow = FALSE,  # No arrow pointing to the text
          font = list(size = 13, 
                      color = "black"))
    }
  }
  
  # Run plotly graph with added NA annotations:
  EF1_plotly_graph2
  
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
                 "Calendar Quarter",
                 "Incidents per 1,000 Bed Days")
  )
})

## Graph 2 data download button ----
# Allows users to the download tables in .csv format ----
output$EF1_2_table_download <- downloadHandler(
  filename = 'EF1 - Incidences of physical violence for chosen quarter.csv', 
  content = function(file) {
    write.table(EF1_plot2_data_for_table(),  
                file, 
                row.names = FALSE, 
                col.names = c("NHS Health Board",
                              "Calendar Quarter",
                              "Incidents per 1,000 Bed Days"), 
                sep = ",")
    
  }
)
