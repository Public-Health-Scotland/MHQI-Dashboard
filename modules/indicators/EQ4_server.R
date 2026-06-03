# EQ4 Trends Plot(s) ----
  
  # Graphs: 
  # 1. HB trend graph - user selects up to 4 HBs to compare incidents per 1000 bed days over time
 
  # Graph 1 - comparing HBs over time ---- 

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
    # No Scotland data has been calculated for HB returns indicators: S2, S5, EF5
    selected = "NHS Ayrshire & Arran")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EQ4_trendPlot_data <- reactive({
  EQ4_data %>%
   select(board, quarter_fy, total_percent_Ads_nonC_hb_Quarter) %>% 
    filter(board %in% input$EQ4_trendPlot_hbName)
})


## Create the EF2 line chart ----

### Render plotly ----

output$EQ4_trendPlot <- renderPlotly({ 
  EQ4_plot1_plotly <- plot_ly(data = EQ4_trendPlot_data(), 
                              
                              x = ~quarter_fy, 
                              y = ~total_percent_Ads_nonC_hb_Quarter, 
                              color = ~board, 
                              
                              # Tooltip text
                              text = paste0("Financial quarter: ",                
                                            EQ4_trendPlot_data()$quarter_fy, 
                                            "<br>",
                                            "Health board: ",
                                            EQ4_trendPlot_data()$board,
                                            "<br>",
                                            "Percentage of Admissons out with CAMH wards: ",
                                            EQ4_trendPlot_data()$total_percent_Ads_nonC_hb_Quarter), 
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
                              name = ~str_wrap(board, 15)) %>%
    
    layout(# graph title is in a box above the graph and Orkney/Shetland 
      # reminder title is below this code. 
      yaxis = list(exponentformat = "none",
                   separatethousands = TRUE,  # it's per 1,000 so do we need to do this? 
                   range = c(0, max(EQ4_trendPlot_data()$total_percent_Ads_nonC_hb_Quarter, na.rm = TRUE) * 1.3), 
                   
                   
                   # Wrap the y axis title in spaces so it doesn't cover the tick labels.
                   title = paste0(c(rep("&nbsp;", 20),
                                    print("Percentage of Admissons out with CAMH wards"), 
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
  EQ4_plot1_plotly  
  
})


## Table below graph 1 ----
output$EQ4_1_table <- renderDataTable({
  datatable(EQ4_trendPlot_data() %>% 
              # Add commas to large numbers but keep "NA" as a visible value on dashboard:
              mutate(total_percent_Ads_nonC_hb_Quarter = if_else(is.na(total_percent_Ads_nonC_hb_Quarter), 
                                                                            "NA", 
                                                                            formatC(total_percent_Ads_nonC_hb_Quarter,
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
                         "Financial quarter",
                         "Percentage of Admissons out with CAMH wards"))
})



## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$EQ4_1_table_download <- downloadHandler(
  filename = 'EQ4 - Percentage of admissions out with camh.csv',
  content = function(file) {
    write.table(EQ4_trendPlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("NHS Health Board",
                              "Financial quarter",
                              "Percentage of Admissons out with CAMH wards"),
                sep = ",")
  })
