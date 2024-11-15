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
                  text = paste0("Financial year: ",         # for tooltip in ggplotly - shows values on hover
                                EF4_trendPlot_data()$fyear,
                                "<br>",
                                "Health Board: ",
                                EF4_trendPlot_data()$hb_name,
                                "<br>",
                                EF4_trendPlot_data()$measure,": ",
                                EF4_trendPlot_data()$value))) +
          geom_line() +
          geom_point(size = 2.5) +
          aes(group = measure,            # Have to do this outside so that the legends shows and so that there aren't 3 legends
              linetype = measure,
              color = measure,
              shape = measure) +
          scale_color_discrete_phs(name = "Measure Name",
                                   palette = "main-blues",
                                   labels = ~ stringr::str_wrap(.x, width = 15)) + # this isn't working - trying to wrap the legend text
          # scale_color_manual(name = "Measure Name",
          #                    values = c("#0078D4", "#3393DD"),               # colour for lines
          #                   labels = ~ stringr::str_wrap(.x, width = 15)) +  
          scale_linetype_manual(name = "Measure Name",               # have to add it into each one or the legend duplicates
                                values = c("solid", "dashed"),
                                labels = ~ stringr::str_wrap(.x, width = 15)) +
          scale_shape_manual(name = "Measure Name",
                             values = c("circle", "triangle-up"),         # shape for points
                             labels = ~ stringr::str_wrap(.x, width = 15)) +   # this isn't working - trying to wrap the legend text
          theme_classic()+
          theme(panel.grid.major.x = element_line(),         # Shows vertical grid lines
                panel.grid.major.y = element_line(),         # Shows horizontal grid lines
                axis.title.x = element_text(size = 12,
                                            color = "black",
                                            face = "bold"),
                axis.text.x = element_text(angle = 25),
                axis.title.y = element_text(size = 12,
                                            color = "black",
                                            face = "bold"),
                legend.text = element_text(size = 8,
                                           colour = "black"),
                legend.title = element_text(size = 9,
                                            colour = "black",
                                            face = "bold")) +
        #  guides(fill = guide_legend(label.theme = element_text(size = 10, lineheight = 0.8))) + # Trying to wrap the legend text
          labs(x = "Financial Year",
               y = "Percentage (%)") +
          scale_y_continuous(expand = c(0, 0),           # y axis will always start from zero
                             limits = c(0, (max(EF4_trendPlot_data()$value)
                                            + 0.5*max(EF4_trendPlot_data()$value)))) # maximum y axis value should always show

    })


 ### Run ggplot graph through plotly ----

    ggplotly(EF4_plot_graph(),
             tooltip = "text") %>%        # uses text set up in ggplot aes above. 
    ### Remove unnecessary buttons from the modebar ----
    config(displayModeBar = TRUE,
           modeBarButtonsToRemove = bttn_remove,
           displaylogo = F, editable = F)

 })



 ### Table below graph ----
 
  output$EF4_table <- renderDataTable({
    datatable(EF4_trendPlot_data(),
              style = 'bootstrap',
              class = 'table-bordered table-condensed',
              rownames = FALSE,
              options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
              colnames = c("Financial year",
                           "Health Board",
                           "Measure Name",
                           "Value"))
  })
 
  # Create download button that allows users to download tables in .csv format.
  output$EF4_table_download <- downloadHandler(
    filename = 'EF4 - Mental health spend.csv',
    content = function(file) {
      write.table(EF4_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Financial year",
                                "Health Board",
                                "Measure Name",
                                "Value"),
                  sep = ",")
    }
  )
  
  

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




