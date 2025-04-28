# EF4 ---- 

# One Graph: User selects HB and measure(s) (MH expend % and/or CAMHS expend %) 
# to see changes over time. 

# One Table: Financial year, HB, Measure Name, Value (%)


# EF4 Trends Plot ----

## Health Board selector ----
output$EF4_trendPlot_hbName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF4_trendPlot_hbName",
    label = "Select NHS health board:",
    choices = EF4_hb_names,
    selected = "NHS Scotland")
})

## Measure selector ----
output$EF4_trendPlot_measure_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF4_trendPlot_measure",
    label = "Select measure(s):",
    choices = EF4_trend_measures,
    selected = "Mental Health Expenditure",
    multiple = TRUE)
})

## Graph title ----
output$EF4_trendPlot_title <- renderUI({
  
  # Measures section
  req(input$EF4_trendPlot_measure)
  
  EF4_selected_measures <- input$EF4_trendPlot_measure
  
  EF4_measure_text <- if (length(EF4_selected_measures) == 1) {
    EF4_selected_measures
  } else if (length(EF4_selected_measures) == 2) {
    paste(EF4_selected_measures, collapse = " and ")
  } else {
    paste(
      paste(EF4_selected_measures[-length(EF4_selected_measures)], collapse = ", "),
      "and", 
      EF4_selected_measures[length(EF4_selected_measures)]
    )
  }
  
  # HB section
  req(input$EF4_trendPlot_hbName)
  paste0("Percentage of total spend attributed to ", EF4_measure_text, 
         ", by financial year, in ", input$EF4_trendPlot_hbName)
  
})

## Graph Data Reactive ---- 
# to create graph data based on HB and Measure selection
EF4_trendPlot_data <- reactive({
  EF4_data %>%
    filter(hb_name %in% input$EF4_trendPlot_hbName &
           measure %in% input$EF4_trendPlot_measure)
})



## Create the EF4 line chart ----

 ### Render plotly ----

 output$EF4_trendPlot <- renderPlotly({
    
    plot_ly(data = EF4_trendPlot_data(), 
            
            x = ~fyear, 
            y = ~value, 
            color = ~measure, 
            
            # Tooltip text - Health board of treatment OR Council area of residence
            text = paste0("Financial Year: ",         # for tooltip in ggplotly - shows values on hover
                          EF4_trendPlot_data()$fyear,
                          "<br>",
                          "Health Board: ",
                          EF4_trendPlot_data()$hb_name,
                          "<br>",
                          EF4_trendPlot_data()$measure,": ",
                          EF4_trendPlot_data()$value, "% of board's total spend"), 
            hoverinfo = "text", 
            
            # Line aesthetics: 
            type = 'scatter',
            mode = 'lines+markers', 
            line = list(width = 3), 
            colors = c("#3F3685", "#1E7F84"),
            linetype = ~measure, 
            linetypes = c("solid", "dashed"),
            symbol = ~measure,
            symbols = c("square", "triangle-up"),
            marker = list(size = 12),
            # Size of graph:
            height = 600,
            # Legend info:
            name = ~str_wrap(measure, 15)) %>%
       
       layout(yaxis = list(exponentformat = "none", 
                           # Range: "*1.2) is good for the highest tick for most HBs without going to high
                           range = c(0, max(EF4_trendPlot_data()$value, na.rm = TRUE) * 1.2), 
                           # Wrap the y axis title in spaces so it doesn't cover the tick labels.
                           title = paste0(c(rep("&nbsp;", 20),
                                            print("Percentage (%)"), 
                                            rep("&nbsp;", 20),
                                            rep("\n&nbsp;", 3)),
                                          collapse = ""),
                           showline = TRUE, 
                           ticks = "outside"),
              
              xaxis = list(tickangle = -35,                    # Angle x-axis ticks
                           title = paste0(c(rep("&nbsp;", 20),
                                            "<br>",
                                            "<br>",
                                            "Financial Year",
                                            rep("&nbsp;", 20),
                                            rep("\n&nbsp;", 3)),
                                          collapse = ""),
                           # For range - we have 12 years up to 2023/24 - this will 
                           # need to be updated when new years are added to the code. 
                           # Edit will be to add 1 to the second figure with each new 
                           # year (i.e. it will be (-0.5, 12.5) in next update)
                           # Starting at -0.5 and ending at 11.5 gives much nicer 
                           # spacing on the axis than "0, 12"
                           range = list(-0.5, 11.5), 
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

## Table below graph ----
 
  output$EF4_table <- renderDataTable({
    datatable(EF4_trendPlot_data() %>% 
                 mutate(value = paste0(value, " %")),
              style = 'bootstrap',
              class = 'table-bordered table-condensed',
              rownames = FALSE,
              options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
              colnames = c("Financial Year",
                           "Health Board",
                           "Measure Name",
                           "Percentage of Board's Total Expenditure"))
  })
 
  # Create download button that allows users to download tables in .csv format.
  output$EF4_table_download <- downloadHandler(
    filename = 'EF4 - Mental health spend.csv',
    content = function(file) {
      write.table(EF4_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Financial Year",
                                "Health Board",
                                "Measure Name",
                                "Percentage of Board's Total Expenditure"),
                  sep = ",")
    }
  )
  