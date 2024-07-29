# PLOT 1 (MS added title) ----

output$EQ1_plot1_areaType_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot1_areaType",
    label = "Select type of geography:",
    choices = unique_area_types,
    selected = "Health board")
})

output$EQ1_plot1_areaName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot1_areaName",
    label = "Select area(s) (Maximum 5):",
    choices = sort(unique(as.character(
      EQ1_data$area_name
      [EQ1_data$area_type %in% input$EQ1_plot1_areaType]
    )))
    ,
    multiple = TRUE,
    options = list("max-options" = 5,
                   `selected-text-format` = "count > 1")
  )
})

EQ1_plot1_Data <- reactive({
  EQ1_data %>%
    select(Year, area_type, area_name, RiskRatio, SMR04_Pop_Rate, General_Pop_Rate) %>%
    filter(area_type %in% input$EQ1_plot1_areaType
           & area_name %in% input$EQ1_plot1_areaName)
})

# Create the discharges line chart.

output$EQ1_plot1 <- renderPlotly({
# 
#   # # No data plot
#   # if(sum(E1_plot1_Data()$dd_bed_days) == 0 &
#   #    !is.na(sum(E1_plot1_Data()$dd_bed_days)))
#   # 
#   # {
#   #   noDataPlot(phs_colours("phs-purple"))
#   # }
#   # 
#   # else {
# 
    ### 3 - Tooltip creation ----

    tooltip_EQ1 <- paste0("Financial year: ",
                         EQ1_plot1_Data()$Year,
                         "<br>",
                         "Area of residence: ",
                         EQ1_plot1_Data()$area_name,
                         "<br>",
                         "Mortality rate: ",
                         EQ1_plot1_Data()$RiskRatio)

    ### 4 - Create the main body of the chart ----

    plot_ly(data = EQ1_plot1_Data(),
            # Select your variables.
            x = ~Year, y = ~RiskRatio, color = ~area_name,
            colors = c("#0080FF"), # line colour - Dark blue for all lines
            text = tooltip_EQ1, hoverinfo = "text",
            type = 'scatter', mode = 'lines+markers',
            # width = 600, height = 300,
            line = list(width = 3),
            marker = list(size = 12),
            name = ~str_wrap(area_name, 19)) %>% # legend labels

      ### 7 - Graph title ----

    # Make the graph title reactive.

    layout(title =
             paste0(
               "<b>",
               "Mortality rate for persons in contact with MH services",
               "<br>",
               " by ", input$EQ1_plot1_areaType, ", ", first(as.vector(EQ1_plot1_Data()$Year)),
               " to ",
               last(as.vector(EQ1_plot1_Data()$Year)),
               "<br>",
               "</b>"
             ),

           separators = ".",

           yaxis = list(
             exponentformat = "none",
             separatethousands = TRUE,
             range = c(0, max(EQ1_plot1_Data()$RiskRatio, na.rm = TRUE)
                       + (max(EQ1_plot1_Data()$RiskRatio, na.rm = TRUE)*0.1)
                       ),
             title = paste0(c(rep("&nbsp;", 20),
                              input$EQ1_1_input_1,
                              rep("&nbsp;", 20),
                              rep("\n&nbsp;", 3))),
             showline = TRUE,
             ticks = "outside"
           ),

           xaxis = list(
             title = paste0(c("<br>",
                              "Calendar year",
                            collapse = "")), # Don't think it's needed
             showline = TRUE,
             ticks = "outside"
           ),

           margin = list(l = 90, r = 60, b = 180, t = 120),
           title = list(size = 15),
           font = list(size = 13),
           # Legend
           showlegend = TRUE,
           legend = list(x = 1,
                         y = 1,
                         bgcolor = 'rgba(255, 255, 255, 0)',
                         bordercolor = 'rgba(255, 255, 255, 0)')
           # legend = list(orientation = "h",   # show entries horizontally
           #               xanchor = "center",  # use center of legend as anchor
           #               x = 0.5, y = -0.9)             # put legend in center of x-axis
           ) %>%

      ### 13 - Remove unnecessary buttons from the modebar ----

    config(displayModeBar = TRUE,
           modeBarButtonsToRemove = bttn_remove,
           displaylogo = F, editable = F)

  # }

})


### 15 - Table below graph creation ----

# output$E1_1_trend_table <- renderDataTable({
#   datatable(E1_plot1_Data(),
#             style = 'bootstrap',
#             class = 'table-bordered table-condensed',
#             rownames = FALSE,
#             options = list(pageLength = 16, autoWidth = TRUE, dom = 'tip'),
#             colnames = c("Financial year",
#                          "Area of Residence",
#                          "Number of Bed Days"))
# })









      
