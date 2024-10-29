# PLOT 1 ----

## Picker for selecting HB or CA ----

output$EQ1_plot1_areaType_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot1_areaType",
    label = "Select type of geography:",
    choices = unique_area_types,
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
    selected = "NHS Ayrshire and Arran"
  )
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

### Render Plotly ----

output$EQ1_plot1 <- renderPlotly({
  ### Create reactive ggplot graph ----
  
  EQ1_plot1_graph <- reactive({
    ggplot(data = EQ1_plot1_Data(),
           aes(
             x = Year,
             y = risk_ratio,
             text = paste0(
               "Financial year: ",
               # for tooltip in ggplotly - shows values on hover
               EQ1_plot1_Data()$Year,
               "<br>",
               "Area of residence: ",
               EQ1_plot1_Data()$area_name,
               "<br>",
               "Mortality rate: ",
               EQ1_plot1_Data()$risk_ratio
             )
           )) +
      geom_line() +
      geom_point(size = 2.5) +
      aes(
        group = area_name,
        linetype = area_name,
        # Have to do this outside so that the legends shows and so that there aren't 3 legends
        color = area_name,
        shape = area_name
      ) +
      scale_color_discrete_phs(
        name = "Area name",
        palette = "main-blues",
        labels = ~ stringr::str_wrap(.x, width = 15)
      ) +
      # scale_color_manual(name = "Area name:",
      #                    values = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"),    # MS 27/09 - keeping this in for now - until spoken about phsstyles
      #                    labels = ~ stringr::str_wrap(.x, width = 15)) +
      scale_linetype_manual(
        name = "Area name",
        values = c("solid", "dashed", "solid", "dashed"),
        labels = ~ stringr::str_wrap(.x, width = 15)
      ) +
      scale_shape_manual(
        name = "Area name",
        values = c("circle", "circle", "triangle-up", "triangle-up"),
        labels = ~ stringr::str_wrap(.x, width = 15)
      ) +
      theme_classic() +                         # de-clutters graph background
      theme(
        panel.grid.major.x = element_line(),
        # Shows vertical grid lines
        panel.grid.major.y = element_line(),
        # Shows horizontal grid lines
        axis.title.x = element_text(
          size = 12,
          color = "black",
          face = "bold"
        ),
        axis.title.y = element_text(
          size = 12,
          color = "black",
          face = "bold"
        ),
        legend.text = element_text(size = 8,
                                   colour = "black"),
        legend.title = element_text(
          size = 9,
          colour = "black",
          face = "bold"
        )
      ) +
      labs(x = "Year",
           y = "Mortality Rate") +
      scale_y_continuous(expand = c(0, 0),   # Ensures y axis starts from zero
                         limits = c(0, (
                           max(EQ1_plot1_Data()$risk_ratio) + 0.5 * max(EQ1_plot1_Data()$risk_ratio)
                         )))
  })
  
  
  ### Run graph 1 through plotly ----
  
  ggplotly(EQ1_plot1_graph(),
           tooltip = "text")#,    # uses text set up in ggplot aes above.
  # ### Remove unnecessary buttons from the modebar ---- not working just now
  # config(displayModeBar = TRUE,                   # Remove unnecessary buttons from the modebar
  #        modeBarButtonsToRemove = bttn_remove,
  #        displaylogo = F, editable = F))
  
})



# EQ1 PLOT 2 ----

## Picker for user selecting HB or CA ----

output$EQ1_plot4_areaType_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot4_areaType",
    label = "Select type of geography:",
    choices = unique_area_types,
    selected = "Health board"
  )
})

## Picker for user selecting specific geographies ----
output$EQ1_plot4_areaName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot4_areaName",
    label = "Select area:",
    choices = sort(unique(
      as.character(EQ1_reformatted_data$area_name
                   [EQ1_reformatted_data$area_type %in% input$EQ1_plot4_areaType])
    )),
    multiple = TRUE,
    options = list(
      "max-options" = 1,
      `selected-text-format` = "count > 1"
    ),
    selected = "NHS Ayrshire and Arran"
  )
})


## Selecting appropriate data for graph 2 ----

EQ1_plot4_Data <- reactive({
  EQ1_reformatted_data %>%
    select(Rate_Type, Year, area_type, area_name, Rate) %>%
    filter(area_type %in% input$EQ1_plot4_areaType
           & area_name %in% input$EQ1_plot4_areaName)
})


# Create the combined general population and MH rates bar chart ----

### Render plotly ----

output$EQ1_plot4 <- renderPlotly({
  ### Create reactive ggplot bar graph ----
  
  EQ1_plot4_graph <- reactive({
    ggplot(data = EQ1_plot4_Data(),
           aes(
             x = Year,
             y = Rate,
             fill = Rate_Type,
             # colours defined below
             text = paste0(
               "Financial year: ",
               EQ1_plot4_Data()$Year,
               "<br>",
               "Area of residence: ",
               EQ1_plot4_Data()$area_name,
               "<br>",
               "Rate Type: ",
               EQ1_plot4_Data()$Rate_Type,
               "<br>",
               "Rate: ",
               EQ1_plot4_Data()$Rate
             )
           )) +
      geom_bar(stat = "identity", position = "dodge") +     # creates bar graph with bars separated from each other
      #scale_fill_manual(values = c("#0078D4", "#B3D7F2")) +     # MS 27/09 - keep until phsstyles have been spoken about
      scale_fill_manual(values = phs_colours(c("phs-blue", "phs-blue-50"))) +
      theme_classic() +
      theme(
        #legend.position = "bottom",     # WHY ISN'T THIS WORKING?
        panel.grid.major.x = element_line(),
        # Shows vertical grid lines
        panel.grid.major.y = element_line(),
        # Shows horizontal grid lines
        axis.title.x = element_text(
          size = 12,
          color = "black",
          face = "bold"
        ),
        axis.title.y = element_text(
          size = 12,
          color = "black",
          face = "bold"
        )
      ) +
      labs(x = "Year",
           y = "Mortality Rate",
           fill = "Population Group:") +
      scale_y_continuous(expand = c(0, 0),      # Ensures y axis starts from zero
                         limits = c(0, (
                           max(EQ1_plot4_Data()$Rate) + 0.5 * max(EQ1_plot4_Data()$Rate)
                         )))
    
  })
  
  
  ### Run graph 2 through plotly ----
  
  ggplotly(EQ1_plot4_graph(),
           tooltip = "text")#,    # uses text set up in ggplot aes above.
  #  ### Remove unnecessary buttons from the modebar ---- not working but will make work
  # config(displayModeBar = TRUE,
  #         modeBarButtonsToRemove = bttn_remove,
  #         displaylogo = F, editable = F))
  
})


### Tables below graphs ----
# Year, area_type, area_name, risk_ratio, SMR04_Pop_Rate, General_Pop_Rate
output$EQ1_1_table <- renderDataTable({
  datatable(
    EQ1_plot1_Data(),
    style = 'bootstrap',
    class = 'table-bordered table-condensed',
    rownames = FALSE,
    options = list(
      pageLength = 16,
      autoWidth = FALSE,
      dom = 'tip'
    ),
    colnames = c(
      "Financial year",
      "Area Type",
      "Area Name",
      "Risk ratio",
      "SMR04 population rate",
      "General population rate"
    )
  )
})
#Rate_Type, Year, area_type, area_name, Rate
output$EQ1_2_table <- renderDataTable({
  datatable(
    EQ1_plot4_Data(),
    style = 'bootstrap',
    class = 'table-bordered table-condensed',
    rownames = FALSE,
    options = list(
      pageLength = 16,
      autoWidth = FALSE,
      dom = 'tip'
    ),
    colnames = c("Rate type",
                 "Financial year",
                 "Area Type",
                 "Area Name",
                 "Rate")
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
        "Financial year",
        "Area Type",
        "Area Name",
        "Risk ratio",
        "SMR04 population rate",
        "General population rate"
      ),
      sep = ","
    )
  }
)

output$EQ1_2_table_download <- downloadHandler(
  filename = paste0("EQ1 - Mortality rate trend for chosen area.csv"),
  content = function(file) {
    write.table(
      EQ1_plot4_Data(),
      file,
      #Remove row numbers as the .csv file already has row numbers.
      row.names = FALSE,
      col.names = c("Rate type",
                    "Financial year",
                    "Area Type",
                    "Area Name",
                    "Rate"),
      sep = ","
    )
  }
)


# Table below graph creation ----

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






# OLD CODE (keeping in case needed for reference)  ----
#
# #
# #
# # #
# # #   # # No data plot
# # #   # if(sum(E1_plot1_Data()$dd_bed_days) == 0 &
# # #   #    !is.na(sum(E1_plot1_Data()$dd_bed_days)))
# # #   #
# # #   # {
# # #   #   noDataPlot(phs_colours("phs-purple"))
# # #   # }
# # #   #
# # #   # else {
# # #
# #     ### 3 - Tooltip creation ----
# #
# #     tooltip_EQ1 <- paste0("Financial year: ",
# #                          EQ1_plot1_Data()$Year,
# #                          "<br>",
# #                          "Area of residence: ",
# #                          EQ1_plot1_Data()$area_name,
# #                          "<br>",
# #                          "Mortality rate: ",
# #                          EQ1_plot1_Data()$risk_ratio)
# #
# #     ### 4 - Create the main body of the chart ----
# #
# #     plot_ly(data = EQ1_plot1_Data(),
# #             # Select your variables.
# #             x = ~as.factor(Year), y = ~risk_ratio, color = ~area_name,
# #             colors = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"),
# #             text = tooltip_EQ1, hoverinfo = "text",
# #             type = 'scatter', mode = 'lines+markers',
# #             # width = 600, height = 300,
# #             line = list(width = 3),
# #             linetype = ~area_name,
# #             linetypes = c("solid", "dot"),
# #             # Select symbols for the health boards, and set their size.
# #             symbol = ~area_name,
# #             symbols = c("circle", "triangle-up", "circle", "triangle-up"),
# #             marker = list(size = 12),
# #             name = ~str_wrap(area_name, 19)) %>% # legend labels
# #
# #       ### 7 - Graph title ----
# #
# #     # Make the graph title reactive.
# #
# #     layout(title =
# #              paste0(
# #                "<b>",
# #                "Mortality rate for persons in contact with MH services",
# #                "<br>",
# #                " by ", input$EQ1_plot1_areaType, ", ", first(as.vector(EQ1_plot1_Data()$Year)),
# #                " to ",
# #                last(as.vector(EQ1_plot1_Data()$Year)),
# #                "<br>",
# #                "</b>"
# #              ),
# #
# #            separators = ".",
# #
# #            yaxis = list(
# #              exponentformat = "none",
# #              separatethousands = TRUE,
# #              range = c(0, max(EQ1_plot1_Data()$risk_ratio, na.rm = TRUE)
# #                        + (max(EQ1_plot1_Data()$risk_ratio, na.rm = TRUE)*0.1)
# #                        ),
# #              title = paste0(c(rep("&nbsp;", 20),
# #                               input$EQ1_1_input_1,
# #                               rep("&nbsp;", 20),
# #                               rep("\n&nbsp;", 3))),
# #              showline = TRUE,
# #              ticks = "outside"
# #            ),
# #
# #            xaxis = list(
# #              title = paste0(c("<br>",
# #                               "Calendar year",
# #                             collapse = "")), # Don't think it's needed
# #              showline = TRUE,
# #              ticks = "outside"
# #            ),
# #
# #            margin = list(l = 90, r = 60, b = 180, t = 120),
# #            title = list(size = 15),
# #            font = list(size = 13),
# #            # Legend
# #            showlegend = TRUE,
# #            legend = list(x = 1,
# #                          y = 1,
# #                          bgcolor = 'rgba(255, 255, 255, 0)',
# #                          bordercolor = 'rgba(255, 255, 255, 0)')
# #            # legend = list(orientation = "h",   # show entries horizontally
# #            #               xanchor = "center",  # use center of legend as anchor
# #            #               x = 0.5, y = -0.9)             # put legend in center of x-axis
# #            ) %>%
# #
# #       ### 13 - Remove unnecessary buttons from the modebar ----
# #
# #     config(displayModeBar = TRUE,
# #            modeBarButtonsToRemove = bttn_remove,
# #            displaylogo = F, editable = F)
# #
# #   # }
# #
# # })
#
#
# #
# #
# # ####### Create the SMR04 rates bar chart.
# #
# # output$EQ1_plot2 <- renderPlotly({
# #   #
# #   #   # # No data plot
# #   #   # if(sum(E1_plot1_Data()$dd_bed_days) == 0 &
# #   #   #    !is.na(sum(E1_plot1_Data()$dd_bed_days)))
# #   #   #
# #   #   # {
# #   #   #   noDataPlot(phs_colours("phs-purple"))
# #   #   # }
# #   #   #
# #   #   # else {
# #   #
# #   ### 3 - Tooltip creation ----
# #
# #   tooltip_EQ1_2 <- paste0("Financial year: ",
# #                         EQ1_plot1_Data()$Year,
# #                         "<br>",
# #                         "Area of residence: ",
# #                         EQ1_plot1_Data()$area_name,
# #                         "<br>",
# #                         "Mortality rate: ",
# #                         EQ1_plot1_Data()$SMR04_Pop_Rate)
# #
# #   ### 4 - Create the main body of the chart ----
# #
# #   plot_ly(data = EQ1_plot1_Data(),
# #           # Select your variables.
# #           x = ~Year, y = ~SMR04_Pop_Rate, type = 'bar', color = ~area_name,
# #           #add_trace(p = data, y = ~General_Pop_Rate),
# #           colors = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"),
# #           text = tooltip_EQ1_2, hoverinfo = "text",
# #           marker = list(size = 12),
# #           name = ~str_wrap(area_name, 19)) %>% # legend labels
# #
# #     ### 7 - Graph title ----
# #
# #   # Make the graph title reactive.
# #
# #   layout(title =
# #            paste0(
# #              "<b>",
# #              "Mortality rate for persons in contact with MH services",
# #              "<br>",
# #              " by ", input$EQ1_plot1_areaType, ", ", first(as.vector(EQ1_plot1_Data()$Year)),
# #              " to ",
# #              last(as.vector(EQ1_plot1_Data()$Year)),
# #              "<br>",
# #              "</b>"
# #            ),
# #
# #          separators = ".",
# #
# #          yaxis = list(
# #            exponentformat = "none",
# #            separatethousands = TRUE,
# #            range = c(0, max(EQ1_plot1_Data()$SMR04_Pop_Rate, na.rm = TRUE)
# #                      + (max(EQ1_plot1_Data()$SMR04_Pop_Rate, na.rm = TRUE)*0.1)
# #            ),
# #            title = paste0(c(rep("&nbsp;", 20),
# #                             input$EQ1_1_input_1,
# #                             rep("&nbsp;", 20),
# #                             rep("\n&nbsp;", 3))),
# #            showline = TRUE,
# #            ticks = "outside"
# #          ),
# #
# #          xaxis = list(
# #            title = paste0(c("<br>",
# #                             "Area name",
# #                             collapse = "")), # Don't think it's needed
# #            showline = TRUE,
# #            ticks = "outside"
# #          ),
# #
# #          margin = list(l = 90, r = 60, b = 180, t = 120),
# #          title = list(size = 15),
# #          font = list(size = 13),
# #          # Legend
# #          showlegend = TRUE,
# #          legend = list(x = 1,
# #                        y = 1,
# #                        bgcolor = 'rgba(255, 255, 255, 0)',
# #                        bordercolor = 'rgba(255, 255, 255, 0)')
# #          # legend = list(orientation = "h",   # show entries horizontally
# #          #               xanchor = "center",  # use center of legend as anchor
# #          #               x = 0.5, y = -0.9)             # put legend in center of x-axis
# #   ) %>%
# #
# #     ### 13 - Remove unnecessary buttons from the modebar ----
# #
# #   config(displayModeBar = TRUE,
# #          modeBarButtonsToRemove = bttn_remove,
# #          displaylogo = F, editable = F)
# #
# #   # }
# #
# # })
# #
# #
# #
# #
# # ####### Create the general population rates bar chart.
# #
# # output$EQ1_plot3 <- renderPlotly({
# #   #
# #   #   # # No data plot
# #   #   # if(sum(E1_plot1_Data()$dd_bed_days) == 0 &
# #   #   #    !is.na(sum(E1_plot1_Data()$dd_bed_days)))
# #   #   #
# #   #   # {
# #   #   #   noDataPlot(phs_colours("phs-purple"))
# #   #   # }
# #   #   #
# #   #   # else {
# #   #
# #   ### 3 - Tooltip creation ----
# #
# #   tooltip_EQ1_3 <- paste0("Financial year: ",
# #                           EQ1_plot1_Data()$Year,
# #                           "<br>",
# #                           "Area of residence: ",
# #                           EQ1_plot1_Data()$area_name,
# #                           "<br>",
# #                           "Mortality rate: ",
# #                           EQ1_plot1_Data()$General_Pop_Rate)
# #
# #   ### 4 - Create the main body of the chart ----
# #
# #   plot_ly(data = EQ1_plot1_Data(),
# #           # Select your variables.
# #           x = ~Year, y = ~General_Pop_Rate, type = 'bar', color = ~area_name,
# #           #add_trace(p = data, y = ~General_Pop_Rate),
# #           colors = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"),
# #           text = tooltip_EQ1_3, hoverinfo = "text",
# #           marker = list(size = 12),
# #           name = ~str_wrap(area_name, 19)) %>% # legend labels
# #
# #     ### 7 - Graph title ----
# #
# #   # Make the graph title reactive.
# #
# #   layout(title =
# #            paste0(
# #              "<b>",
# #              "Mortality rate for the general population",
# #              "<br>",
# #              " by ", input$EQ1_plot1_areaType, ", ", first(as.vector(EQ1_plot1_Data()$Year)),
# #              " to ",
# #              last(as.vector(EQ1_plot1_Data()$Year)),
# #              "<br>",
# #              "</b>"
# #            ),
# #
# #          separators = ".",
# #
# #          yaxis = list(
# #            exponentformat = "none",
# #            separatethousands = TRUE,
# #            range = c(0, max(EQ1_plot1_Data()$General_Pop_Rate, na.rm = TRUE)
# #                      + (max(EQ1_plot1_Data()$General_Pop_Rate, na.rm = TRUE)*0.1)
# #            ),
# #            title = paste0(c(rep("&nbsp;", 20),
# #                             input$EQ1_1_input_1,
# #                             rep("&nbsp;", 20),
# #                             rep("\n&nbsp;", 3))),
# #            showline = TRUE,
# #            ticks = "outside"
# #          ),
# #
# #          xaxis = list(
# #            title = paste0(c("<br>",
# #                             "Area name",
# #                             collapse = "")), # Don't think it's needed
# #            showline = TRUE,
# #            ticks = "outside"
# #          ),
# #
# #          margin = list(l = 90, r = 60, b = 180, t = 120),
# #          title = list(size = 15),
# #          font = list(size = 13),
# #          # Legend
# #          showlegend = TRUE,
# #          legend = list(x = 1,
# #                        y = 1,
# #                        bgcolor = 'rgba(255, 255, 255, 0)',
# #                        bordercolor = 'rgba(255, 255, 255, 0)')
# #          # legend = list(orientation = "h",   # show entries horizontally
# #          #               xanchor = "center",  # use center of legend as anchor
# #          #               x = 0.5, y = -0.9)             # put legend in center of x-axis
# #   ) %>%
# #
# #     ### 13 - Remove unnecessary buttons from the modebar ----
# #
# #   config(displayModeBar = TRUE,
# #          modeBarButtonsToRemove = bttn_remove,
# #          displaylogo = F, editable = F)
# #
# #   # }
# #
# # })
# #
# #
#
#
#
#
# output$EQ1_plot4_areaType_output <- renderUI({
#   shinyWidgets::pickerInput(
#     "EQ1_plot4_areaType",
#     label = "Select type of geography:",
#     choices = unique_area_types,
#     selected = "Health board")
# })
#
# output$EQ1_plot4_areaName_output <- renderUI({
#   shinyWidgets::pickerInput(
#     "EQ1_plot4_areaName",
#     label = "Select area:",
#     choices = sort(unique(as.character(
#       EQ1_reformatted_data$area_name
#       [EQ1_reformatted_data$area_type %in% input$EQ1_plot4_areaType]
#     )))
#     ,
#     multiple = TRUE,
#     options = list("max-options" = 1,
#                    `selected-text-format` = "count > 1")
#   )
# })
#
#
# EQ1_plot4_Data <- reactive({
#   EQ1_reformatted_data %>%
#     select(Rate_Type, Year, area_type, area_name, Rate) %>%
#     filter(area_type %in% input$EQ1_plot4_areaType
#            & area_name %in% input$EQ1_plot4_areaName)
# })
#
#
# ####### Create the combined general population and MH rates bar chart.
# #
#  output$EQ1_plot4 <- renderPlotly({
#    #
#    #   # # No data plot
#    #   # if(sum(E1_plot1_Data()$dd_bed_days) == 0 &
#    #   #    !is.na(sum(E1_plot1_Data()$dd_bed_days)))
#    #   #
#    #   # {
#    #   #   noDataPlot(phs_colours("phs-purple"))
#    #   # }
#    #   #
#    #   # else {
#    #
#    ### 3 - Tooltip creation ----
#
#    tooltip_EQ1_4 <- paste0("Financial year: ",
#                            EQ1_plot4_Data()$Year,
#                            "<br>",
#                            "Area of residence: ",
#                            EQ1_plot4_Data()$area_name,
#                            "<br>",
#                            "Rate Type: ",
#                            EQ1_plot4_Data()$Rate_Type,
#                            "<br>",
#                            "Rate: ",
#                            EQ1_plot4_Data()$Rate)
#
#    ### 4 - Create the main body of the chart ----
#
#    plot_ly(data = EQ1_plot4_Data(),
#            # Select your variables.
#            x = ~Year, y = ~Rate, type = 'bar', color = ~Rate_Type,
#            colors = c("#0078D4", "#B3D7F2"),
#            textposition = "none",
#            text = tooltip_EQ1_4, hoverinfo = "text",
#            marker = list(size = 12),
#            name = ~str_wrap(Rate_Type, 19)) %>% # legend labels
#
#      ### 7 - Graph title ----
#
#    # Make the graph title reactive.
#
#    layout(title =
#             paste0(
#               "<b>",
#               "Mortality rates for the MH and general population",
#               "<br>",
#               " for ", input$EQ1_plot4_areaName, ", ", first(as.vector(EQ1_plot4_Data()$Year)),
#               " to ",
#               last(as.vector(EQ1_plot4_Data()$Year)),
#               "<br>",
#               "</b>"
#             ),
#
#           separators = ".",
#
#           yaxis = list(
#             exponentformat = "none",
#             separatethousands = TRUE,
#             range = c(0, max(EQ1_plot4_Data()$Rate, na.rm = TRUE)
#                       + (max(EQ1_plot4_Data()$Rate, na.rm = TRUE)*0.1)
#             ),
#             title = paste0(c(rep("&nbsp;", 20),
#                              input$EQ1_1_input_1,
#                              rep("&nbsp;", 20),
#                              rep("\n&nbsp;", 3))),
#             showline = TRUE,
#             ticks = "outside"
#           ),
#
#           xaxis = list(
#             title = paste0(c("<br>",
#                              "Area name",
#                              collapse = "")), # Don't think it's needed
#             showline = TRUE,
#             ticks = "outside"
#           ),
#
#           margin = list(l = 90, r = 60, b = 180, t = 120),
#           title = list(size = 15),
#           font = list(size = 13),
#           # Legend
#           showlegend = TRUE,
#           legend = list(x = 1,
#                         y = 1,
#                         bgcolor = 'rgba(255, 255, 255, 0)',
#                         bordercolor = 'rgba(255, 255, 255, 0)')
#           # legend = list(orientation = "h",   # show entries horizontally
#           #               xanchor = "center",  # use center of legend as anchor
#           #               x = 0.5, y = -0.9)             # put legend in center of x-axis
#    ) %>%
#
#      ### 13 - Remove unnecessary buttons from the modebar ----
#
#    config(displayModeBar = TRUE,
#           modeBarButtonsToRemove = bttn_remove,
#           displaylogo = F, editable = F)
#
#    # }
#
#  })
#
#
# ### 15 - Table below graph creation ----
#
# # output$E1_1_trend_table <- renderDataTable({
# #   datatable(E1_plot1_Data(),
# #             style = 'bootstrap',
# #             class = 'table-bordered table-condensed',
# #             rownames = FALSE,
# #             options = list(pageLength = 16, autoWidth = TRUE, dom = 'tip'),
# #             colnames = c("Financial year",
# #                          "Area of Residence",
# #                          "Number of Bed Days"))
# # })
#
