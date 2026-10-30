## [ S1 PLOT 1 - Suicide rate per 100,000 population ] ----

## Shared geography type picker ----
output$S1_plot1_areaType_output <- renderUI({
  
  shinyWidgets::pickerInput(
    "S1_plot_areaType",
    label = "Select type of geography:",
    choices = "Health board",
    selected = "Health board"
  )
  
})

output$S1_plot1_areaName_output <- renderUI({
  
  shinyWidgets::pickerInput(
    "S1_plot_areaName",
    label = "Select area:",
    choices = "NHS Scotland",
    selected = "NHS Scotland"
  )
  
})

## Graph 1 title ----
output$S1_plot1_title <- renderUI({
    
    # Measures section
    req(input$S1_plot_areaName)
    
    paste0("Crude rate (per 100,000) of death by probable suicide by calendar year in ",
           input$S1_plot_areaName, " (Scottish residents aged 5+ only):")
    
    
})

## Selecting appropriate data for graph 1 ----

S1_plot1_Data <- reactive({
    S1_data %>%
        select(year,
               area_type,
               area_name,
               suicide_rate) %>%
     filter(
       area_type == input$S1_plot_areaType,
       area_name == input$S1_plot_areaName
     )
})


# Create the crude rate line chart ----

## Create Plotly graph ----
output$S1_plot1 <- renderPlotly({
    create_trend_plot(
    data = S1_plot1_Data(),
    x_column = "year",
    y_column = "suicide_rate",
    group_columns = "area_name",
    group_titles = "Area of residence",
    style_column = "area_name",
    x_axis_title = "Calendar year",
    y_axis_title = "Crude rate (per 100,000)",
    tooltip_value_title = "Suicide rate"
  )
})


## Graph 1 Table ----
# Year, area_type, area_name, crude rate per 100,000
output$S1_1_table <- renderDataTable({
    datatable(S1_plot1_Data() %>%
                  # Add commas to large numbers but keep "NA" as a visible value on dashboard:
                  mutate(suicide_rate = if_else(is.na(suicide_rate),
                                                "NA",
                                                formatC(suicide_rate,
                                                        format = "f",
                                                        digits = 1, # digits after decimal point
                                                        big.mark =","))),
              style = 'bootstrap',
              class = 'table-bordered table-condensed',
              rownames = FALSE,
              options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip',
                             # Right align numeric columns - it's column 4 but use 3 as rownames = FALSE
                             columnDefs = list(list(className = 'dt-right', targets = 3))),
              colnames = c("Calendar year",
                           "Area type",
                           "Area name",
                           "Crude suicide rate (per 100,000 population)")
    )
})


# Create download buttons that allows users to the download tables in .csv format.
output$S1_1_table_download <- downloadHandler(
    filename = 'S1 - Suicide rate per 100,000 population trends.csv',
    content = function(file) {
        write.table(
            S1_plot1_Data(),
            file,
            #Remove row numbers as the .csv file already has row numbers.
            row.names = FALSE,
            col.names = c("Calendar year",
                          "Area type",
                          "Area name",
                          "Crude suicide rate (per 100,000)"),
            sep = ",")
    }
)


### [ S1 PLOT 2 - Number of total deaths vs number of deaths by probable suicide ] ----

output$S1_plot2_areaType_output <- renderUI({
  
  shinyWidgets::pickerInput(
    "S1_plot_areaType",
    label = "Select type of geography:",
    choices = "Health board",
    selected = "Health board"
  )
  
})

output$S1_plot2_areaName_output <- renderUI({
  
  shinyWidgets::pickerInput(
    "S1_plot_areaName",
    label = "Select area:",
    choices = "NHS Scotland",
    selected = "NHS Scotland"
  )
  
})

## Graph 2 title ----
output$S1_plot2_title <- renderUI({
    
    # Measures section
    req(input$S1_plot_areaName)
    
    paste0("Count of all deaths and deaths by probable suicide in ",
           input$S1_plot_areaName, " by calendar year:")
    
})

## Selecting appropriate data for graph 2 ----

S1_plot2_selectedData <- reactive({
    S1_data %>%
        select(year,
               area_type,
               area_name,
               all_deaths,
               probable_suicide_deaths) %>%
    filter(
      area_type == input$S1_plot_areaType,
      area_name == input$S1_plot_areaName
    )
})


# Create the combined deaths and probable suicides bar chart ----

### Create plotly graph ----
output$S1_plot2 <- renderPlotly({
    
    plot_ly(data = S1_plot2_selectedData(),
            
            x = ~year, y = ~all_deaths, 
            name = str_wrap("All deaths", 26),
            ## Tooltip text
            text = paste0(
                "Calendar year: ",
                S1_plot2_selectedData()$year,
                "<br>",
                "Area of residence: ",
                S1_plot2_selectedData()$area_name,
                "<br>",
                "All deaths: ",
                prettyNum(S1_plot2_selectedData()$all_deaths, big.mark = ",")),
            hoverinfo = "text",
            
            ## Bar aesthetics
            type = 'bar', 
            marker = list(color = "#3393DD",
                          size = 12),
            textposition = "none", # remove small text on each bar
            height = 600) %>% # Size of graph
        
        # Add the probable suicides trace
        add_trace(y = ~probable_suicide_deaths, 
                  name = str_wrap("Deaths by probable suicide", 26),
                  marker = list(color = "#B3D7F2"),
                  text = paste0(
                      "Calendar year: ",
                      S1_plot2_selectedData()$year,
                      "<br>",
                      "Area of residence: ",
                      S1_plot2_selectedData()$area_name,
                      "<br>",
                      "Deaths by probable suicide: ",
                      S1_plot2_selectedData()$probable_suicide_deaths,
                      "<br>",
                      "Percentage of all deaths: ",
                      round(100*(S1_plot2_selectedData()$probable_suicide_deaths/S1_plot2_selectedData()$all_deaths), 1), "%")
        ) %>% 
        
        layout(
            barmode = 'group', # Set the type of bar chart
            font = list(size = 13), # Set the font sizes.
            yaxis = list(
                # Wrap the y axis title in spaces so it doesn't cover the tick labels.
                title = paste0(c(rep("&nbsp;", 20),
                                 "Count of deaths", 
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

# Year, area_type, area_name, count of all deaths, count of probable suicides
output$S1_2_table <- renderDataTable({
    datatable(
        S1_plot2_selectedData() %>%
            # Add commas to large numbers but keep "NA" as a visible value on dashboard:
            mutate(all_deaths = if_else(is.na(all_deaths), 
                                        "NA", 
                                        formatC(all_deaths,
                                                format = "f",
                                                digits = 0, # digits after decimal point
                                                big.mark =",")),
                   probable_suicide_deaths = if_else(is.na(probable_suicide_deaths),
                                                     "NA", 
                                                     formatC(probable_suicide_deaths,
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
                     "Count of all deaths",
                     "Count of deaths by probable suicide")
    )
})

# Download button 
output$S1_2_table_download <- downloadHandler(
    filename = "S1 - Count of deaths and probable suicides by calendar year.csv",
    content = function(file) {
        write.table(
            S1_plot2_selectedData(),
            file,
            #Remove row numbers as the .csv file already has row numbers.
            row.names = FALSE,
            col.names = c("Calendar year",
                         "Area type",
                         "Area name",
                         "Count of all deaths",
                         "Count of deaths by probable suicide"),
            sep = ",")
    }
)