# T2 Trends Plot(s) ----

# Graph 1 - comparing HBs over time ----


## Health board selector ----

# output$T2_trendPlot_hbName_output <- renderUI({
#   
#   shinyWidgets::pickerInput(
#     inputId = "T2_trendPlot_hbName",
#     label = "Select NHS health board",
#     choices = T2_hb_names,
#     multiple = FALSE,
#     options = list(
#       `max-options` = 4,
#       `selected-text-format` = "count > 1"
#     ),
#     selected = "NHS Scotland"
#   )
#   
# })


## Graph data reactive ----

T2_trendPlot_data <- reactive({

  
  T2_data |>
    filter(hb_name %in% input$T2_trendPlot_hbName) 
  
})


## Create the T2 line chart ----
output$T2_trendPlot <- renderPlotly({
  
  graph_data <- T2_trendPlot_data()
  
  req(nrow(graph_data) > 0)
  
  number_of_quarters <- length(
    unique(graph_data$quarter_end)
  )
  
  maximum_y_value <- max(
    c(95, graph_data$percent_seen_for_band),
    na.rm = TRUE
  ) * 1.1
  
  T2_plot1_plotly <- plot_ly(
    data = graph_data,
    
    x = ~quarter_end,
    y = ~percent_seen_for_band,
    
    # Colour represents wait-time band
    color = ~weeks_band,
    colors = c(
      "#3F3685",
      "#9B4393",
      "#0078D4",
      "#1E7F84"
    ),
    
    
    # Tooltip text
    text = ~paste0(
      "NHS health board: ",
      hb_name,
      "<br>",
      "Quarter: ",
      quarter_end,
      "<br>",
      "Seen 0-18 weeks: ",
      patients_seen,
      "<br>",
      "Total patients: ",
      total_patients_seen,
      "<br>",
      "Percentage started treatment: ",
      percent_seen_for_band,
      "%"
    ),
    
    hoverinfo = "text",
    
    type = "scatter",
    mode = "lines+markers",
    
    line = list(width = 3),
    marker = list(size = 10),
    
    height = 600
  ) |>
    
    layout(
      
      yaxis = list(
        exponentformat = "none",
        range = c(0, maximum_y_value),
        title = "Percentage started treatment",
        showline = TRUE,
        ticks = "outside"
      ),
      
      xaxis = list(
        automargin = FALSE,
        tickangle = -45,                     # Rotate tick labels
        title = "Quarter",            # Axis title
        
        # Use c(), not list(), for an axis range
        range = c(
          -0.5,
          number_of_quarters - 0.5
        ),
        
        showline = TRUE,
        ticks = "outside"
      ),
      
      # 90% reference line
      shapes = list(
        list(
          type = "line",
          x0 = -0.5,
          x1 = number_of_quarters - 0.5,
          y0 = 90,
          y1 = 90,
          line = list(
            color = "red",
            width = 2,
            dash = "dash"
          )
        )
      ),
      
      annotations = list(
        list(
          x = number_of_quarters - 1.5,
          y = 93,
          text = "90% standard",
          showarrow = FALSE,
          font = list(
            color = "red",
            size = 11
          )
        )
      ),
      
      margin = list(
        l = 90,
        r = 60,
        b = 170,
        t = 90
      ),
      
      font = list(size = 13),
      
      showlegend = TRUE,
      
      legend = list(
        x = 1,
        y = 0.8,
        bgcolor = "rgba(255, 255, 255, 0)",
        bordercolor = "rgba(255, 255, 255, 0)"
      )
    ) |>
    
    config(
      displayModeBar = TRUE,
      
      modeBarButtonsToRemove = list(
        "select2d",
        "lasso2d",
        "toggleSpikelines",
        "hoverCompareCartesian",
        "hoverClosestCartesian"
      ),
      
      displaylogo = FALSE,
      editable = FALSE
    )
  
  T2_plot1_plotly
  
})

## Table below graph 1 ----
output$T2_1_table <- renderDataTable({
  
  table_data <- T2_trendPlot_data() |>
    mutate(
      percent_seen_for_band = dplyr::if_else(
        is.na(percent_seen_for_band),
        "NA",
        paste0(formatC(percent_seen_for_band, format = "f", digits = 1), "%")
      )
    ) |>
    arrange(hb_name, quarter_end, patients_seen, total_patients_seen, percent_seen_for_band) %>%
    select(hb_name, quarter_end, patients_seen, total_patients_seen, percent_seen_for_band)
  
  DT::datatable(
    table_data,
    style = "bootstrap",
    class = "table-bordered table-condensed",
    rownames = FALSE,
    options = list(
      pageLength = 16,
      autoWidth = FALSE,
      dom = "tip",
      columnDefs = list(
        list(className = "dt-right", targets = 2:4)
      )
    ),
    colnames = c(
      "Health Board",
      "Quarter",
      "Seen 0-18 Weeks",
      "Total Seen",
      "Percentage Started Treatment"
    )
  )
})




## Table 1 download button ---- 
output$T2_1_table_download <- downloadHandler(
  filename = 'T2 - children & young people started treatment CAMHS.csv',
  content = function(file) {
    
    download_data <- T2_trendPlot_data() |>
      select(hb_name, quarter_end, patients_seen, total_patients_seen, 
             percent_seen_for_band) |>
      rename(
        "Health Board" = hb_name,
        "Quarter" = quarter_end,
        "Seen 0-18 Weeks" = patients_seen,
        "Total Seen" = total_patients_seen,
        "Percentage Started Treatment (%)" = percent_seen_for_band
      )
    
    write.csv(
      download_data,
      file,
      row.names = FALSE
    )
  }
)