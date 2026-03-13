### [ S1 PLOT 1 - Suicide rate per 100,000 population ] ----

## Picker for selecting HB or CA ----

output$S1_plot1_areaType_output <- renderUI({
    shinyWidgets::pickerInput(
        "S1_plot1_areaType",
        label = "Select type of geography:",
        choices = S1_unique_area_types,
        selected = "Health board" # Currently the only option
    )
})

## Picker for user selecting specific geographies ----

output$S1_plot1_areaName_output <- renderUI({
    shinyWidgets::pickerInput(
        "S1_plot1_areaName",
        label = "Select area:",
        choices = sort(unique(as.character(
            S1_data$area_name
            [S1_data$area_type %in% input$S1_plot1_areaType]
        )))
        ,
        multiple = TRUE,
        options = list(
            "max-options" = 1,
            `selected-text-format` = "count > 1"
        ),
        selected = "NHS Scotland" # Currently the only option
    )
})

## Graph 1 title ----
output$S1_plot1_title <- renderUI({
    
    # Measures section
    req(input$S1_plot1_areaName)
    
    paste0("Crude rate (per 100,000) of death by probable suicide by calendar year in ",
           input$S1_plot1_areaName, " (Scottish residents aged 5+ only):")
    
    
})

## Selecting appropriate data for graph 1 ----

S1_plot1_Data <- reactive({
    S1_data %>%
        select(year,
               area_type,
               area_name,
               suicide_rate) %>%
        filter(area_type %in% input$S1_plot1_areaType
               & area_name %in% input$S1_plot1_areaName)
})


# Create the crude rate line chart ----

### Create Plotly graph ----

output$S1_plot1 <- renderPlotly({
    
    plot_ly(data = S1_plot1_Data(),
            
            x = ~year, y = ~suicide_rate, color = ~area_name,
            
            # Tooltip text
            text = paste0(
                "Calendar year: ",
                # for tooltip in ggplotly - shows values on hover
                S1_plot1_Data()$year,
                "<br>",
                "Area of residence: ",
                S1_plot1_Data()$area_name,
                "<br>",
                "Suicide rate: ",
                S1_plot1_Data()$suicide_rate),
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
                range = list(0, max(S1_plot1_Data()$suicide_rate, na.rm = TRUE) * 110 / 100), 
                font = list(size = 13),
                # Wrap the y axis title in spaces so it doesn't cover the tick labels
                title = paste0(c(rep("&nbsp;", 20),
                                 "Crude rate (per 100,000)", 
                                 rep("&nbsp;", 20),
                                 rep("\n&nbsp;", 3)),
                               collapse = ""),
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
                         # For range - we have 14 years up to 2024 - this will 
                         # need to be updated when new years are added to the code. 
                         # Edit will be to add 1 to the second figure with each new 
                         # quarter (i.e. it will be (-0.5, 14.5) for next update)
                         # Starting at -0.5 and ending at 13.5 gives much nicer 
                         # spacing on the axis than "0, 14"
                         range = list(-0.5, 13.5),
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

## Picker for user selecting HB or CA ----

output$S1_plot2_areaType_output <- renderUI({
    shinyWidgets::pickerInput(
        "S1_plot2_areaType",
        label = "Select type of geography:",
        choices = S1_unique_area_types,
        selected = "Health board" # Currently the only option
    )
})

## Picker for user selecting specific geographies ----
output$S1_plot2_areaName_output <- renderUI({
    shinyWidgets::pickerInput(
        "S1_plot2_areaName",
        label = "Select area:",
        choices = sort(unique(
            as.character(S1_data$area_name
                         [S1_data$area_type %in% input$S1_plot2_areaType])
        )),
        multiple = TRUE,
        options = list(
            "max-options" = 1,
            `selected-text-format` = "count > 1"
        ),
        selected = "NHS Scotland" # Currently the only option
    )
})

## Graph 2 title ----
output$S1_plot2_title <- renderUI({
    
    # Measures section
    req(input$S1_plot2_areaName)
    
    paste0("Count of all deaths and deaths by probable suicide in ",
           input$S1_plot2_areaName, " by calendar year:")
    
})

## Selecting appropriate data for graph 2 ----

S1_plot2_selectedData <- reactive({
    S1_data %>%
        select(year,
               area_type,
               area_name,
               all_deaths,
               probable_suicide_deaths) %>%
        filter(area_type %in% input$S1_plot2_areaType
               & area_name %in% input$S1_plot2_areaName)
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