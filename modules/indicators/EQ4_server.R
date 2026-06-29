# EQ4 Trends Plot(s) ----

# Graphs: 
# 1.Bar chart showing total admissions and non CAMHs admissions at Scotland level 
# 2. HB trend graph - user selects up to 4 HBs to compare percentage of non camhs admissions

# Graph 1 - Scotland figures ----
output$EQ4_Plot <- renderPlotly({
  
  # Assigning to an object so can add "NA" annotations after: 
  EQ4_plotly_graph <- plot_ly(data = EQ4_Scotland,
                              
                              x = ~quarter_fy, y = ~total_Ads_nonC_hb_Quarter, 
                              name = str_wrap("Admissions outwith CAMHs", 26),
                              ## Tooltip text
                              text = paste0(
                               "Financial quarter: ",
                                EQ4_Scotland$quarter_fy,
                                "<br>",
                                "Number of admissions outwith CAMHs: ", prettyNum(EQ4_Scotland$total_Ads_nonC_hb_Quarter, big.mark = ",")), 
                              hoverinfo = "text",
                              
                              ## Bar aesthetics
                              type = 'bar', 
                              marker = list(color = "#3393DD",
                                            size = 12),
                              textposition = "none", # remove small text on each bar
                              height = 600) %>% # Size of graph
    
    # Add the Total appointments trace
    add_trace(y = ~total_Ads_hb_Quarter, name = "Total admissions", 
              marker = list(color = "#B3D7F2"),
              text = paste0(
                "Calendar quarter: ",
                EQ4_Scotland$quarter_fy,
                "<br>",
                "Total number of admissions: ", prettyNum(EQ4_Scotland$total_Ads_hb_Quarter, big.mark = ","))) %>% 
    
    layout(
      barmode = 'group', 
      font = list(size = 13), 
      yaxis = list(
        # Wrap the y axis title in spaces so it doesn't cover the tick labels.
        title = paste0(c(rep("&nbsp;", 20),
                         "Number of Admissions", 
                         rep("&nbsp;", 20),
                         rep("\n&nbsp;", 3)),
                       collapse = ""),
        exponentformat = "none",
        
        showline = TRUE, 
        ticks = "outside",
        tickformat=","  # Adds commas for thousands
      ),
      
      # Create diagonal x-axis ticks
      xaxis = list(tickangle = -45, 
                   title = paste0(c(rep("&nbsp;", 20),
                                    "<br>",
                                    "<br>",
                                    "Financial Quarter", 
                                    rep("&nbsp;", 20),
                                    rep("\n&nbsp;", 3)),
                                  collapse = ""),
                   showline = TRUE, 
                   ticks = "outside"),
      # Set the graph margins.
      margin = list(l = 90, r = 90, b = 170, t = 90)) %>%
    
    # Remove any buttons we don't need from the modebar.
    config(displayModeBar = TRUE,
           modeBarButtonsToRemove = list('select2d', 'lasso2d', 
                                         # 'zoomIn2d', 'zoomOut2d', 'autoScale2d', 
                                         'toggleSpikelines', 
                                         'hoverCompareCartesian', 
                                         'hoverClosestCartesian'), 
           displaylogo = F, editable = F)
})

# table below chart including HB ----
# Reactive expression for filtered & formatted data
filtered_EQ4_HB <- reactive({
  req(input$hb_filter)  # Ensure input is available
  
  # Filter based on dropdown
  data_filtered <- if (input$hb_filter == "All") {
    EQ4_HB
  } else {
    dplyr::filter(EQ4_HB, board == input$hb_filter)
  }
  
  # Format numeric columns
  data_filtered %>%
    dplyr::mutate(
      total_Ads_nonC_hb_Quarter = if_else(
        is.na(total_Ads_nonC_hb_Quarter),
        "NA",
        formatC(total_Ads_nonC_hb_Quarter,
                format = "f", digits = 0, big.mark = ",")
      ),
      total_Ads_hb_Quarter = if_else(
        is.na(total_Ads_hb_Quarter),
        "NA",
        formatC(total_Ads_hb_Quarter,
                format = "f", digits = 0, big.mark = ",")
      )
    )
})

# Render the table
output$EQ4_HB_table <- DT::renderDataTable({
  DT::datatable(
    filtered_EQ4_HB(),
    style = "bootstrap",
    class = "table-bordered table-condensed",
    rownames = FALSE,
    options = list(
      pageLength = 16,
      autoWidth = FALSE,
      dom = "tip",
      columnDefs = list(
        list(className = "dt-right", targets = 1:3)
      )
    ),
    colnames = c(
      "Board" = "board",
      "Financial Quarter" = "quarter_fy",
      "Admissions outwith CAMHs" = "total_Ads_nonC_hb_Quarter",
      "Total Admissions" = "total_Ads_hb_Quarter"
    )
  )
})

# Download handler for filtered data
output$download_EQ4_HB <- downloadHandler(
  filename = function() {
    paste0("EQ4_HB_", gsub(" ", "_", input$hb_filter), "_", Sys.Date(), ".csv")
  },
  content = function(file) {
    # Get filtered data
    df <- filtered_EQ4_HB()
    
    # Validate data before writing
    if (nrow(df) == 0) {
      stop("No data available to download.")
    }
    
    # Rename columns safely (only if they exist in df)
    rename_map <- c(
      "Board" = "board",
      "Financial Quarter" = "quarter_fy",
      "Admissions outwith CAMHs" = "total_Ads_nonC_hb_Quarter",
      "Total Admissions" = "total_Ads_hb_Quarter"
    )
    
    # Match and rename columns
    for (new_name in names(rename_map)) {
      old_name <- rename_map[[new_name]]
      if (old_name %in% colnames(df)) {
        colnames(df)[colnames(df) == old_name] <- new_name
      }
    }
    
    # Write CSV with renamed columns
    write.csv(df, file, row.names = FALSE)
  }
)


# output$download_EQ4_HB <- downloadHandler(
#   filename = function() {
#     paste0("EQ4_HB_", gsub(" ", "_", input$hb_filter), "_", Sys.Date(), ".csv")
#   },
#   content = function(file) {
#     # Write filtered data to CSV
#     write.csv(filtered_EQ4_HB(), file, row.names = FALSE)
#   }
# )


# Graph 2 - comparing HBs over time ---- 

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
