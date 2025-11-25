# S5 Trends Plot(s) ----

# Two Graphs: 
# 1. HB trend graph - user selects up to 4 HBs to compare incidents per 1000 bed days over time
# 2. Measure graph for quarter - user selects calendar quarter to compare HB's incidents. 

# Tables: 
# Graphs show incidents per 1000 bed days, but tables also include "total bed days" and 
# "no. of incidents"


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
  ef2_quarter_graphs %>%
    #select(!c("year_quarter", "year")) %>% 
    filter(Board %in% input$EF2_trendPlot_hbName)
})


## Create the S5 line chart ----

### Render plotly ----

output$EF2_trendPlot <- renderPlotly({ 
    EF2_plot1_plotly <- plot_ly(data = EF2_trendPlot_data(), 
                             
                             x = ~quarter_fy, 
                             y = ~x28_days_readmission_rate_percentage_quarter, 
                             color = ~Board, 
                             
                             # Tooltip text
                             text = paste0("Calendar quarter: ",                
                                           EF2_trendPlot_data()$quarter_fy, 
                                           "<br>",
                                           "Health board: ",
                                           EF2_trendPlot_data()$Board,
                                           "<br>",
                                           "Readmissions: ",
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
                                    print("Readmissions"), 
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
                   range = list(-0.5, 14.5),
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


### [ EF5 Graph 2 - Health Board Measures ] ----

## Health Board selector ---- (single)
output$EF5_measurePlot_hbName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF5_measurePlot_hbName",
    label = "Select NHS Health Board:",
    choices = EF5_hb_names,
    # No Scotland data on this one
    selected = "NHS Ayrshire & Arran")
})

## Graph 2 title ----
output$EF5_measurePlot_selected_hb <- renderUI({
  req(input$EF5_measurePlot_hbName)
  paste0("Number of 'Did Not Attend' appointments Vs Total number of appointments ", 
         "for mental health based community appointmnents, by calendar quarter, in ",
         input$EF5_measurePlot_hbName)
})

## Graph measure Data Reactive ----
# to create graph data based on HB selection
EF5_measurePlot_data <- reactive({
  EF5_measure_data %>%
    filter(hb_name %in% input$EF5_measurePlot_hbName) %>%
    # For adding "NA" annotation to graph: 
    mutate(graph_value_DNA = if_else(is.na(DNA_appointments), 
                                     0, DNA_appointments), 
           graph_value_label_DNA = if_else(is.na(DNA_appointments), 
                                           "NA", as.character(DNA_appointments)), 
           graph_value_appointments = if_else(is.na(total_appointments), 
                                              0, total_appointments), 
           graph_value_label_appointments = if_else(is.na(total_appointments), 
                                                    "NA", as.character(total_appointments)))
})


# Graph 2 - All HBs incidents by Quarter ----


## Picker for user selecting Quarter ----

output$S5_plot2_quarter_output <- renderUI({
  shinyWidgets::pickerInput(
    "S5_plot2_quarter",
    label = "Select calendar quarter:",
    choices = unique(S5_data$year_months),
    selected = "Apr-Jun 2025")
})

## Selecting appropriate data for graph 2 ---- 
# Taking Orkney and Shetland out of the graph, adding ordering, adding NA for annotations

S5_plot2_data <- reactive({
  S5_data %>%
    select(!c("year_quarter", "year")) %>%  
    filter(nhs_health_board != "NHS Orkney" & 
             nhs_health_board != "NHS Shetland") %>%
    filter(year_months %in% input$S5_plot2_quarter) %>% 
    # for ordering graph by value:
    mutate(nhs_health_board = fct_reorder(nhs_health_board, incidents_per_1000_bed_days, 
                                          .na_rm = FALSE)) %>%  # This row is required or crashes
    # For adding "NA" annotation to graph: 
    mutate(graph_value = if_else(is.na(incidents_per_1000_bed_days), 
                                 0, incidents_per_1000_bed_days), 
           graph_value_label = if_else(is.na(incidents_per_1000_bed_days), 
                                       "NA", as.character(incidents_per_1000_bed_days)))
})   

## Selecting appropriate data for table 2 ---- 
S5_plot2_data_for_table <- reactive({
  S5_data %>%
    select(!c("year_quarter", "year")) %>%  
    filter(year_months %in% input$S5_plot2_quarter)
})

## Graph 2 title ----
output$S5_plot2_title <- renderUI({
  
  req(input$S5_plot2_quarter)
  
  paste0("Incidents of physical violence per 1,000 occupied psychiatric bed days, by ", 
         "NHS health board, in ", input$S5_plot2_quarter)
})

## Create the bar chart ----

output$EF2_plot2 <- renderPlotly({
  
  # Assigning to an object so can add "NA" annotations after: 
  EF2_plotly_graph2 <- plot_ly(data = EF2_plot2_data(),
                              x = ~x28_days_readmission_rate_percentage_quarter,
                              y = ~Board,
                              # Tooltip text: 
                              text = paste0("Calendar quarter: ", EF2_plot2_data()$quarter_fy,        
                                            "<br>",
                                            "Health board: ", EF2_plot2_data()$Board,
                                            "<br>",
                                            "Percentage of readmissions", EF2_plot2_data()$x28_days_readmission_rate_percentage_quarter), 
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
                                         "Percentage of readmissions", 
                                         rep("&nbsp;", 20),
                                         rep("\n&nbsp;", 3)),
                                       collapse = ""),
                        range = c(0, max(S5_plot2_data()$incidents_per_1000_bed_days, na.rm = TRUE) * 1.2), 
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


# Graph 2 - All HBs incidents by Quarter ----


## Picker for user selecting Quarter ----

output$S5_plot2_quarter_output <- renderUI({
  shinyWidgets::pickerInput(
    "S5_plot2_quarter",
    label = "Select calendar quarter:",
    choices = unique(S5_data$year_months),
    selected = "Apr-Jun 2025")
})

## Selecting appropriate data for graph 2 ---- 
# Taking Orkney and Shetland out of the graph, adding ordering, adding NA for annotations

EF2_plot2_data <- reactive({
  ef2_quarter_graphs %>%
    select(!c("quarter_fy", "year")) %>%  
    filter(Board != "NHS Orkney" & 
             Board != "NHS Shetland") %>%
    filter(quarter_year %in% input$EF2_plot2_quarter) %>% 
    # for ordering graph by value:
    mutate(Board = fct_reorder(Board, x28_days_readmission_rate_percentage_quarter, 
                                          .na_rm = FALSE)) %>%  # This row is required or crashes
    # For adding "NA" annotation to graph: 
    mutate(graph_value = if_else(is.na(x28_days_readmission_rate_percentage_quarter), 
                                 0, x28_days_readmission_rate_percentage_quarter), 
           graph_value_label = if_else(is.na(x28_days_readmission_rate_percentage_quarter), 
                                       "NA", as.character(x28_days_readmission_rate_percentage_quarter)))
})   


