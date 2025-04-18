# S2 Trends Plot(s) ----

# Three graphs: 
# 1. Comparing HBs percentages over time, user selects up to 4 HBs 
# 2. All HBs percentages by user selected quarter
# 3. Total discharges and followed up, user selects HB.


# Graph 1 - Comparing health boards % over time ---- 

## Picker for user selecting specific health board ---- 

output$S2_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "S2_trendPlot_hbName",
      label = "Select NHS health board (Maximum 4):",
      choices = sort(unique(as.character(S2_data$nhs_health_board))),
      multiple = TRUE,
      options = list("max-options" = 4,
                     `selected-text-format` = "count > 1"),
      selected = "NHS Ayrshire & Arran")
   })



## Graph Data Reactive ---- 
# to create graph data based on HB selection
S2_trendPlot_data <- reactive({
   S2_data %>%
      select(!c("year_quarter", "year")) %>% 
      filter(nhs_health_board %in% input$S2_trendPlot_hbName)
})


## Create graph 1 line chart ----

### Render plotly ----

output$S2_trendPlot <- renderPlotly({ 
  
  
  plot_ly(data = S2_trendPlot_data(),
          
          x = ~year_months, y = ~percentage_followed_up, color = ~nhs_health_board,
          
          # Tooltip text
          text = paste0("Calendar quarter: ",
                        S2_trendPlot_data()$year_months,
                        "<br>",
                        "Health board: ",
                        S2_trendPlot_data()$nhs_health_board,
                        "<br>",
                        "Percentage followed up: ",
                        S2_trendPlot_data()$percentage_followed_up, "%"), 
          hoverinfo = "text",
          
          # Line aesthetics
          type = 'scatter', mode = 'lines+markers',
          line = list(width = 3),
          # Setting line colours - does not work
          colors = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
          linetype = ~nhs_health_board,
          linetypes = c("solid", "dot", "solid", "dot"),
          symbol = ~nhs_health_board, 
          symbols = c("circle", "square", "triangle-up", "triangle-down"),
          marker = list(size = 12),
          # Size of graph
          # width = 1000, 
          height = 600,
          # Legend info
          name = ~str_wrap(nhs_health_board, 15)) %>%
    
    layout(title = str_wrap(paste0(c(rep("&nbsp;", 10),
                                     "<b>",
                                     "Percentage of psychiatric inpatients followed up by community mental health services ",
                                     "within 7 calendar days of being discharged.", 
                                     # "<em>",
                                     "2022-2024 calendar quarters for your selected health board(s)", 
                                     # "</em>", 
                                     "</b>",
                                  rep("&nbsp;", 10),
                                  rep("\n&nbsp;", 3))
                                  ), 54),
           yaxis = list(
             # Wrap the y axis title in spaces so it doesn't cover the tick labels.
             title = #list(
               paste0(c(rep("&nbsp;", 20),
                        "Percentage (%)", 
                        rep("&nbsp;", 20),
                        rep("\n&nbsp;", 3)),
                      collapse = ""),
                     #font = list(size = 13)),
             exponentformat = "none",
             separatethousands = TRUE,
             range = c(0, max(S2_trendPlot_data()$percentage_followed_up, na.rm = TRUE) * 110 / 100), 
             showline = TRUE, 
             ticks = "outside"
           ),
           
           # Create diagonal x-axis ticks
           xaxis = list(tickangle = -45, 
                        title = paste0(c(rep("&nbsp;", 20),
                                         "<br>",
                                         "<br>",
                                         "Calendar Year",
                                         rep("&nbsp;", 20),
                                         rep("\n&nbsp;", 3)),
                                       collapse = ""),
                        showline = TRUE, 
                        ticks = "outside"),
           
           # Set the graph margins.
           margin = list(l = 90, r = 60, b = 170, t = 90),
           
           # Set the font sizes.
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
           displaylogo = F, editable = F)
})

## Table below graph 1 ----

output$S2_1_table <- renderDataTable({
   datatable(S2_trendPlot_data() %>% 
                # Add "NA" as a value to table on dashboard: 
                mutate(across(number_of_patients_followed_up:percentage_followed_up, ~replace(., is.na(.), "NA"))),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("Health Board",
                          "Calendar Quarter",
                          "Number of Patients Followed Up", 
                          "Total Number of Discharged Patients", 
                          "Percentage Followed Up (%)"))
})

## Graph 1 data download button ----
# Allows users to download tables in .csv format 
output$S2_1_table_download <- downloadHandler(
   filename = 'S2 - Discharge followed up for chosen health boards.csv',
   content = function(file) {
      write.table(S2_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Health Board",
                                "Calendar Quarter",
                                "Number of Patients Followed Up", 
                                "Total Number of Discharged Patients", 
                                "Percentage Followed Up (%)"),
                  sep = ",")
   })



# Graph 2 - All HBs percentages by Quarter ---- 


## Picker for user selecting Quarter ----

output$S2_plot2_quarter_output <- renderUI({
   shinyWidgets::pickerInput(
      "S2_plot2_quarter",
      label = "Select calendar quarter:",
      choices = unique(S2_data$year_months),
      selected = "Oct-Dec 2024")
})

## Selecting appropriate data for graph 2 ---- 

S2_plot2_data <- reactive({
   S2_data %>%
      select(nhs_health_board, year_months, number_of_patients_followed_up, 
             total_number_of_discharged_patients, percentage_followed_up) %>%
      filter(year_months %in% input$S2_plot2_quarter) %>% 
      mutate(nhs_health_board = fct_reorder(nhs_health_board, percentage_followed_up, # for ordering by percentage
                                            .na_rm = FALSE)) %>%      # required or crashes
      # For adding "NA" annotation to graph: 
      mutate(graph_value = if_else(is.na(percentage_followed_up), 
                                   0, percentage_followed_up), 
             graph_value_label = if_else(is.na(percentage_followed_up), 
                                         "NA", as.character(percentage_followed_up)))
})   

## Graph 2 title ----
output$S2_plot2_title <- renderUI({
  
  req(input$S2_plot2_quarter)
  
  paste0("Percentage of psychiatric inpatients followed up by community ",
         "mental health services within 7 calendar days of being discharged in ",
         input$S2_plot2_quarter, " by NHS health board:")
  
  
})

## Create graph 2 ----

output$S2_plot2 <- renderPlotly({
  
   # Assigning to an object so can add "NA" annotations after:
 S2_plotly_graph2 <- plot_ly(data = S2_plot2_data(),
          
          x = ~graph_value, y = ~nhs_health_board, # x = ~percentage_followed_up,  
          # Tooltip text
          text = paste0("Calendar quarter: ", S2_plot2_data()$year_months, 
                        "<br>",
                        "Health board: ", S2_plot2_data()$nhs_health_board,
                        "<br>",
                        "Percentage of patients followed up: ", S2_plot2_data()$graph_value_label, "%"), #S2_plot2_data()$percentage_followed_up
          hoverinfo = "text",
          
          # Bar aesthetics
          type = 'bar', 
          marker = list(color = "#0078D4", 
                        size = 12),
          textposition = "none", # remove small text on each bar
          # Size of graph
          height = 600) %>%
    
    layout(
      # Set the font sizes.
      font = list(size = 13),
      yaxis = list(
      # Wrap the y axis title in spaces so it doesn't cover the tick labels.
        title = paste0(c(rep("&nbsp;", 20),
                   "NHS Health Board of Treatment", 
                   rep("&nbsp;", 20),
                   rep("\n&nbsp;", 3)),
                  collapse = ""),
        exponentformat = "none",
        
        showline = TRUE, 
        ticks = "outside"
      ),
    
    xaxis = list(title = paste0(c(rep("&nbsp;", 20),
                                  "<br>",
                                  "<br>",
                                  "Percentage (%) of patients followed up within 7 days",
                                  # S2_plot2_quarter_output, # Still to figure out how to get the calendar quarter to feed in
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
 
 # Add annotations for the "NA" labels at the appropriate position(s)
 
 for (i in 1:nrow(S2_plot2_data())) {
    
    if (is.na(S2_plot2_data()$percentage_followed_up[i])) {
       
       S2_plotly_graph2 <- S2_plotly_graph2 %>%
          add_annotations(
             x = 2,  # Position on x-axis - for now, needs to be further along for smaller screens, but not too far for big screens 
             y = S2_plot2_data()$nhs_health_board[i],  # Position according to the correct category
             text = "NA",  # The text to display
             showarrow = FALSE,  # No arrow pointing to the text
             font = list(size = 13, 
                         color = "black"))
    }
 }
 
 # Run plotly graph with the added NA annotations: 
 
 S2_plotly_graph2
    
 
})


## Table for graph 2 ----


output$S2_2_table <- renderDataTable({
   datatable(
      S2_plot2_data() %>% 
         # Remove columns used for adding NA annotations to graph: 
         select(!c("graph_value", "graph_value_label")) %>% 
         # Add "NA" as a value to table on dashboard: 
         mutate(across(number_of_patients_followed_up:percentage_followed_up, ~replace(., is.na(.), "NA"))), 
      style = 'bootstrap', 
      class = 'table_bordered table-condensed',
      rownames = FALSE, 
      options = list(
         pageLength = 16, 
         autoWidth = FALSE, 
         dom = 'tip'
      ), 
      colnames = c("Health Board", 
                   "Calendar Quarter", 
                   "Number of Patients Followed Up", 
                   "Total Number of Discharged Patients", 
                   "Percentage (%) Followed Up")
      )
   })


## Graph 2 data download button ----
# Allows users to the download tables in .csv format
output$S2_2_table_download <- downloadHandler(
   filename = 'S2 - Discharges followed up for chosen quarter.csv', 
   content = function(file) {
      write.table(S2_plot2_data()%>% 
                     # Remove columns used for adding NA annotations to graph: 
                     select(!c("graph_value", "graph_value_label")), 
                  file, 
                  row.names = FALSE, 
                  col.names = c("Health Board", 
                                "Calendar Quarter", 
                                "Number of Patients Followed Up", 
                                "Total Number of Discharged Patients", 
                                "Percentage (%) Followed Up"), 
                  sep = ",")
      
   }
)



# Graph 3 - by HB - Total discharged and number followed up ---- 

   ## Picker 1 - for user selecting Health Board  ----
   
   output$S2_Plot3_hbName_output <- renderUI({
      shinyWidgets::pickerInput(
         "S2_Plot3_hbName",
         label = "Select health board:",
         choices = sort(unique(as.character(S2_data$nhs_health_board))),
         selected = "NHS Ayrshire & Arran"
      )
   })


   ## Selecting appropriate data for graph and table 3 ----
   #Need to do both as we need Numeric columns pivoted in graph and Character columns not pivoted in table.
   
   S2_plot3_data_for_graph <- reactive({
      S2_pivoted_data %>%
         filter(nhs_health_board %in% input$S2_Plot3_hbName) 
   })
  
   
   S2_plot3_data_for_table <- reactive({
      S2_data %>%
         filter(nhs_health_board %in% input$S2_Plot3_hbName) %>%
         select(!c("year_quarter", "year"))
   })

## Graph 3 title ----
output$S2_plot3_title <- renderUI({
  
  req(input$S2_Plot3_hbName)
  
  paste0("Total number of psychiatric inpatients discharged and number followed up ",
         "by community mental health services within 7 calendar days in ",
         input$S2_Plot3_hbName, ", by calendar quarter:")
})


   ## Create graph 3 - line graph ----

      ### Render plotly ----
      
      output$S2_plot3 <- renderPlotly({
         
         plot_ly(data = S2_plot3_data_for_graph(),
                 
                 x = ~year_months, 
                 y = ~number, 
                 color = ~total_or_followed_up, 
                 
                 # Tooltip text - No followed up OR Total discharged
                 text = paste0("Calendar quarter: ", S2_plot3_data_for_graph()$year_months,        
                               "<br>",
                               "NHS health board: ", S2_plot3_data_for_graph()$nhs_health_board,
                               "<br>",
                               case_when(S2_plot3_data_for_graph()$total_or_followed_up == "Number of patients followed up" ~
                                            paste0("Number of patients followed up: ", S2_plot3_data_for_graph()$number),
                                         S2_plot3_data_for_graph()$total_or_followed_up == "Total number of discharged inpatients" ~
                                            paste0("Total number of inpatients discharged: ", S2_plot3_data_for_graph()$number),
                                         TRUE ~ "No Data")),
                 hoverinfo = "text",
                 
                 # Line aesthetics: 
                 type = 'scatter',
                 mode = 'lines+markers', 
                 line = list(width = 3), 
                 colors = c("#3F3685", "#1E7F84"),
                 linetype = ~total_or_followed_up, 
                 linetypes = c("solid", "dashed"), 
                 symbol = ~total_or_followed_up,
                 symbols = c("circle", "triangle-up"),
                 marker = list(size = 12),
                 # Size of graph:
                 height = 600,
                 # Legend info:
                 name = ~str_wrap(total_or_followed_up, 15)) %>%
            
            layout(yaxis = list(exponentformat = "none",
                                separatethousands = TRUE,  
                                range = c(0, max(S2_plot3_data_for_graph()$number) * 110 / 100), 
                                # Wrap the y axis title in spaces so it doesn't cover the tick labels:
                                title = paste0(c(rep("&nbsp;", 20),
                                                 print("Number of Patients"), 
                                                 rep("&nbsp;", 20),
                                                 rep("\n&nbsp;", 3)),
                                               collapse = ""),#),
                                showline = TRUE, 
                                ticks = "outside"
                                ),
                   
                   xaxis = list(# X axis won't show quarters until there is one with data in it
                      # e.g. NHS D&G only have data from Jan 2023 so the axis starts there 
                      # instead of Jan 2022. The table is correct and showing NAs, but the 
                      # below isn't working. 
                      # type = "category",   # Ensures months aren't removed if there is no data
                      #  tickmode = "array",         # Ensure all months are ticked
                      #  tickvals = S2_plot3_data_for_graph()$year_months, # Explicitly set tick values to include all months
                      #  ticktext = S2_plot3_data_for_graph()$year_months,  # Set the text of ticks to be the month names
                      type = "category",   # meant to ensure that quarters aren't removed if there is no data
                      tickmode = "array", S2_plot3_data_for_graph()$year_months, # meant to ensure that all quarters are ticked
                      tickvals = levels(S2_plot3_data_for_graph()$year_months),  # Explicitly setting the tickvals to all factor levels
                      ticktext = levels(S2_plot3_data_for_graph()$year_months),   # Ensuring that all levels appear as labels       
                      tickangle = -45,    # Diagonal x-axis ticks
                                title = paste0(c(rep("&nbsp;", 20),
                                                 "<br>",
                                                 "<br>",
                                                 "Calendar Quarter",
                                                 rep("&nbsp;", 20),
                                                 rep("\n&nbsp;", 3)),
                                               collapse = ""),
                                showline = TRUE, 
                                ticks = "outside"),
                     
                   
                   # Set the graph margins:
                   margin = list(l = 90, r = 60, b = 170, t = 90),  
                   
                   # Set the font sizes:
                   font = list(size = 13),
                   
                   # Add a legend & make the legend background and border white:            
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
         
      })
         
    
   ### Old ggplot code ----      
      #    
      #    S2_plot3_graph <- reactive({
      #       ggplot(S2_plot3_data_for_graph(),
      #              aes(x = year_months,
      #                  y = number,
      #                  text = paste0("Calendar quarter: ", S2_plot3_data_for_graph()$year_months,        # for tooltip in ggplotly - shows values on hover
      #                                "<br>",
      #                                "NHS health board: ", S2_plot3_data_for_graph()$nhs_health_board,
      #                                "<br>",
      # 
      #                                case_when(total_or_followed_up == "Number of patients followed up" ~
      #                                             paste0("Number of patients followed up: ", S2_plot3_data_for_graph()$number),
      #                                          total_or_followed_up == "Total number of discharged inpatients" ~
      #                                             paste0("Total number of inpatients discharged: ", S2_plot3_data_for_graph()$number),
      #                                          TRUE ~ "No Data")))) +
      #          geom_line() + 
      #          geom_point(size = 2.5) + 
      #          aes(group = total_or_followed_up,  # Have to do this outside so that the legends shows and so that there aren't 3 legends
      #              linetype = total_or_followed_up, 
      #              color = total_or_followed_up, 
      #              shape = total_or_followed_up) + 
      #          scale_color_discrete_phs(name = unique(S2_plot3_data_for_graph()$nhs_health_board), 
      #                                   palette = "main-blues",
      #                                   labels = ~ stringr::str_wrap(.x, width = 15)) +
      #          scale_linetype_manual(name = unique(S2_plot3_data_for_graph()$nhs_health_board),
      #                                values = c("solid", "dashed", "solid", "dashed"),
      #                                labels = ~ stringr::str_wrap(.x, width = 15)) +
      #          scale_shape_manual(name = unique(S2_plot3_data_for_graph()$nhs_health_board), 
      #                             values = c("circle", "square", "triangle-up", "triangle-down"),
      #                             labels = ~ stringr::str_wrap(.x, width = 15)) +
      #           # geom_text(aes(label = if_else(is.na(number),
      #           #                               "NA", "")), # "value" shown on graph is "NA" for NAs, no text for HBs with values
      #           #           na.rm = FALSE,
      #           #           nudge_y = 2,
      #           #           size = 4) +
      #          theme_classic() +
      #          theme(panel.grid.major.x = element_line(),
      #                panel.grid.major.y = element_line(),
      #                axis.title.x = element_text(size = 12,
      #                                            color = "black",
      #                                            face = "bold"),
      #                axis.text.x = element_text(angle = 25)) + 
      #          labs(x = paste0("Calendar Quarter"),
      #               y = "Number of Patients") +
      #          scale_y_continuous(#na.value = 0,   # for placing "NA" but this isn't working nicely (brings graph line down to wherever you place it)
      #                             n.breaks = 10,
      #                             expand = c(0,0)) +  # remove spacing between dates on x axis and 0  on y axis
      #          coord_cartesian(ylim = c(0, (max(S2_plot3_data_for_graph()$number) + 
      #                                          (0.1*max(S2_plot3_data_for_graph()$number)))), 
      #                          expand = TRUE)
      #         # ylim = c(0, (max(S2_plot3_data_for_graph()$number) + (0.1*max(S2_plot3_data_for_graph()$number)))) # having issues with NAs not allowing axis to extend 
      #    })
      #    
      #    ### Run graph 3 through plotly
      #    ggplotly(S2_plot3_graph(),
      #             tooltip = "text") %>%     # uses text set up in ggplot aes above.
      #     #  layout(legend = list(orientation = 'h')) %>%   # After discussion, we don't want this - moves legend to bottom
      #       ### Remove unnecessary buttons from the modebar
      #    config(displayModeBar = TRUE,
      #           modeBarButtonsToRemove = bttn_remove,
      #           displaylogo = F, editable = F)
      #    
      # })


   ## Table for graph 3 ----
   
   
   output$S2_3_table <- renderDataTable({
      datatable(
         S2_plot3_data_for_table() %>% 
            # Add "NA" as a value to table on dashboard: 
            mutate(across(number_of_patients_followed_up:percentage_followed_up, ~replace(., is.na(.), "NA"))),, 
         style = 'bootstrap', 
         class = 'table_bordered table-condensed',
         rownames = FALSE, 
         options = list(
            pageLength = 16, 
            autoWidth = FALSE, 
            dom = 'tip'
         ), 
         colnames = c("Health Board", 
                      "Calendar Quarter",
                      "Number of Patients Followed Up", 
                      "Total Number of Discharged Patients", 
                      "Percentage (%) Followed Up")
      )
   })


## Graph 3 data download button ----
# Allows users to the download tables in .csv format
output$S2_3_table_download <- downloadHandler(
   filename = 'S2 - Discharges followed up for chosen health board and year.csv', 
   content = function(file) {
      write.table(S2_plot3_data_for_table(), 
                  file, 
                  row.names = FALSE, 
                  col.names = c("Health Board", 
                                "Calendar Quarter", 
                                "Year",
                                "Number of Patients Followed Up", 
                                "Total Number of Discharged Patients", 
                                "Percentage (%) Followed Up"), 
                  sep = ",")
      
   }
)
