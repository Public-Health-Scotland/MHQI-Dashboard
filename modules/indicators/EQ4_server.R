# EQ4 Trends Plot(s) ----

# Picker for selecting region bar chart ----
output$EQ4_board_select <- renderUI({

  board_choices <- EQ4_region_fy |>
    filter(!is.na(region),
           region != "NHS Scotland"
    ) |>
    distinct(region) |>
    arrange(region) |>
    pull(region)

  shinyWidgets::pickerInput(
    inputId = "EQ4_board",
    label = "Select region:",
    choices = board_choices,
    selected = board_choices[1],
    multiple = FALSE
  )

})

# bar chart title ----
EQ4_plot_title <- reactive({
  
  req(input$EQ4_geo, input$EQ4_period)
  
  time_part <- if (input$EQ4_period == "quarter") {
    "quarter end"
  } else {
    "financial year"
  }
  
  geo_part <- if (input$EQ4_geo == "scotland") {
    "NHS Scotland"
  } else {
    req(input$EQ4_board)
    input$EQ4_board
  }
  
  paste(
    "Under 18 psychiatric admissions admitted outwith CAMH wards and total admissions by",
    time_part,
    "in",
    geo_part
  )
  
})


# render text for ui
output$EQ4_dynamic_title <- renderText({
  EQ4_plot_title()
})

# bar chart - fix data and plot ----
EQ4_trendPlot_data <- reactive({
  
  req(input$EQ4_geo)
  
  if (input$EQ4_geo == "scotland") {
    
    req(input$EQ4_period)
    
    # Scotland Quarter ----
    
    if (input$EQ4_period == "quarter") {
      
      graph_data <- EQ4_data |>
        filter(
          board == "NHS Scotland",
          !is.na(quarter_end)
        ) |>
        distinct(
          quarter_end,
          .keep_all = TRUE
        ) |>
        arrange(quarter_end)
      
      quarter_levels <- graph_data |>
        pull(quarter_end) |>
        as.character()
      
      graph_data <- graph_data |>
        mutate(
          graph_period = factor(
            as.character(quarter_end),
            levels = quarter_levels,
            ordered = TRUE
          ),
          geography = "NHS Scotland"
        )
      
    } else {
      
      # Scotland Financial Year ----
      
      graph_data <- EQ4_data |>
        filter(
          financial_year != "2026/27",
          board == "NHS Scotland",
          !is.na(financial_year)
        ) |>
        group_by(financial_year) |>
        summarise(
          total_non_camhs = sum(total_non_camhs, na.rm = TRUE),
          total_u18 = sum(total_u18, na.rm = TRUE),
          .groups = "drop"
        ) |>
        arrange(financial_year)
      
      fy_levels <- graph_data |>
        pull(financial_year) |>
        as.character()
      
      graph_data <- graph_data |>
        mutate(
          graph_period = factor(
            financial_year,
            levels = fy_levels,
            ordered = TRUE
          ),
          geography = "NHS Scotland"
        )
      
    }
    
  } else {
    
    # Region financial year ----
    
    req(input$EQ4_board)
    
    graph_data <- EQ4_region_fy |>
      filter(
        region == input$EQ4_board,
        !is.na(financial_year)
      ) |>
      distinct(
        financial_year,
        .keep_all = TRUE
      ) |>
      arrange(financial_year)
    
    fy_levels <- graph_data |>
      pull(financial_year) |>
      as.character()
    
    graph_data <- graph_data |>
      mutate(
        graph_period = factor(
          as.character(financial_year),
          levels = fy_levels,
          ordered = TRUE
        ),
        geography = region
      )
    
  }
  
  graph_data
  
})

# Plot ----

output$EQ4_combined_plot <- renderPlotly({
  
  plot_data <- EQ4_trendPlot_data()
  
  req(nrow(plot_data) > 0)
  
  if (
    input$EQ4_geo == "scotland" &&
    input$EQ4_period == "quarter"
  ) {
    
    x_axis_title <- "Quarter ending"
    
  } else {
    
    x_axis_title <- "Financial year"
    
  }
  
  plot_ly() |>
    
    add_bars(
      data = plot_data,
      x = ~graph_period,
      y = ~total_non_camhs,
      
      name = "Non-CAMHS admissions",
      
      marker = list(
        color = "#3393DD"
      ),
      
      hovertext = ~paste0(
        x_axis_title, ": ", graph_period,
        "<br>Geography: ", geography,
        "<br>Non-CAMHS admissions: ",
        prettyNum(total_non_camhs, big.mark = ",")
      ),
      
      hoverinfo = "text"
    ) |>
    
    add_bars(
      data = plot_data,
      x = ~graph_period,
      y = ~total_u18,
      
      name = "Total Admissions",
      
      marker = list(
        color = "#B3D7F2"
      ),
      
      hovertext = ~paste0(
        x_axis_title, ": ", graph_period,
        "<br>Geography: ", geography,
        "<br>Total Admissions: ",
        prettyNum(total_u18, big.mark = ",")
      ),
      
      hoverinfo = "text"
    ) |>
    
    layout(
      barmode = "group",
      
      xaxis = list(
        title = x_axis_title,
        categoryorder = "array",
        categoryarray = levels(plot_data$graph_period)
      ),
      
      yaxis = list(
        title = "Number of Admissions"
      )
    )
})


## Graph 1 table ----
# Data table ----
output$EQ4_1_table <- renderDataTable({
  
  datatable(
    EQ4_trendPlot_data() |>
      mutate(
        `Non-CAMHS admissions` = format(
          total_non_camhs,
          big.mark = ",",
          scientific = FALSE
        ),
        `Total admissions` = format(
          total_u18,
          big.mark = ",",
          scientific = FALSE
        ),
        Period = as.character(graph_period)
      ) |>
      select(
        Geography = geography,
        Period,
        `Non-CAMHS admissions`,
        `Total admissions`
      ),
    
    style = "bootstrap",
    class = "table-bordered table-condensed",
    rownames = FALSE,
    
    options = list(
      pageLength = 16,
      autoWidth = FALSE,
      dom = "tip",
      columnDefs = list(
        list(className = "dt-right", targets = c(2, 3))
      )
    )
  )
  
})

# Download table ----
output$EQ4_1_table_download <- downloadHandler(
  
  filename = function() {
    paste0("EQ4_table_", Sys.Date(), ".csv")
  },
  
  content = function(file) {
    
    download_data <- EQ4_trendPlot_data()
    
    req(nrow(download_data) > 0)
    
    download_data <- download_data |>
      mutate(
        period = as.character(graph_period)
      ) |>
      select(
        Geography = geography,
        Period = period,
        `Non-CAMHS admissions` = total_non_camhs,
        `Total admissions` = total_u18
      )
    
    write.csv(
      download_data,
      file,
      row.names = FALSE,
      na = ""
    )
  }
)


# Graph 2 - percentages, comparing HBs over time ---- 

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
    selected = "NHS Scotland")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EQ4_trendPlot_data_2 <- reactive({
  req(input$EQ4_trendPlot_hbName)
  
  EQ4_data %>%
    select(board, quarter_end, perc) %>% 
    filter(board %in% input$EQ4_trendPlot_hbName)
})


## Create the EQ4 line chart ----

### Render plotly ----

output$EQ4_plot2 <- renderPlotly({ 
  EQ4_plotly_graph2 <- plot_ly(data = EQ4_trendPlot_data_2(),
                               
                               x = ~quarter_end, 
                               y = ~perc, 
                               color = ~board, 
                               
                               # Tooltip text
                               text = paste0("Financial quarter: ",                
                                             EQ4_trendPlot_data_2()$quarter_end, 
                                             "<br>",
                                             "Health board: ",
                                             EQ4_trendPlot_data_2()$board,
                                             "<br>",
                                             "Percentage of Admissons outwith CAMH wards: ",
                                             EQ4_trendPlot_data_2()$perc), 
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
                               name = ~str_wrap(board, 15)
  ) %>%
    
    layout(# graph title is in a box above the graph and Orkney/Shetland 
      # reminder title is below this code. 
      yaxis = list(exponentformat = "none",
                   range = c(0, max(EQ4_trendPlot_data_2()$perc, na.rm = TRUE) * 1.3), 
                   
                   
                   # Wrap the y axis title in spaces so it doesn't cover the tick labels.
                   title = paste0(c(rep("&nbsp;", 20),
                                    print("Percentage of Admissons outwith CAMH wards"), 
                                    rep("&nbsp;", 20),
                                    rep("\n&nbsp;", 3)),
                                  collapse = ""),
                   showline = TRUE, 
                   ticks = "outside"
      ),
      
      xaxis = list(tickangle = -45,                    # Diagonal x-axis ticks
                   title = paste0(c(rep("&nbsp;", 20),
                                    "<br>",
                                    "<br>",
                                    "Quarter end",
                                    rep("&nbsp;", 20),
                                    rep("\n&nbsp;", 3)),
                                  collapse = ""),
                   # For range: we have 12 quarters up to Dec 2024 - this will 
                   # need to be updated when new quarters are added to the code. 
                   # Edit will be to add 1 to the second figure with each new 
                   # quarter (i.e. it will be (-0.5, 12.5) for July 2025 update)
                   # Starting at -0.5 and ending at 11.5 gives much nicer 
                   # spacing on the axis than "0, 12"
                   range = list(-0.5, 16.5),
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
      legend = list(
        x = 1,
        y = 0.8, 
        bgcolor = 'rgba(255, 255, 255, 0)', 
        bordercolor = 'rgba(255, 255, 255, 0)')
    ) %>%
    
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
  EQ4_plotly_graph2  
  
})


## Table below graph 2 ----
output$EQ4_table2 <- renderDataTable({
  datatable(
    EQ4_trendPlot_data_2() %>% 
      mutate(perc = paste0(formatC(perc,
                                   format = "f",
                                   #digits after decimal point
                                   digits = 1), " %")
      ),
    style = 'bootstrap',
    class = 'table-bordered table-condensed',
    rownames = FALSE,
    options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                   # Right align numeric columns - it's columns 4:5 but use 3:4 as rownames = FALSE
                   columnDefs = list(list(className = 'dt-right', targets = 2))), 
    colnames = c("Health Board",
                 "Quarter end",
                 "Percentage of Admissons outwith CAMH wards"))
})


## Table 2 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$download_EQ4_table2 <- downloadHandler(
  filename = 'EQ4 - Percentage of admissions outwith camhs.csv',
  content = function(file) {
    write.table(EQ4_trendPlot_data_2(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("NHS Health Board",
                              "Quarter end",
                              "Percentage of Admissons outwith CAMH wards"),
                sep = ",")
  })
