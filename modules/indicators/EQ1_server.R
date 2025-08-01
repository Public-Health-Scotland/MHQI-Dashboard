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
    choices = sort(unique(as.character(
      EQ1_data$area_name
      [EQ1_data$area_type %in% input$EQ1_plot1_areaType]
    )))
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
  
  paste0("Premature mortality rate (per 100,000) for mental health service patients compared ",
         "to general population in selected ", str_to_lower(input$EQ1_plot1_areaType), "(s), by calendar year:")

  
})

## Selecting appropriate data for graph 1 ----

EQ1_plot1_Data <- reactive({
  EQ1_data %>%
    select(Year,
           area_type,
           area_name,
           risk_ratio,
           SMR04_Pop_Rate,
           General_Pop_Rate) %>%
    mutate(risk_ratio = round(risk_ratio, 2)) %>%      # because values are e.g., "5.239755"
    filter(area_type %in% input$EQ1_plot1_areaType
           & area_name %in% input$EQ1_plot1_areaName)
})


# Create the risk ratios line chart ----

### Create Plotly graph ----

output$EQ1_plot1 <- renderPlotly({

  plot_ly(data = EQ1_plot1_Data(),
          
          x = ~Year, y = ~risk_ratio, color = ~area_name,
          
          # Tooltip text
          text = paste0(
            "Calendar year: ",
            # for tooltip in ggplotly - shows values on hover
            EQ1_plot1_Data()$Year,
            "<br>",
            "Area of residence: ",
            EQ1_plot1_Data()$area_name,
            "<br>",
            "Premature mortality rate: ",
            EQ1_plot1_Data()$risk_ratio),
          hoverinfo = "text",
          
          # Line aesthetics=
          type = 'scatter', mode = 'lines+markers',
          line = list(width = 3),
          # Setting line colours - does not work
          colors = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
          linetype = ~area_name,
          linetypes = c("solid", "dot", "solid", "dot"),
          symbol = ~area_name, 
          symbols = c("circle", "square", "triangle-up", "triangle-down"),
          marker = list(size = 12),
          # Size of graph
          # width = 1000, 
          height = 600,
          # Legend info
          name = ~str_wrap(area_name, 15)) %>%
    
    layout(
      # y-axis attributes
      yaxis = list(
        exponentformat = "none",
        separatethousands = TRUE,
        range = list(0, max(EQ1_plot1_Data()$risk_ratio, na.rm = TRUE) * 110 / 100), 
        font = list(size = 13),
        # Wrap the y axis title in spaces so it doesn't cover the tick labels
        title = paste0(c(rep("&nbsp;", 20),
                              "Premature Mortality Rate (Per 100,000)", 
                              rep("&nbsp;", 20),
                              rep("\n&nbsp;", 3)),
                            collapse = ""),
        showline = TRUE, 
        ticks = "outside"
      ),
      
      
      xaxis = list(title = paste0(c(rep("&nbsp;", 20),
                                    "<br>",
                                    "<br>",
                                    "Calendar Year",
                                    rep("&nbsp;", 20),
                                    rep("\n&nbsp;", 3)),
                                  collapse = ""),
                   # For range - we have 5 years up to 2022 - this will 
                   # need to be updated when new years are added to the code. 
                   # Edit will be to add 1 to the second figure with each new 
                   # quarter (i.e. it will be (-0.5, 4.5) for next update)
                   # Starting at -0.5 and ending at 4.5 gives much nicer 
                   # spacing on the axis than "0, 5"
                   range = list(-0.5, 4.5),
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

## Graph 1 Table ----
# Year, area_type, area_name, risk_ratio, SMR04_Pop_Rate, General_Pop_Rate
output$EQ1_1_table <- renderDataTable({
  datatable(EQ1_plot1_Data() %>% 
              # Add commas to large numbers but keep "NA" as a visible value on dashboard:
              mutate(SMR04_Pop_Rate = if_else(is.na(SMR04_Pop_Rate), 
                                           "NA", 
                                           formatC(SMR04_Pop_Rate,
                                                   format = "f",
                                                   digits = 0, # digits after decimal point
                                                   big.mark =",")),
                     General_Pop_Rate = if_else(is.na(General_Pop_Rate),
                                                        "NA", 
                                                        formatC(General_Pop_Rate,
                                                                format = "f",
                                                                digits = 0, # digits after decimal point
                                                                big.mark =","))),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                           # Right align numeric columns - it's columns 4:6 but use 3:5 as rownames = FALSE
                           columnDefs = list(list(className = 'dt-right', targets = 3:5))), 
            colnames = c("Calendar Year",
                         "Area Type",
                         "Area Name",
                         "Risk Ratio",
                         "SMR04 Population Rate (Per 100,000)",
                         "General Population Rate (Per 100,000)")
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
        "Calendar Year",
        "Area Type",
        "Area Name",
        "Risk Ratio",
        "SMR04 Population Rate (Per 100,000)",
        "General Population Rate (Per 100,000)"
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
    choices = sort(unique(
      as.character(EQ1_reformatted_data$area_name
                   [EQ1_reformatted_data$area_type %in% input$EQ1_plot2_areaType])
    )),
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
    # select(Rate_Type, Year, area_type, area_name, Rate) %>%
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
            EQ1_plot2_selectedData()$mh_rate),
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
                "Financial year: ",
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
        # Wrap the y axis title in spaces so it doesn't cover the tick labels.
        title = paste0(c(rep("&nbsp;", 20),
                         "Mortality Rate (per 100,000)", 
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
                                    "Calendar Year", 
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
                 "Area Name",
                 "Area Type",
                 "SMR04 Population Rate (Per 100,000)",
                 "General Population Rate (Per 100,000)")
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
                    "Area Name",
                    "Area Type",
                    "SMR04 Population Rate (Per 100,000)",
                    "General Population Rate (Per 100,000)"),
      sep = ","
    )
  }
)