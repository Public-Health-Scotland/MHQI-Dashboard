# PLOT 1 (MS added title) ----

output$E1_plot1_areaType_output <- renderUI({
  shinyWidgets::pickerInput(
    "E1_plot1_areaType",
    label = "Select type of geography:",
    choices = unique_area_types,
    selected = "Health board")
})

output$E1_plot1_areaName_output <- renderUI({
  shinyWidgets::pickerInput(
    "E1_plot1_areaName",
    label = "Select area(s) (Maximum 5):",
    choices = sort(unique(as.character(
      E1_data$area_name
      [E1_data$area_type %in% input$E1_plot1_areaType]
    )))
    # ,
    # multiple = TRUE,
    # options = list("max-options" = 5,
    #                `selected-text-format` = "count > 1")
  )
})

E1_plot1_Data <- reactive({
  E1_data %>%
    select(fyear, area_type, area_name, dd_bed_days) %>%
    filter(area_type %in% input$E1_plot1_areaType
           & area_name %in% input$E1_plot1_areaName)
})

# Create the discharges line chart.

output$E1_plot1 <- renderPlotly({
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

    tooltip_E1 <- paste0("Financial year: ",
                         E1_plot1_Data()$fyear,
                         "<br>",
                         "Area of residence: ",
                         E1_plot1_Data()$area_name,
                         "<br>",
                         "Number of Bed Days: ",
                         E1_plot1_Data()$dd_bed_days)

    ### 4 - Create the main body of the chart ----

    plot_ly(data = E1_plot1_Data(),
            # Select your variables.
            x = ~fyear, y = ~dd_bed_days, color = ~area_name,
            colors = c("#0080FF"), # line colour - Dark blue for all lines
            text = tooltip_E1, hoverinfo = "text",
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
               "Number of Delayed Discharge Bed Days", " by ",
               input$E1_plot1_areaType, ",",
               "<br>",
               first(as.vector(E1_plot1_Data()$fyear)),
               " to ",
               last(as.vector(E1_plot1_Data()$fyear)),
               "<br>",
               "</b>"
             ),

           separators = ".",

           yaxis = list(
             exponentformat = "none",
             separatethousands = TRUE,
             range = c(0, max(E1_plot1_Data()$dd_bed_days, na.rm = TRUE)
                       + (max(E1_plot1_Data()$dd_bed_days, na.rm = TRUE)*0.1)
                       ),
             title = paste0(c(rep("&nbsp;", 20),
                              input$E1_1_input_1,
                              rep("&nbsp;", 20),
                              rep("\n&nbsp;", 3))),
             showline = TRUE,
             ticks = "outside"
           ),

           xaxis = list(
             title = paste0(c("<br>",
                              "Financial year",
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








# PLOT 2 (MS added all) ----

## Picker for user selecting Financial Year ----

output$E1_plot2_year_output <- renderUI({
   shinyWidgets::pickerInput(
      "E1_plot2_year",
      label = "Select financial year:",
      choices = unique_fyear,
      selected = "2022/23")
})

## Selecting appropriate data for graph ---- 

E1_plot2_Data <- reactive({
   E1_data %>%
      select(fyear, area_type, area_name, dd_bed_days, rate_per_1000_population) %>%
      filter(area_type == "Health board") %>% 
      filter(fyear == input$E1_plot2_year) %>% 
      mutate(area_name = fct_reorder(area_name, rate_per_1000_population)) %>%    # for ordering by most to least bed days
      mutate(to_highlight = if_else(area_name == "NHS Scotland",                  # for highlighting NHS Scotland 
                                    "seagreen", "#0080FF"))                       # changed from "yes" and "no" so that these colours appear on the graph and don't have a legend using "marker = list(color... )"
})                                    # only using "seagreen" to make sure it is working for now 



## Create the discharges bar chart. ----

output$E1_plot2 <- renderPlotly({

   ### Hover Text - Tooltip creation (doesn't quite work) ----

   tooltip_E1_plot2 <- paste0("Area of residence: ",
                        E1_plot2_Data()$area_name,
                        "<br>",
                        "Number of Bed Days per 1000 population: ",
                        E1_plot2_Data()$dd_bed_days)
   
   ### Create the main body of the chart ----
   
   plot_ly(data = E1_plot2_Data(),
           # Select your variables.
           
           x = ~rate_per_1000_population, 
           y = ~area_name,  
          # fill = ~to_highlight,     # highlighting Scotland but this is working with color and colors below
           marker = list(color = ~to_highlight), # This stops the colour legend appearing on the hover. Using color= and colors= below adds the legend 
           # color = ~to_highlight,
           # colors = c("#0080FF", "seagreen"), # line colour - Dark blue for all lines. seagreen for test 
           #text = tooltip_E1_plot2,          # This and hoverinfo = "text" were showing the info when hovering AND permanently on the graph 
          # hoverinfo = "text",
          hoverinfo = tooltip_E1_plot2,
          type = 'bar', orientation = 'h') %>% 
   
      

   ### Graph titles -----
   
   layout(
      title = paste0("<b>",
                     "Delayed Discharge Bed Days for the Financial Year: ", input$E1_plot2_year,
                     "<br>",
                     "</b>"),
    #  title = list(standoff = 1),  # tried lots of ways of doing this but nothing working
      #title = list(size = 12, y = 5, x = 0, xanchor = 'center', yanchor =  'top'),    # none of this does anything to change things (no variation of any of them)
    
      separators = ".",

      yaxis = list(title =""),

      xaxis = list(title = "Number of Days", 
                       dtick = 10,                # shows a marker for every 10th number of bed days 
                       range = list(0, 80)),      # ensures all graphs have the same range of 0- 80 days (make sure this is extended if needed, it's going up each year)
    
      font = list(size = 12),
      
      showlegend = FALSE)
      
})