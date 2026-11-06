# T2 Trends Plot(s) ----

# Graph 1 - comparing HBs over time ----

## Health Board Selector ---- 
# Picker for user selecting up to 4 health boards
output$T2_trendPlot_hbName_output <- renderUI({
  
  create_hb_picker(
    input_id = "T2_trendPlot_hbName",
    choices = T2_data$hb_name,
    selected = "NHS Scotland"
  )
  
})

## Graph data reactive ----
T2_trendPlot_data <- reactive({

  req(input$T2_trendPlot_hbName)
  
  T2_data |>
    filter(hb_name %in% input$T2_trendPlot_hbName) 
  
})


## Create the T2 line chart ----
output$T2_trendPlot <- renderPlotly({
  
  t <- create_trend_plot(
    data = T2_trendPlot_data(),
    
    x_column = "quarter_end",
    y_column = "percent_seen_for_band",
    group_column = "hb_name",
    
    y_axis_title = "% seen within target",
    tooltip_value_title = "% seen within target",
    tooltip_value_comma = TRUE,
    x_axis_title = "Quarter"
  )
  
  t %>%
    layout(
      shapes = list(
        list(
          type = "line",
          xref = "paper",
          x0 = 0,
          x1 = 1,
          yref = "y",
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
          x = 1,
          y = 90,
          xref = "paper",
          yref = "y",
          text = "90% standard",
          showarrow = FALSE,
          xanchor = "right",
          yanchor = "bottom",
          font = list(
            color = "red",
            size = 12
          )
        )
      )
    )
  
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