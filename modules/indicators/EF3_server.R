# Graph 1 - comparing HBs over time ---- 

## Health Board Selector ---- 
# Picker for user selecting up to 4 health boards

output$EF3_trendPlot_hbName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF3_trendPlot_hbName",
    label = "Select NHS health board(s) (Maximum 4):",
    choices = EF3_hb_names,  # pulled out in data_preparation.R
    multiple = TRUE,
    options = list("max-options" = 4,
                   `selected-text-format` = "count > 1"),
    # No Scotland data has been calculated for HB returns indicators: S2, S5, EF5
    selected = "NHS Scotland")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EF3_trendPlot_data <- reactive({
  EF3_data %>%
    select(hb, year, rate, bed_days) %>% 
    filter(hb %in% input$EF3_trendPlot_hbName)
})


## Create the EF3 line chart ----

### Render plotly ----

output$EF3_trendPlot <- renderPlotly({ 
  EF3_plot1_plotly <- plot_ly(data = EF3_trendPlot_data(), 
                              
                              x = ~year, 
                              y = ~rate, 
                              color = ~hb, 
                              
                              # Tooltip text
                              text = paste0("Calendar quarter: ",                
                                            EF3_trendPlot_data()$year, 
                                            "<br>",
                                            "Health board: ",
                                            EF3_trendPlot_data()$hb,
                                            "<br>",
                                            "Bed days: ",
                                            EF3_trendPlot_data()$bed_days,
                                            "<br>",
                                            "Rate of psychiatric inpatient beds per 100,000 population: ",
                                            EF3_trendPlot_data()$rate), 
                              hoverinfo = "text", 
                              
                              # Line aesthetics: 
                              type = 'scatter',
                              mode = 'lines+markers', 
                              line = list(width = 3), 
                              colors = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
                              linetype = ~hb, 
                              linetypes = c("solid", "dashed", "solid", "dashed"), 
                              symbol = ~hb,
                              symbols = c("circle", "square", "triangle-up", "triangle-down"),
                              marker = list(size = 12),
                              # Size of graph:
                              height = 600,
                              # Legend info:
                              name = ~str_wrap(hb, 15)) %>%
    
    layout(# graph title is in a box above the graph and Orkney/Shetland 
      # reminder title is below this code. 
      yaxis = list(exponentformat = "none",
                   separatethousands = TRUE,  # it's per 1,000 so do we need to do this? 
                   range = c(0, max(EF3_trendPlot_data()$rate, na.rm = TRUE) * 1.3), 
                   
                   
                   # Wrap the y axis title in spaces so it doesn't cover the tick labels.
                   title = paste0(c(rep("&nbsp;", 20),
                                    print("Rate of psychiatric inpatient beds per 100,000 population"), 
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
                                    "Financial Year",
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
  EF3_plot1_plotly  
  
})


## Table below graph 1 ----
output$EF3_1_table <- renderDataTable({
  datatable(EF3_trendPlot_data() %>% 
              # Add commas to large numbers but keep "NA" as a visible value on dashboard:
              mutate(rate = if_else(is.na(rate), 
                                                                            "NA", 
                                                                            formatC(rate,
                                                                                    format = "f",
                                                                                    digits = 1, # digits after decimal point
                                                                                    ))),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                           # Right align numeric columns - it's columns 4:5 but use 3:4 as rownames = FALSE
                           columnDefs = list(list(className = 'dt-right', targets = 2))), 
            colnames = c("Health Board",
                         "Financial Year",
                         "Rate of psychiatric inpatient beds",
                         "Bed days"))
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
                              "Rate of psychiatric inpatient beds",
                              "Bed days"),
                sep = ",")
  })