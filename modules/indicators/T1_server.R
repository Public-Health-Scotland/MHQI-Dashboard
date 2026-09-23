# T1 Trends Plot(s) ----

# Graph 1 - comparing HBs over time ----


## Health board selector ----

output$T1_trendPlot_hbName_output <- renderUI({
  
  shinyWidgets::pickerInput(
    inputId = "T1_trendPlot_hbName",
    label = "Select NHS health board",
    choices = T1_hb_names,
    multiple = FALSE,
    options = list(
      `max-options` = 4,
      `selected-text-format` = "count > 1"
    ),
    selected = "NHS Scotland"
  )
  
})


## Graph data reactive ----

T1_trendPlot_data <- reactive({
  
  # Prevent the reactive running before the picker input exists
  req(input$T1_trendPlot_hbName)
  
  T1_data |>
    filter(hb_name %in% input$T1_trendPlot_hbName) |>
    select(
      hb_name,
      quarter_end,
      weeks_band,
      percent_seen_for_band,
      total_patients_seen
    ) |>
    mutate(
      weeks_band = factor(
        weeks_band,
        levels = c(
          "0to18weeks",
          "19to35weeks",
          "36to52weeks",
          "over52weeks"
        ),
        labels = c(
          "0 to 18 weeks",
          "19 to 35 weeks",
          "36 to 52 weeks",
          "Over 52 weeks"
        )
      )
    ) |>
    arrange(quarter_end, hb_name, weeks_band)
  
})


## Create the T1 line chart ----

output$T1_trendPlot <- renderPlotly({
  
  graph_data <- T1_trendPlot_data()
  
  req(nrow(graph_data) > 0)
  
  number_of_quarters <- length(
    unique(graph_data$quarter_end)
  )
  
  maximum_y_value <- max(
    c(95, graph_data$percent_seen_for_band),
    na.rm = TRUE
  ) * 1.1
  
  T1_plot1_plotly <- plot_ly(
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
      "Quarter ending: ",
      quarter_end,
      "<br>",
      "Wait-time band: ",
      weeks_band,
      "<br>",
      "Percentage started treatment: ",
      percent_seen_for_band,
      "%",
      "<br>",
      "Total patients: ",
      total_patients_seen
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
        title = "Quarter ending",            # Axis title
        
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
  
  T1_plot1_plotly
  
})

## Table below graph 1 ----
output$T1_1_table <- renderDataTable({
  datatable(T1_trendPlot_data() %>% 
              #Add commas to large numbers but keep "NA" as a visible value on dashboard:
              mutate(
                percent_seen_for_band = if_else(
                  is.na(percent_seen_for_band),
                  "NA",
                  paste0(
                    formatC(percent_seen_for_band, 
                            format = "f", 
                            digits = 1),  # digits after decimal point
                    "%"
                  )
                )
              ),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                           # Right align numeric columns - it's columns 4:5 but use 3:4 as rownames = FALSE
                           columnDefs = list(list(className = 'dt-right', targets = 2:4))), 
            colnames = c("Quarter Ending",
                         "Health Board",
                         "Wait-time Band",
                         "Percentage Started Treatment",
                         "Total Patients Seen"))
})



## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$T1_1_table_download <- downloadHandler(
  filename = 'T1 - People started psychological therapy based treatment.csv',
  content = function(file) {
    write.table(T1_trendPlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Quarter Ending",
                              "NHS Health Board",
                              "Wait-time Band",
                              "Percentage Started Treatment",
                              "Total Patients Seen"),
                sep = ",")
  })
