#### [ EF5 - 'Did Not Attend' appointments - Server ] ----

## Two graphs:
## HB trend graph - user can select multiple health boards to compare a single measure
## HB measures graph - user can select one health board to compare both 'number of' measures
## - % measure is included in the data table under graph

### [ EF5 Graph 1 - Health Board Trends ] ----

## Health Board selector ---- (multiple)
output$EF5_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "EF5_trendPlot_hbName",
      label = "Select NHS health board(s) (Maximum 4):",
      choices = EF5_hb_names,
      multiple = TRUE,
      options = list("max-options" = 4,
                     `selected-text-format` = "count > 1"),
      # No Scotland data on this one
      selected = "NHS Ayrshire & Arran"
      )
})

## Measure selector ---- (single)
output$EF5_trendPlot_measure_ouput <- renderUI({
  shinyWidgets::pickerInput(
    "EF5_trendPlot_measure",
    label = "Select measure to visualise:",
    choices = EF5_trend_measures,
    selected = "Percentage 'Did Not Attend' appointments"
    )
})

## Create text for graph title ui section ----
output$EF5_trendPlot_selected_measure <- renderUI({
  req(input$EF5_trendPlot_measure)
  paste0(input$EF5_trendPlot_measure, " in selected halth board(s), by calendar quarter:")
})

## Graph Data Reactive ---- 
# to create graph data based on HB selection
EF5_trendPlot_data <- reactive({
   EF5_data %>%
      filter(hb_name %in% input$EF5_trendPlot_hbName
             & measure %in% input$EF5_trendPlot_measure)
})

### Create the EF5 line chart ----

output$EF5_trendPlot <- renderPlotly({ 
   
     plot_ly(data = EF5_trendPlot_data(),
             
       x = ~year_months, y = ~value, color = ~hb_name,
       
       # Tooltip text
       text = paste0("Location: ",
                     EF5_trendPlot_data()$hb_name,
                     "<br>",
                     "Calendar Quarter: ",
                     EF5_trendPlot_data()$year_months,
                     "<br>",
                     EF5_trendPlot_data()$measure,": ", EF5_trendPlot_data()$value),
       hoverinfo = "text",
       
       # Line aesthetics=
       type = 'scatter', mode = 'lines+markers',
       line = list(width = 3),
                   # Setting line colours - does not work
       colors = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
       linetype = ~hb_name,
       linetypes = c("solid", "dot", "solid", "dot"),
       symbol = ~hb_name, 
       symbols = c("circle", "square", "triangle-up", "triangle-down"),
       marker = list(size = 12),
       # Size of graph
       # width = 1000, 
       height = 600,
       # Legend info
       name = ~str_wrap(hb_name, 15)) %>%
       
       layout(
         # y-axis attributes
         yaxis = list(
                exponentformat = "none",
                separatethousands = TRUE,
                range = c(0, max(EF5_trendPlot_data()$value, na.rm = TRUE) * 110 / 100), 
                
                # Wrap the y axis title in spaces so it doesn't cover the...
                # tick labels.
                title = list(font = list(size = 13)),
                paste0(c(rep("&nbsp;", 20),
                         print(c(input$EF5_trendPlot_measure)), 
                         rep("&nbsp;", 20),
                         rep("\n&nbsp;", 3)
                ), 
                collapse = ""),
                showline = TRUE, 
                ticks = "outside"
              ),
              
              # Create diagonal x-axis ticks
              xaxis = list(tickangle = -45, 
                           title = paste0(c(rep("&nbsp;", 20),
                                            "<br>",
                                            "<br>",
                                            "Calendar Quarter",
                                            rep("&nbsp;", 20),
                                            rep("\n&nbsp;", 3)),
                                          collapse = ""),
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

### Table below graph ----

output$EF5_trendPlot_table <- renderDataTable({
   datatable(EF5_trendPlot_data(),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("Health Board",
                          "Calendar Quarter",
                          "Measure",
                          "Value")
             )
})

# Create download button that allows users to download tables in .csv format.
output$EF5_trendPlot_table_download <- downloadHandler(
   filename = 'EF5 - Did not attend appointments.csv',
   content = function(file) {
      write.table(EF5_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Health Board",
                                "Calendar Quarter",
                                "Measure",
                                "Value"),
                  sep = ",")
      })


### [ EF5 Graph 2 - Health Board Measures ] ----

## Health Board selector ---- (single)
output$EF5_measurePlot_hbName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF5_measurePlot_hbName",
    label = "Select NHS Health Board:",
    choices = EF5_hb_names,
    # No Scotland data on this one
    selected = "NHS Ayrshire & Arran")
})

## Create text for graph title ui section ----
output$EF5_measurePlot_selected_hb <- renderUI({
  req(input$EF5_measurePlot_hbName)
  paste0("Number of 'Did Not Attend' appointments Vs Total number of appointments ", 
         "for mental health based community appointmnents in ",
         input$EF5_measurePlot_hbName,
         ":")
})

## Graph measure Data Reactive ----
# to create graph data based on HB selection
EF5_measurePlot_data <- reactive({
  EF5_measure_data %>%
    filter(hb_name %in% input$EF5_measurePlot_hbName)
})


## Create the EF5 bar chart ----
# This code creates a plot of the number of appointment measures and will let 
# the user choose which Health Baords to display.
# The table below the graph will have the percentage figure as well for reference

output$EF5_measurePlot <- renderPlotly({
  
  plot_ly(data = EF5_measurePlot_data(),
          
          x = ~year_months, y = ~DNA_appointments, 
          name = str_wrap("Number of 'Did Not Attend' appointments", 26),
          ## Tooltip text
          text = paste0("Location: ",
                        EF5_measurePlot_data()$hb_name,
                        "<br>",
                        "Calendar Quarter: ",
                        EF5_measurePlot_data()$year_months,
                        "<br>",
                        "Number of 'Did Not Attend' appointments", ": ", EF5_measurePlot_data()$DNA_appointments), 
          hoverinfo = "text",
          
          ## Bar aesthetics
          type = 'bar', 
          marker = list(color = "#3393DD",
                        size = 12),
          textposition = "none", # remove small text on each bar
          height = 600) %>% # Size of graph
    
    # Add the Total appointments trace
    add_trace(y = ~total_appointments, name = "Total number of appointments", 
              marker = list(color = "#B3D7F2"),
              text = paste0("Location: ",
                            EF5_measurePlot_data()$hb_name,
                            "<br>",
                            "Calendar Quarter: ",
                            EF5_measurePlot_data()$year_months,
                            "<br>",
                            "Total number of appointments", ": ", EF5_measurePlot_data()$total_appointments)) %>% 
    
    layout(
      barmode = 'group', # Set the type of bar chart
      font = list(size = 13), # Set the font sizes.
      yaxis = list(
        # Wrap the y axis title in spaces so it doesn't cover the tick labels.
        title = paste0(c(rep("&nbsp;", 20),
                         "Number of Appointments", 
                         rep("&nbsp;", 20),
                         rep("\n&nbsp;", 3)),
                       collapse = ""),
        exponentformat = "none",
        
        showline = TRUE, 
        ticks = "outside"
      ),
      
      # Create diagonal x-axis ticks
      xaxis = list(tickangle = -45, 
                   title = paste0(c(rep("&nbsp;", 20),
                                    "<br>",
                                    "<br>",
                                    "Calendar Quarter", 
                                    # S2_plot2_quarter_output, # Still to figure out how to get the calendar quarter to feed in
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


### Table below EF5 HB measure graph ----

# ## Table Data Reactive ----
# # to create graph data based on HB selection
# EF5_measurePlot_tableData <- reactive({
#   EF5_data %>%
#     filter(hb_name %in% input$EF5_measurePlot_hbName)
# })

# Table data output
output$EF5_measurePlot_table <- renderDataTable({
  datatable(EF5_measurePlot_data(),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
            colnames = c("Health Board",
                         "Calendar Quarter",
                         "'Did Not Attend' Appointments",
                         "Total Appointments",
                         "Percentage 'Did Not Attend' Appointments")
            )
})

# Create download button that allows users to download tables in .csv format.
output$EF5_measurePlot_table_download <- downloadHandler(
  filename = 'EF5 - Did not attend - health board measures.csv',
  content = function(file) {
    write.table(EF5_measurePlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Health Board",
                              "Calendar Quarter",
                              "'Did Not Attend' Appointments",
                              "Total Appointments",
                              "Percentage 'Did Not Attend' Appointments"),
                sep = ",")
  })