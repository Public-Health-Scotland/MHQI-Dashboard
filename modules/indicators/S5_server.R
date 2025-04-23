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

output$S5_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "S5_trendPlot_hbName",
      label = "Select NHS health board(s) (Maximum 4):",
      choices = S5_hb_names,  # pulled out in data_preparation.R
      multiple = TRUE,
      options = list("max-options" = 4,
                     `selected-text-format` = "count > 1"),
      # No Scotland data has been calculated for HB returns indicators: S2, S5, EF5
      selected = "NHS Ayrshire & Arran")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
S5_trendPlot_data <- reactive({
   S5_data %>%
      select(!c("year_quarter", "year")) %>% 
      filter(nhs_health_board %in% input$S5_trendPlot_hbName)
})


## Create the S5 line chart ----

### Render plotly ----

output$S5_trendPlot <- renderPlotly({ 
  
   # Assign to an object so we can add Orkney/Shetland data title note afterwards
   S5_plot1_plotly <- plot_ly(data = S5_trendPlot_data(), 
           
           x = ~year_months, 
           y = ~incidents_per_1000_bed_days, 
           color = ~nhs_health_board, 
           
           # Tooltip text
           text = paste0("Calendar quarter: ",                
                         S5_trendPlot_data()$year_months, 
                         "<br>",
                         "Health board: ",
                         S5_trendPlot_data()$nhs_health_board,
                         "<br>",
                         "Incidents per 1,000 occupied psychiatric bed days: ",
                         S5_trendPlot_data()$incidents_per_1000_bed_days), 
           hoverinfo = "text", 
           
           # Line aesthetics: 
           type = 'scatter',
           mode = 'lines+markers', 
           line = list(width = 3), 
           colors = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
           linetype = ~nhs_health_board, 
           linetypes = c("solid", "dashed", "solid", "dashed"), 
           symbol = ~nhs_health_board,
           symbols = c("circle", "square", "triangle-up", "triangle-down"),
           marker = list(size = 12),
           # Size of graph:
           height = 600,
           # Legend info:
           name = ~str_wrap(nhs_health_board, 15)) %>%
      
      layout(# graph title is in a box above the graph and Orkney/Shetland 
             # reminder title is below this code. 
             yaxis = list(exponentformat = "none",
                          separatethousands = TRUE,  # it's per 1,000 so do we need to do this? 
                          range = c(0, max(S5_trendPlot_data()$incidents_per_1000_bed_days, na.rm = TRUE) * 110 / 100), 
                        
                        
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
    
      ### Add Orkney/ Shetland reminder title ---- 
      
      if ("NHS Orkney" %in% input$S5_trendPlot_hbName) {
         S5_plot1_plotly <- S5_plot1_plotly %>%
            layout(title = "NHS Orkney & NHS Shetland values are included in NHS Grampian data")
      } else if ("NHS Shetland" %in% input$S5_trendPlot_hbName) {
         S5_plot1_plotly <- S5_plot1_plotly %>% 
            layout(title = "NHS Orkney & NHS Shetland values are included in NHS Grampian data")
      } else {
         S5_plot1_plotly <- S5_plot1_plotly %>% layout(title = NULL)
      }
      
      
      ### Return the plot ----
   S5_plot1_plotly  
   
})


## Table below graph 1 ----

output$S5_1_table <- renderDataTable({
   datatable(S5_trendPlot_data()%>% 
                # Add "NA" as a value to table on dashboard:
                mutate(across(number_of_incidents:incidents_per_1000_bed_days, ~replace(., is.na(.), "NA"))),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("NHS Health Board",
                          "Calendar Quarter",
                          "Number of Incidents", 
                          "Total Occupied Psychiatric Bed Days", 
                          "Incidents per 1,000 Bed Days"))
})

## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$S5_1_table_download <- downloadHandler(
   filename = 'S5 - Incidences of physical violence.csv',
   content = function(file) {
      write.table(S5_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("NHS Health Board",
                                "Calendar Quarter",
                                "Number of Incidents", 
                                "Total Occupied Psychiatric Bed Days", 
                                "Incidents per 1,000 Bed Days"),
                  sep = ",")
   })


# Graph 2 - All HBs incidents by Quarter ----


## Picker for user selecting Quarter ----

output$S5_plot2_quarter_output <- renderUI({
   shinyWidgets::pickerInput(
      "S5_plot2_quarter",
      label = "Select calendar quarter:",
      choices = unique(S5_data$year_months),
      selected = "Oct-Dec 2024")
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
  
  paste0("Incidents of physical violence per 1,000 occupied psychiatric bed days in ", 
         input$S5_plot2_quarter, ", by NHS health board:")
})

## Create the bar chart ----

output$S5_plot2 <- renderPlotly({
   
  # Assigning to an object so can add "NA" annotations after: 
   S5_plotly_graph2 <- plot_ly(data = S5_plot2_data(),
           x = ~graph_value,
           y = ~nhs_health_board,
           # Tooltip text: 
           text = paste0("Calendar quarter: ", S5_plot2_data()$year_months,        
                         "<br>",
                         "Health board: ", S5_plot2_data()$nhs_health_board,
                         "<br>",
                         "Incidents per 1,000 occupied psychiatric bed days: ", S5_plot2_data()$graph_value_label), 
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
                                           "Incidents per 1,000 occupied psychiatric bed days", 
                                           rep("&nbsp;", 20),
                                           rep("\n&nbsp;", 3)),
                                         collapse = ""),
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
   for (i in 1:nrow(S5_plot2_data())) {
      
      if (is.na(S5_plot2_data()$incidents_per_1000_bed_days[i])) {
         
         S5_plotly_graph2 <- S5_plotly_graph2 %>%
            add_annotations(
               # Position on x-axis: (if you use x = 0 the x axis goes into minus 
               # values as the position of "NA" is from its center)
               # Big variation in some graphs - below values work on small screens, 
               # would prefer closer to y axis on bigger screens though...
               x = case_when(max(S5_plot2_data()$graph_value) < 30 ~ 0.5, 
                             max(S5_plot2_data()$graph_value) <= 50 ~ 1,
                             max(S5_plot2_data()$graph_value) > 50 ~ 3), 
               y = S5_plot2_data()$nhs_health_board[i],  # Position according to the correct category
               text = "NA",  # The text to display
               showarrow = FALSE,  # No arrow pointing to the text
               font = list(size = 13, 
                           color = "black"))
      }
      }
   
   # Run plotly graph with added NA annotations:
   S5_plotly_graph2
   
   })


## Table for graph 2 ----

output$S5_2_table <- renderDataTable({
   datatable(
      S5_plot2_data_for_table() %>% 
         # Add "NA" as a value to table on dashboard:
         mutate(across(number_of_incidents:incidents_per_1000_bed_days, ~replace(., is.na(.), "NA"))),
      style = 'bootstrap', 
      class = 'table_bordered table-condensed',
      rownames = FALSE, 
      options = list(
         pageLength = 16, 
         autoWidth = FALSE, 
         dom = 'tip'
      ), 
      colnames = c("NHS Health Board",
                   "Calendar Quarter",
                   "Number of Incidents", 
                   "Total Occupied Psychiatric Bed Days", 
                   "Incidents per 1,000 Bed Days")
   )
   })

## Graph 2 data download button ----
# Allows users to the download tables in .csv format ----
output$S5_2_table_download <- downloadHandler(
   filename = 'S5 - Incidences of physical violence for chosen quarter.csv', 
   content = function(file) {
      write.table(S5_plot2_data_for_table(),  
                  file, 
                  row.names = FALSE, 
                  col.names = c("NHS Health Board",
                                "Calendar Quarter",
                                "Number of Incidents", 
                                "Total Occupied Psychiatric Bed Days", 
                                "Incidents per 1,000 Bed Days"), 
                  sep = ",")
      
   }
)
