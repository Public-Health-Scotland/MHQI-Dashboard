### [ EQ1 PLOT 1 - Premature Mortality Trend ] ----

## Picker for selecting HB or CA ----
output$EQ1_plot1_areaType_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot1_areaType",
    label = "Select type of geography:",
    choices = EQ1_unique_area_types,
    selected = "Health board"
  )
})

## Picker for user selecting specific geographies ----
output$EQ1_plot1_areaName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot1_areaName",
    label = "Select area(s) (Maximum 4):",
    choices = unique(as.character(
      EQ1_data$area_name
      [EQ1_data$area_type %in% input$EQ1_plot1_areaType]
    ))
    ,
    multiple = TRUE,
    options = list(
      "max-options" = 4,
      `selected-text-format` = "count > 1"
    ),
    selected = "NHS Scotland"
  )
})

## Graph 1 title ----
output$EQ1_plot1_title <- renderUI({
  
  # Measures section
  req(input$EQ1_plot1_areaType)
  
  paste0("Premature mortality risk ratio for mental health service patients compared ",
         "to general population in selected ", str_to_lower(input$EQ1_plot1_areaType), "(s), by calendar year:")

  
})

## Selecting appropriate data for graph 1 ----
EQ1_plot1_Data <- reactive({
  EQ1_data %>%
    select(Year,
           area_type,
           area_name,
           risk_ratio,
           SMR04_Pop_Mortality_Rate,
           General_Pop_Mortality_Rate) %>%
    mutate(risk_ratio = round(risk_ratio, 2)) %>%      # because values are e.g., "5.239755"
    filter(area_type %in% input$EQ1_plot1_areaType
           & area_name %in% input$EQ1_plot1_areaName)
})


# Create the risk ratios line chart ----
### Create Plotly graph ----
output$EQ1_plot1 <- renderPlotly({
  create_trend_plot1(
    data = EQ1_plot1_Data(),
    x_column = "Year",
    y_column = "risk_ratio",
    group_column = "area_name",
    x_axis_title = "Calendar year",
    y_axis_title = "Premature mortality risk ratio",
    group_title = "Area of residence",
    tooltip_value_title = "Premature mortality risk ratio"
  )
})


## Graph 1 Table ----
# Year, area_type, area_name, risk_ratio, SMR04_Pop_Rate, General_Pop_Rate
output$EQ1_1_table <- renderDataTable({
  datatable(EQ1_plot1_Data() %>% 
              # Add commas to large numbers but keep "NA" as a visible value on dashboard:
              mutate(SMR04_Pop_Mortality_Rate = if_else(is.na(SMR04_Pop_Mortality_Rate), 
                                           "NA", 
                                           formatC(SMR04_Pop_Mortality_Rate,
                                                   format = "f",
                                                   digits = 0, # digits after decimal point
                                                   big.mark =",")),
                     General_Pop_Mortality_Rate = if_else(is.na(General_Pop_Mortality_Rate),
                                                        "NA", 
                                                        formatC(General_Pop_Mortality_Rate,
                                                                format = "f",
                                                                digits = 0, # digits after decimal point
                                                                big.mark =","))),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                           # Right align numeric columns - it's columns 4:6 but use 3:5 as rownames = FALSE
                           columnDefs = list(list(className = 'dt-right', targets = 3:5))), 
            colnames = c("Calendar year",
                         "Area type",
                         "Area name",
                         "Risk ratio",
                         "SMR04 population rate (per 100,000)",
                         "General population rate (per 100,000)")
            )
  })


# Create download buttons that allows users to the download tables in .csv format.
output$EQ1_1_table_download <- downloadHandler(
  filename = 'EQ1 - Mortality rate risk ratio trends.csv',
  content = function(file) {
    write.table(
      EQ1_plot1_Data(),
      file,
      #Remove row numbers as the .csv file already has row numbers.
      row.names = FALSE,
      col.names = c(
        "Calendar year",
        "Area type",
        "Area name",
        "Risk ratio",
        "SMR04 population rate (per 100,000)",
        "General population rate (per 100,000)"
      ),
      sep = ","
    )
  }
)


### [ EQ1 PLOT 2 - Mortality rates in general population Vs mental health population ] ----

## Picker for user selecting HB or CA ----

output$EQ1_plot2_areaType_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot2_areaType",
    label = "Select type of geography:",
    choices = EQ1_unique_area_types,
    selected = "Health board"
  )
})

## Picker for user selecting specific geographies ----
output$EQ1_plot2_areaName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot2_areaName",
    label = "Select area:",
    choices = unique(
      as.character(EQ1_reformatted_data$area_name
                   [EQ1_reformatted_data$area_type %in% input$EQ1_plot2_areaType])
    ),
    multiple = TRUE,
    options = list(
      "max-options" = 1,
      `selected-text-format` = "count > 1"
    ),
    selected = "NHS Scotland"
  )
})

## Graph 2 title ----
output$EQ1_plot2_title <- renderUI({
  
  # Measures section
  req(input$EQ1_plot2_areaName)
  
  paste0("General population and mental health population mortality rates (per 100,000) in ",
         input$EQ1_plot2_areaName, ", by calendar year:")

})

## Selecting appropriate data for graph 2 ----

EQ1_plot2_selectedData <- reactive({
  EQ1_plot2_data %>%
    select(Year,
           area_type,
           area_name,
           mh_rate,
           genpop_rate) %>%
    filter(area_type %in% input$EQ1_plot2_areaType
           & area_name %in% input$EQ1_plot2_areaName)
})


# Create the combined general population and MH rates bar chart ----

### Create plotly graph ----

output$EQ1_plot2 <- renderPlotly({
  
  plot_ly(data = EQ1_plot2_selectedData(),
          
          x = ~Year, y = ~mh_rate, 
          name = str_wrap("Mental Health Population Mortality Rate", 26),
          ## Tooltip text
          text = paste0(
            "Calendar year: ",
            EQ1_plot2_selectedData()$Year,
            "<br>",
            "Area of residence: ",
            EQ1_plot2_selectedData()$area_name,
            "<br>",
            "Mental Health Population Mortality",
            "<br>",
            "Rate (per 100,000 population): ",
            prettyNum(EQ1_plot2_selectedData()$mh_rate, big.mark = ",")),
          hoverinfo = "text",
          
          ## Bar aesthetics
          type = 'bar', 
          marker = list(color = "#3393DD",
                        size = 12),
          textposition = "none", # remove small text on each bar
          height = 600) %>% # Size of graph
    
    # Add the Total appointments trace
    add_trace(y = ~genpop_rate, 
              name = str_wrap("General Population Mortality Rate", 26),
              marker = list(color = "#B3D7F2"),
              text = paste0(
                "Calendar year: ",
                EQ1_plot2_selectedData()$Year,
                "<br>",
                "Area of residence: ",
                EQ1_plot2_selectedData()$area_name,
                "<br>",
                "General Population Mortality",
                "<br>",
                "Rate (per 100,000 population): ",
                EQ1_plot2_selectedData()$genpop_rate)) %>% 
    
    layout(
      barmode = 'group', # Set the type of bar chart
      font = list(size = 13), # Set the font sizes.
      yaxis = list(
        exponentformat = "none",
        separatethousands = TRUE, 
        # Wrap the y axis title in spaces so it doesn't cover the tick labels.
        title = paste0(c(rep("&nbsp;", 20),
                         "Mortality rate (per 100,000)", 
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
                                    "Calendar year", 
                                    rep("&nbsp;", 20),
                                    rep("\n&nbsp;", 3)),
                                  collapse = ""),
                   showline = TRUE, 
                   ticks = "outside"),
      # Legend parameters
      # legend = list(orientation = "h",   # show entries horizontally
      #               xanchor = "center",  # use center of legend as anchor
      #               x = 0.5),             # put legend in center of x-axis
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


### Tables below graphs ----

# Rate_Type, Year, area_type, area_name, Rate
output$EQ1_2_table <- renderDataTable({
  datatable(
    EQ1_plot2_selectedData() %>% 
      # Add commas to large numbers but keep "NA" as a visible value on dashboard:
      mutate(mh_rate = if_else(is.na(mh_rate), 
                                      "NA", 
                                      formatC(mh_rate,
                                              format = "f",
                                              digits = 0, # digits after decimal point
                                              big.mark =",")),
             genpop_rate = if_else(is.na(genpop_rate),
                                        "NA", 
                                        formatC(genpop_rate,
                                                format = "f",
                                                digits = 0, # digits after decimal point
                                                big.mark =","))),
    style = 'bootstrap',
    class = 'table-bordered table-condensed',
    rownames = FALSE,
    options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                   # Right align numeric columns - it's columns 4:5 but use 3:4 as rownames = FALSE
                   columnDefs = list(list(className = 'dt-right', targets = 3:4))), 
    colnames = c("Calendar year",
                 "Area type",
                 "Area name",
                 "SMR04 population rate (per 100,000)",
                 "General population rate (per 100,000)")
  )
})

# Download button 
output$EQ1_2_table_download <- downloadHandler(
  filename = paste0("EQ1 - Mortality rate trend for chosen area.csv"),
  content = function(file) {
    write.table(
      EQ1_plot2_selectedData(),
      file,
      #Remove row numbers as the .csv file already has row numbers.
      row.names = FALSE,
      col.names = c("Calendar year",
                    "Area type",
                    "Area name",
                    "SMR04 population rate (per 100,000)",
                    "General population rate (per 100,000)"),
      sep = ","
    )
  }
)
