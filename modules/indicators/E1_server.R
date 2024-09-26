# PLOT 1 ----

## Picker for user selecting HB or CA ----

output$E1_plot1_areaType_output <- renderUI({
   shinyWidgets::pickerInput(
      "E1_plot1_areaType",
      label = "Select type of geography:",
      choices = E1_area_types,
      selected = "Health board")
})

## Picker for user selecting specific geographies ----

output$E1_plot1_areaName_output <- renderUI({
   shinyWidgets::pickerInput(
      "E1_plot1_areaName",
      label = "Select area(s) (Maximum 4):",
      choices = sort(unique(as.character(
         E1_data$area_name
         [E1_data$area_type %in% input$E1_plot1_areaType]
      ))),
      selected = "NHS Ayrshire & Arran",
      multiple = TRUE,
      options = list("max-options" = 4,
                      `selected-text-format` = "count > 1")
   )
})

## Selecting appropriate data for graph 1 ---- 
E1_plot1_Data <- reactive({
   E1_data %>%
      select(fyear, area_type, area_name, dd_bed_days) %>%
      filter(area_type %in% input$E1_plot1_areaType          # don't think we really need this first filter but doesn't harm anything?
             & area_name %in% input$E1_plot1_areaName)
})
 
## Add different colours for 5 chosen options ----



# Create the discharges line chart ----

   ### Render plotly ----

output$E1_plot1 <- renderPlotly({
   
   ### Create reactive ggplot graph ----
   
   E1_plot1_graph <- reactive({
      ggplot(data = E1_plot1_Data(), 
             aes(x = fyear, 
                 y = dd_bed_days,  
                 group = area_name,
                 color = area_name,
                 linetype = area_name,
                 shape = area_name,
                 text = paste0("Financial year: ",
                                E1_plot1_Data()$fyear,
                                "<br>",
                                "Area of residence: ",
                                E1_plot1_Data()$area_name,
                                "<br>",
                                "Total number of bed days: ",
                                E1_plot1_Data()$dd_bed_days) # for tooltip in ggplotly - shows values on hover
                 )
      ) +
       geom_line() +
       guides(linetype = "none", shape = "none", color = guide_legend(title = "Area name", nrow = 2)) +
       scale_color_manual(values = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"),
                          labels = ~ stringr::str_wrap(.x, width = 15)) +
       scale_linetype_manual(values = c("solid", "dashed", "solid", "dashed")) +
       geom_point(size = 2.5) +
       scale_shape_manual(values = c("circle", "circle", "triangle-up", "triangle-up")) +
       theme_classic() +                         # I normally use bw but will see what this looks like (de-clutters graph background)
       theme(panel.grid.major.x = element_line(),  # Shows vertical grid lines 
             panel.grid.major.y = element_line(),  # Shows horizontal grid lines 
             axis.title.x = element_text(size = 12,
                                         color = "black",
                                         face = "bold"),
             axis.title.y = element_text(size = 12,
                                         color = "black",
                                         face = "bold")) +           
       labs(x = "Financial Year", y = "Total Number of Days") +
       scale_y_continuous(expand = c(0, 0),   # Ensures y axis starts from zero (important for Orkney and Shetland HBs which are all zero)
                          limits = c(0, (max(E1_plot1_Data()$dd_bed_days) + 0.5*max(E1_plot1_Data()$dd_bed_days))))  #, 
     #         breaks = seq(0, (max(E1_plot1_Data()$dd_bed_days) + 0.5*max(E1_plot1_Data()$dd_bed_days)), by = 2500))   # Not good for Scotland total. Work on this? 
   })
       
       
      #  
      #  geom_line() +
      #  scale_color_manual(values = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2", "#E6F2FB"))+
      #    geom_point(color = "#0080FF", fill = "#0080FF") +
      #    theme_classic() +                         # I normally use bw but will see what this looks like (de-clutters graph background)
      #    theme(panel.grid.major.x = element_line(),  # Shows vertical grid lines 
      #          panel.grid.major.y = element_line(),  # Shows horizontal grid lines 
      #           axis.title.x = element_text(size = 12,
      #                                       color = "black",
      #                                       face = "bold"),
      #           axis.title.y = element_text(size = 12,
      #                                       color = "black",
      #                                       face = "bold")+ # ,
      #           legend.position = "none") +           # removes legend 
      #    labs(x = "Financial Year", y = "Total Number of Days") +
      #    scale_y_continuous(expand = c(0, 0),   # Ensures y axis starts from zero (important for Orkney and Shetland HBs which are all zero)
      #                    limits = c(0, (max(E1_plot1_Data()$dd_bed_days) + 0.5*max(E1_plot1_Data()$dd_bed_days))))  #, 
      #    #         breaks = seq(0, (max(E1_plot1_Data()$dd_bed_days) + 0.5*max(E1_plot1_Data()$dd_bed_days)), by = 2500))   # Not good for Scotland total. Work on this? 
      # })

      ### Run graph 1 through plotly ----
   
   ggplotly(E1_plot1_graph(), 
            tooltip = "text")#,    # uses text set up in ggplot aes above. 
            # ### Remove unnecessary buttons from the modebar ---- not working just now
            # config(displayModeBar = TRUE,                   # Remove unnecessary buttons from the modebar
            #        modeBarButtonsToRemove = bttn_remove,
            #        displaylogo = F, editable = F))  
   
})




## X ALL OF THE OLD CODE FOR PLOT 1 ---- 

# # PLOT 1 ----
# 
# output$E1_plot1_areaType_output <- renderUI({
#   shinyWidgets::pickerInput(
#     "E1_plot1_areaType",
#     label = "Select type of geography:",
#     choices = E1_area_types,
#     selected = "Health board")
# })
# 
# output$E1_plot1_areaName_output <- renderUI({
#   shinyWidgets::pickerInput(
#     "E1_plot1_areaName",
#     label = "Select area(s) (Maximum 5):",
#     choices = sort(unique(as.character(
#       E1_data$area_name
#       [E1_data$area_type %in% input$E1_plot1_areaType]
#     )))
#     # ,
#     # multiple = TRUE,
#     # options = list("max-options" = 5,
#     #                `selected-text-format` = "count > 1")
#   )
# })
# 
# E1_plot1_Data <- reactive({
#   E1_data %>%
#     select(fyear, area_type, area_name, dd_bed_days) %>%
#     filter(area_type %in% input$E1_plot1_areaType
#            & area_name %in% input$E1_plot1_areaName)
# })
# 
# # Pull out max bed days value for selected georgraph for using in y-axis range later
# # (Warning error received without this)
# E1_max_bed_days <- reactive({
#   E1_data %>%
#       select(fyear, area_type, area_name, dd_bed_days) %>%
#       group_by(area_type, area_name) %>%
#       filter(area_type %in% input$E1_plot1_areaType
#              & area_name %in% input$E1_plot1_areaName) %>%  
#       slice_max(dd_bed_days) %>% 
#       ungroup() %>% 
#       pull(dd_bed_days)
# })
# 
# # Create the discharges line chart.
# 
# output$E1_plot1 <- renderPlotly({
# # 
# #   # # No data plot
# #   # if(sum(E1_plot1_Data()$dd_bed_days) == 0 &
# #   #    !is.na(sum(E1_plot1_Data()$dd_bed_days)))
# #   # 
# #   # {
# #   #   noDataPlot(phs_colours("phs-purple"))
# #   # }
# #   # 
# #   # else {
# # 
#     ### 3 - Tooltip creation ----
# 
#     tooltip_E1 <- paste0("Financial year: ",
#                          E1_plot1_Data()$fyear,
#                          "<br>",
#                          "Area of residence: ",
#                          E1_plot1_Data()$area_name,
#                          "<br>",
#                          "Number of Bed Days: ",
#                          E1_plot1_Data()$dd_bed_days)
# 
#     ### 4 - Create the main body of the chart ----
# 
#     plot_ly(data = E1_plot1_Data(),
#             # Select your variables.
#             x = ~fyear, y = ~dd_bed_days, color = ~area_name,
#             colors = c("#0080FF"), # line colour - Dark blue for all lines
#             text = tooltip_E1, hoverinfo = "text",
#             type = 'scatter', mode = 'lines+markers',
#             # width = 600, height = 300,
#             line = list(width = 3),
#             marker = list(size = 12),
#             name = ~str_wrap(area_name, 19)) %>% # legend labels
# 
#       ### 7 - Graph title ----
# 
#     # Make the graph title reactive.
# 
#     layout(title =
#              paste0(
#                "<b>",
#                "Number of Delayed Discharge Bed Days", " by ",
#                input$E1_plot1_areaType, ",",
#                "<br>",
#                first(as.vector(E1_plot1_Data()$fyear)),
#                " to ",
#                last(as.vector(E1_plot1_Data()$fyear)),
#                "<br>",
#                "</b>"
#              ),
# 
#            separators = ".",
# 
# 
#            yaxis = list(
#               exponentformat = "none",
#               separatethousands = TRUE,
#               range = c(0, E1_max_bed_days()
#                         + (E1_max_bed_days() * 0.1)),
#               title = paste0(c(rep("&nbsp;", 20),
#                                input$E1_1_input_1,
#                                rep("&nbsp;", 20),
#                                rep("\n&nbsp;", 3))),
#               showline = TRUE,
#               ticks = "outside"
#            ),
#            
#            
#            xaxis = list(
#              title = paste0(c("<br>",
#                               "Financial year",
#                             collapse = "")), # Don't think it's needed
#              showline = TRUE,
#              ticks = "outside"
#            ),
# 
#            margin = list(l = 90, r = 60, b = 180, t = 120),
#            title = list(size = 15),
#            font = list(size = 13),
#            # Legend
#            showlegend = TRUE,
#            legend = list(x = 1,
#                          y = 1,
#                          bgcolor = 'rgba(255, 255, 255, 0)',
#                          bordercolor = 'rgba(255, 255, 255, 0)')
#            # legend = list(orientation = "h",   # show entries horizontally
#            #               xanchor = "center",  # use center of legend as anchor
#            #               x = 0.5, y = -0.9)             # put legend in center of x-axis
#            ) %>%
# 
#       ### 13 - Remove unnecessary buttons from the modebar ----
# 
#     config(displayModeBar = TRUE,
#            modeBarButtonsToRemove = bttn_remove,
#            displaylogo = F, editable = F)
# 
#   # }
# 
# })
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




# PLOT 2 ----

## Picker for user selecting Financial Year ----

output$E1_plot2_year_output <- renderUI({
   shinyWidgets::pickerInput(
      "E1_plot2_year",
      label = "Select financial year:",
      choices = E1_fyear,
      selected = "2023/24")
})

## Selecting appropriate data for graph 2 ---- 

E1_plot2_Data <- reactive({
   E1_data %>%
      select(fyear, area_type, area_name, dd_bed_days, rate_per_1000_population) %>%
      filter(area_type == "Health board") %>% 
      filter(fyear %in% input$E1_plot2_year) %>% 
      mutate(area_name = fct_reorder(area_name, rate_per_1000_population)) %>%    # for ordering by most to least bed days
      mutate(to_highlight = if_else(area_name == "NHS Scotland",                  # for highlighting NHS Scotland 
                                    "seagreen", "#0080FF"))                       # changed from "yes" and "no" so that these colours 
})                                                             # appear on the graph and don't have a legend using "marker = list(color... )"
                                                               # Note: only using "seagreen" to make sure it is working for now, can change colour later



# Create the discharges bar chart ----

   ### Render plotly ----

output$E1_plot2 <- renderPlotly({
   
  ### Create reactive ggplot graph ----

E1_plot2_graph <- reactive({
   ggplot(E1_plot2_Data(),  
                   aes(x = rate_per_1000_population, 
                       y = area_name,  
                       fill = to_highlight,  # colours defined below (highlights NHS Scotland)
                       text = paste0("Financial year: ", fyear,        # for tooltip in ggplotly - shows values on hover
                       "<br>",
                       "Area of residence: ", area_name,
                       "<br>",
                       "Bed days per 1,000 population: ", rate_per_1000_population)
                       )) +
   geom_bar(stat = "identity") +             # creates bar graph with bars separated from each other
   scale_fill_manual(values = c("#0080FF", "seagreen")) +  # highlights NHS Scotland
   theme_classic() +                         # I normally use bw but will see what this looks like (de-clutters graph background)
   theme(panel.grid.major.x = element_line(),  # Shows vertical grid lines 
         panel.grid.major.y = element_line(),  # Shows horizontal grid lines 
         axis.title.x = element_text(size = 12,
                                     color = "black",
                                     face = "bold"),
         axis.title.y = element_blank(), 
         legend.position = "none") +           # removes legend 
   labs(x = "Number of Days per 1,000 Population", y = NULL) +
   scale_x_continuous(limits = c(0, (max(E1_data$rate_per_1000_population) + 9)), # Keeps the x-axis the same length for all graphs, ranges from 0 to the max value plus 9 so that the last tick can be seen
                      breaks = seq(0, (max(E1_data$rate_per_1000_population) + 9), by = 10)) # x-axis ticks range from 0 to the max value + 9, showing increments of 10     

})
   ### Run graph 2 through plotly ----

ggplotly(E1_plot2_graph(), 
         tooltip = "text")#,    # uses text set up in ggplot aes above. 
         #  ### Remove unnecessary buttons from the modebar ---- not working but will make work 
         # config(displayModeBar = TRUE,
         #         modeBarButtonsToRemove = bttn_remove,
         #         displaylogo = F, editable = F))  

})




## x OLD PLOTLY CODE - PLOT 2 ---- 
# output$E1_plot2 <- renderPlotly({
# 
    #### Hover Text - Tooltip creation (doesn't quite work) ----
# 
#    tooltip_E1_plot2 <- paste0("Area of residence: ",
#                         E1_plot2_Data()$area_name,
#                         "<br>",
#                         "Number of Bed Days per 1000 population: ",
#                         E1_plot2_Data()$dd_bed_days)
#    
    #### Create the main body of the chart ----
#    
#    plot_ly(data = E1_plot2_Data(),
#            # Select your variables.
#            
#            x = ~rate_per_1000_population, 
#            y = ~area_name,  
#           # fill = ~to_highlight,     # highlighting Scotland but this is working with color and colors below
#            marker = list(color = ~to_highlight), # This stops the colour legend appearing on the hover. Using color= and colors= below adds the legend 
#            # color = ~to_highlight,
#            # colors = c("#0080FF", "seagreen"), # line colour - Dark blue for all lines. seagreen for test 
#            #text = tooltip_E1_plot2,          # This and hoverinfo = "text" were showing the info when hovering AND permanently on the graph 
#           # hoverinfo = "text",
#           hoverinfo = tooltip_E1_plot2,
#           type = 'bar', 
#           orientation = 'h') %>% 
#    
#       
# 
    #### Graph layout and titles -----
#    
#    layout(
#       margin = list(l=0, r=20, b=25, t=50, pad=3),  # i only see a difference in the top and the padding, but this adds space around title, axis titles, padding is around graph itself (between axis and values) ("left, right, bottom, top, padding")
#       
#       title = paste0("<b>",
#                      "Delayed Discharge Bed Days for the Financial Year: ", input$E1_plot2_year,
#                      "<br>",
#                      "</b>"),
#     #  title = list(standoff = 1),  # tried lots of ways of doing this but nothing working
#       #title = list(size = 12, y = 5, x = 0, xanchor = 'center', yanchor =  'top'),    # none of this does anything to change things (no variation of any of them)
#     
#       separators = ".",
# 
#       yaxis = list(title =""),
# 
#     # Re: xasis, I wanted the axis range to be "0:whatever the highest value is across ALL
#     # years" for every year's graph. Things I tried, that didn't work, included: 
#     #     rangemode = "tozero"
#     #     tick0 = 0
#     #     range = list(c(0, 300), round(max(E1_data$rate_per_1000_population), 10)), # ensures all graphs have the same range of 0-300 days but the graph wasn't starting at 0 (As bed days are going up each year, "round(...,10)" sets the xaxis as 10 more than whatever the new data shows as the maximum value)
#       xaxis = list(title = "Number of Days", 
#                    dtick = 10,                  # shows a marker for every 10th number of bed days  
#                #  range = c(~min(c(-1, E1_data$rate_per_1000_population)), ~max(c(1, E1_data$rate_per_1000_population))),  # I can't work out why this might be better when the below works too
#                   range = c(~min(0), ~max(c(1, E1_data$rate_per_1000_population))),
#                    autorange = FALSE),     # if it were TRUE then the range would change for each graph
#     
#     
#       font = list(size = 12),
#       
#       showlegend = FALSE) %>% 
#    
    #### Remove unnecessary buttons from the modebar ----
#    
#    config(displayModeBar = TRUE,
#           modeBarButtonsToRemove = bttn_remove,
#           displaylogo = F, editable = F)
#       
# })