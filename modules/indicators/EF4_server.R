### EF4 Trends Plot ----

## Health Board selector ----
output$EF4_trendPlot_hbName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF4_trendPlot_hbName",
    label = "Select NHS Health Board:",
    choices = EF4_hb_names,
    selected = "NHS Scotland")
})

## Measure selector ----
output$EF4_trendPlot_measure_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF4_trendPlot_measure",
    label = "Select measure(s):",
    choices = EF4_trend_measures,
    selected = "Mental Health Expenditure (%)",
    multiple = TRUE)
})

## Graph Data Reactive ---- 
# to create graph data based on HB and Measure selection
EF4_trendPlot_data <- reactive({
  EF4_data %>%
    filter(hb_name %in% input$EF4_trendPlot_hbName &
           measure %in% input$EF4_trendPlot_measure)
})



# Create the EF4 line chart ----

 ### Render plotly ----

 output$EF4_trendPlot <- renderPlotly({
    
  ### Create reactive ggplot graph ----
    
    EF4_plot_graph <- reactive ({
       
       ggplot(data = EF4_trendPlot_data(),
              aes(x = fyear, 
                  y = value, 
                  group = measure, 
                  color = measure, 
                  linetype = measure, 
                  shape = measure, 
                  text = paste0("Financial year: ",         # for tooltip in ggplotly - shows values on hover
                                EF4_trendPlot_data()$fyear,
                                "<br>",
                                "Health Board: ",
                                EF4_trendPlot_data()$hb_name,
                                "<br>",
                                EF4_trendPlot_data()$measure,": ",
                                EF4_trendPlot_data()$value))
              ) +
          geom_line() +
          guides(linetype = "none", 
                 shape = "none", 
                 color = guide_legend(title = "Measure Name", 
                                      nrow = 2)) +
          scale_color_manual(values = c("#0078D4", "#3393DD"),               # colour for lines
                             labels = ~ stringr::str_wrap(.x, width = 15)) +
          scale_linetype_manual(values = c("solid", "dashed")) +
          geom_point(size = 2.5) + 
          scale_shape_manual(values = c("circle", "triangle-up")) +      # shape for points
          theme_classic()+ 
          theme(panel.grid.major.x = element_line(),           # Shows vertical grid lines 
                panel.grid.major.y = element_line(),         # Shows horizontal grid lines 
                axis.title.x = element_text(size = 12,
                                            color = "black",
                                            face = "bold"),
                axis.title.y = element_text(size = 12,
                                            color = "black",
                                            face = "bold")) +
          labs(x = "Financial Year", 
               y = "Percentage (%)") +
          scale_y_continuous(expand = c(0, 0),           # y axis will always start from zero 
                             limits = c(0, (max(EF4_trendPlot_data()$value) 
                                            + 0.5*max(EF4_trendPlot_data()$value)))) # maximum y axis value should always show 
          
    })
    
    
 ### Run ggplot graph through plotly ----
    
    ggplotly(EF4_plot_graph(), 
             tooltip = "text")         # uses text set up in ggplot aes above. 
    
 })



 ### Table below graph ----
 
 # output$EF4_1_trend_table <- renderDataTable({
 #   datatable(EF4_trendPlot_data(),
 #             style = 'bootstrap',
 #             class = 'table-bordered table-condensed',
 #             rownames = FALSE,
 #             options = list(pageLength = 16, autoWidth = TRUE, dom = 'tip'),
 #             colnames = c("Financial year",
 #                          "Area of Residence",
 #                          "Number of Bed Days"))
 # })
 
 

# X OLD CODE ----
# 
# ## plotly bar chart ----
# output$EF4_trendPlot <- renderPlotly({
#   #
#   #   # # No data plot
#   #   # if(sum(EF4_trendPlot_data()$value) == 0 &
#   #   #    !is.na(sum(EF4_trendPlot_data()$value)))
#   #   #
#   #   # {
#   #   #   noDataPlot(phs_colours("phs-purple"))
#   #   # }
#   #   #
#   #   # else {
#   #
#   ### Tooltip creation ----
#   tooltip_EF4 <- paste0("Financial year: ",
#                        EF4_trendPlot_data()$fyear,
#                        "<br>",
#                        "Health Board: ",
#                        EF4_trendPlot_data()$hb_name,
#                        "<br>",
#                        EF4_trendPlot_data()$measure,": ",
#                        EF4_trendPlot_data()$value)
# 
#   ## Create the main body of the chart ----
# 
#   # phs_scatterPlot(EF4_trendPlot_data, fyear, value, tooltip_EF4, measure)
#   
#   plot_ly(data = EF4_trendPlot_data(),
#           # Select your variables.
#           x = ~fyear, y = ~value, color = ~measure,
#           text = tooltip_EF4, hoverinfo = "text",
#           colors = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"), # line colours
#           type = 'scatter', mode = 'lines+markers',
#           # width = 600, height = 300,
#           line = list(width = 2),
#           linetype = ~measure,
#           linetypes = c("solid", "dash"),
#           marker = list(size = 8),
#           name = ~str_wrap(measure, 19)) %>% # legend labels
#     
#     # data = EF4_trendPlot_data(),
#     #       # Select your variables.
#     #       x = ~fyear, y = ~value,
#     #       text = tooltip_EF4, hoverinfo = "text",
#     #       color = ~measure,
#     #       colors = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"), # line colours
#     #       type = 'scatter', mode = 'lines+markers',
#     #       # width = 600, height = 300,
#     #       line = list(width = 2),
#     #       linetype = ~measure,
#     #       linetypes = c("solid", "dash"),
#     #       marker = list(size = 8),
#     #       name = ~str_wrap(measure, 19)) %>% # legend labels
# 
#   ### 7 - Graph title ----
#   layout(title =
#            paste0(
#              "<b>",
#              "Percent (%) of total NHS spend in ",
#              input$EF4_trendPlot_hbName_output, ",",
#              "<br>",
#              first(as.vector(EF4_trendPlot_data()$fyear)),
#              " to ",
#              last(as.vector(EF4_trendPlot_data()$fyear)),
#              "<br>",
#              "</b>"
#            ),
# 
#          separators = ".",
# 
#          yaxis = list(
#            exponentformat = "none",
#            separatethousands = TRUE,
#            range = c(0, max(EF4_trendPlot_data()$value, na.rm = TRUE)
#                      + (max(EF4_trendPlot_data()$value, na.rm = TRUE)*0.1)
#            ),
#            # Define Y axis title
#            title = paste0(c(rep("&nbsp;", 20),
#                             "Percent",
#                             rep("&nbsp;", 20),
#                             rep("\n&nbsp;", 3))),
#            showline = TRUE,
#            ticks = "outside"
#          ),
# 
#          xaxis = list(
#            title = paste0(c("<br>", "Financial year")),
#            showline = TRUE,
#            ticks = "outside"
#          ),
# 
#          margin = list(l = 90, r = 60, b = 180, t = 120),
#          title = list(size = 15),
#          font = list(size = 13),
#          # Legend
#          showlegend = TRUE,
#          legend = list(x = 1,
#                        y = 1,
#                        bgcolor = 'rgba(255, 255, 255, 0)',
#                        bordercolor = 'rgba(255, 255, 255, 0)')
#          # legend = list(orientation = "h",   # show entries horizontally
#          #               xanchor = "center",  # use center of legend as anchor
#          #               x = 0.5, y = -0.9)             # put legend in center of x-axis
#   ) %>%
# 
#     ### Remove unnecessary buttons from the modebar ----
# 
#   config(displayModeBar = TRUE,
#          modeBarButtonsToRemove = bttn_remove,
#          displaylogo = F, editable = F)
# 
#   # }
# 
# })
# 
# 
# ### Table below graph ----
# 
# # output$EF4_1_trend_table <- renderDataTable({
# #   datatable(EF4_trendPlot_data(),
# #             style = 'bootstrap',
# #             class = 'table-bordered table-condensed',
# #             rownames = FALSE,
# #             options = list(pageLength = 16, autoWidth = TRUE, dom = 'tip'),
# #             colnames = c("Financial year",
# #                          "Area of Residence",
# #                          "Number of Bed Days"))
# # })
# 
# 
# 




