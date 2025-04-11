# E1 Graphs ---- 

# Two Graphs: 
# 1. HB/CA trend graph - user selects up to 4 HBs or CAs to compare total bed days over time
# 2. Bar Chart - user selects year and either HB or CA to cpmpare bed days per 1,000

# Tables: 
# 1. Year, HB/CA, area name, total bed days
# 2. Year, HB/CA, area name, total bed days, rate per 1000 population

# PLOT 1 - comparing HB/CAs over time ----

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
      multiple = TRUE,
      options = list("max-options" = 4,
                      `selected-text-format` = "count > 1"),
      selected = "NHS Scotland"
   )
})

## Selecting appropriate data for graph 1 ---- 
E1_plot1_Data <- reactive({
   E1_data %>%
      select(fyear, area_type, area_name, dd_bed_days) %>%
      filter(area_type %in% input$E1_plot1_areaType          # don't think we really need this first filter but doesn't harm anything?
             & area_name %in% input$E1_plot1_areaName)
})
 

## Create the discharges line chart ----

   ### Render plotly ----

output$E1_plot1 <- renderPlotly({
   
   plot_ly(data = E1_plot1_Data(), 
           
           x = ~fyear, 
           y = ~dd_bed_days, 
           color = ~area_name, 
           
           # Tooltip text
           text = paste0("Financial year: ",
                         E1_plot1_Data()$fyear,
                         "<br>",
                         "Area of residence: ",
                         E1_plot1_Data()$area_name,
                         "<br>",
                         "Total number of days: ",
                         E1_plot1_Data()$dd_bed_days), 
           hoverinfo = "text",
           
           # Line aesthetics: 
           type = 'scatter',
           mode = 'lines+markers', 
           line = list(width = 3), 
           colors = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
           linetype = ~area_name, 
           linetypes = c("solid", "dashed", "solid", "dashed"), 
           symbol = ~area_name,
           symbols = c("circle", "square", "triangle-up", "triangle-down"),
           marker = list(size = 12),
           # Size of graph:
           height = 600,
           # Legend info:
           name = ~str_wrap(area_name, 15)) %>%
      
      layout(yaxis = list(exponentformat = "none",
                          separatethousands = TRUE, 
                        #  range = c(0, max(E1_plot1_Data()$dd_bed_days, na.rm = TRUE) * 110 / 100), 
                          range = c(0, max(E1_plot1_Data()$dd_bed_days) * 110 / 100), 
                          
                          
                          # Wrap the y axis title in spaces so it doesn't cover the tick labels.
                          title = paste0(c(rep("&nbsp;", 20),
                                           print("Total Number of Days"), 
                                           rep("&nbsp;", 20),
                                           rep("\n&nbsp;", 3)),
                                         collapse = ""),#),
                          showline = TRUE, 
                          ticks = "outside"
      ),
      
      xaxis = list(tickangle = -45,                    # Diagonal x-axis ticks
                   title = paste0(c(rep("&nbsp;", 20),
                                    "<br>",
                                    "<br>",
                                    "Financial Year",
                                    rep("&nbsp;", 20),
                                    rep("\n&nbsp;", 3)),
                                  collapse = ""),
                   showline = TRUE, 
                   ticks = "outside"),
      
      # Set the graph margins:
      margin = list(l = 90, r = 60, b = 170, t = 90),  
      
      # Set the font sizes:
      font = list(size = 13),
      
      # Add a legend & make the legend background and border white:            
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
             displaylogo = F, 
             editable = F)
   
   
})



############## OLD CODE using ggplot ##################
# output$E1_plot1 <- renderPlotly({
#    
#    ### Create reactive ggplot graph 
#    
#    E1_plot1_graph <- reactive({
#       
#       ggplot(data = E1_plot1_Data(), 
#              aes(x = fyear, 
#                  y = dd_bed_days,  
#                  text = paste0("Financial year: ",
#                                 E1_plot1_Data()$fyear,
#                                 "<br>",
#                                 "Area of residence: ",
#                                 E1_plot1_Data()$area_name,
#                                 "<br>",
#                                 "Total number of bed days: ",
#                                 E1_plot1_Data()$dd_bed_days))) + # for tooltip in ggplotly - shows values on hover
#          geom_line() +
#          geom_point(size = 2.5) +
#          aes(group = area_name,
#              linetype = area_name,
#              color = area_name,   # Have to do this outside so that the legends shows and so that there aren't 3 legends
#              shape = area_name) +
#          scale_color_discrete_phs(name = "Area name", 
#                                   palette = "main-blues",
#                                   labels = ~ stringr::str_wrap(.x, width = 15)) +
#          # scale_color_manual(name = "Area name", 
#          #                    values = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"),
#          #                    labels = ~ stringr::str_wrap(.x, width = 15)) +
#          scale_linetype_manual(name = "Area name", 
#                                values = c("solid", "dashed", "solid", "dashed"),
#                                labels = ~ stringr::str_wrap(.x, width = 15)) +
#          scale_shape_manual(name = "Area name", 
#                             values = c("circle", "circle", "triangle-up", "triangle-up"), 
#                             labels = ~ stringr::str_wrap(.x, width = 15)) +
#          theme_classic() +                         # I normally use bw but will see what this looks like (de-clutters graph background)
#          theme(panel.grid.major.x = element_line(),  # Shows vertical grid lines 
#                panel.grid.major.y = element_line(),  # Shows horizontal grid lines 
#                axis.title.x = element_text(size = 12,
#                                            color = "black",
#                                            face = "bold"),
#                axis.title.y = element_text(size = 12,
#                                            color = "black",
#                                            face = "bold"),
#                legend.text = element_text(size = 8, 
#                                           colour = "black"), 
#                legend.title = element_text(size = 9, 
#                                            colour = "black", 
#                                            face = "bold")) +  
#          labs(x = "Financial Year", 
#               y = "Total Number of Days") +
#          scale_y_continuous(expand = c(0, 0),   # Ensures y axis starts from zero (important for Orkney and Shetland HBs which are all zero)
#                             limits = c(0, (max(E1_plot1_Data()$dd_bed_days) + 0.5*max(E1_plot1_Data()$dd_bed_days)))) 
#   
#        })
#        
#       ### Run graph 1 through plotly
#    
#    ggplotly(E1_plot1_graph(), 
#             tooltip = "text") %>%     # uses text set up in ggplot aes above. 
#          ### Remove unnecessary buttons from the modebar
#             config(displayModeBar = TRUE,                   
#                    modeBarButtonsToRemove = bttn_remove,
#                    displaylogo = F, editable = F)
#    
# })

## Table below graph 1 ----
 
 output$E1_1_table <- renderDataTable({
   datatable(E1_plot1_Data(),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("Financial Year",
                          "Area Type",
                          "Area Name",
                          "Total Number of Bed Days"))
    })

 ## Table 1 download button ---- 
 output$E1_1_table_download <- downloadHandler(
    filename = 'E1 - Total bed days in chosen area for patients ready to be discharged.csv',
    content = function(file) {
       write.table(E1_plot1_Data(),
                   file,
                   #Remove row numbers as the .csv file already has row numbers.
                   row.names = FALSE,
                   col.names = c("Financial Year",
                                 "Area Type",
                                 "Area Name",
                                 "Total Number of Bed Days"),
                   sep = ",")
    }
 )



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

                                                               

## Create the discharges bar chart ----


output$E1_plot2 <- renderPlotly({
   
   plot_ly(data = E1_plot2_Data(),
           x = ~rate_per_1000_population,
           y = ~area_name,
           # Tooltip text: 
           text = paste0("Financial year: ", E1_plot2_Data()$fyear, 
                         "<br>",
                         "Health board of treatment: ", E1_plot2_Data()$area_name,
                         "<br>",
                         "Bed days per 1,000 population: ", E1_plot2_Data()$rate_per_1000_population), 
           hoverinfo = "text", 
           
           # Bar aesthetics:
           type = 'bar', 
           marker = list(color = '#0078D4', 
                         size = 12), 
           textposition = "none", # removes small text on each bar
           # Size of graph: 
           height = 600) %>% 
      
      layout(font = list(size = 13), 
             yaxis = list(title = "",  # set as an empty string as is not needed
                          exponentformat = "none",
                          showline = TRUE, 
                          ticks = "outside"), 
             # Wrap the x axis title in spaces so it doesn't cover the tick labels.
             xaxis = list(title = paste0(c(rep("&nbsp;", 20),
                                           "<br>",
                                           "<br>",
                                           "Number of Days per 1,000 Population", 
                                           rep("&nbsp;", 20),
                                           rep("\n&nbsp;", 3)),
                                         collapse = ""),
                          showline = TRUE, 
                          ticks = "outside"),
             # Set graph margins:
             margin = list(l = 90, r = 60, b = 170, t = 90)) %>%
      
      # Remove any buttons we don't need from the modebar:
      config(displayModeBar = TRUE,
             modeBarButtonsToRemove = list('select2d', 'lasso2d', 
                                           # 'zoomIn2d', 'zoomOut2d', 'autoScale2d', 
                                           'toggleSpikelines', 
                                           'hoverCompareCartesian', 
                                           'hoverClosestCartesian'), 
             displaylogo = F, editable = F)
   
   })



# ### OLD GGPLOT CODE ##############
#    ### Render plotly
# 
# output$E1_plot2 <- renderPlotly({
#    
#   ### Create reactive ggplot graph
# 
# E1_plot2_graph <- reactive({
#    ggplot(E1_plot2_Data(),  
#                    aes(x = rate_per_1000_population, 
#                        y = area_name,  
#                        fill = to_highlight,  # colours defined below (highlights NHS Scotland)
#                        text = paste0("Financial year: ", fyear,        # for tooltip in ggplotly - shows values on hover
#                        "<br>",
#                        "Area of residence: ", area_name,
#                        "<br>",
#                        "Bed days per 1,000 population: ", rate_per_1000_population)
#                        )) +
#    geom_bar(stat = "identity") +             # creates bar graph with bars separated from each other
#    scale_fill_manual(values = phs_colours(c("phs-blue", "phs-green"))) + # highlights NHS Scotland
# #  scale_fill_manual(values = c("#0080FF", "seagreen")) +  # highlights NHS Scotland
#    theme_classic() +                         # I normally use bw but will see what this looks like (de-clutters graph background)
#    theme(panel.grid.major.x = element_line(),  # Shows vertical grid lines 
#          panel.grid.major.y = element_line(),  # Shows horizontal grid lines 
#          axis.title.x = element_text(size = 12,
#                                      color = "black",
#                                      face = "bold"),
#          axis.title.y = element_blank(), 
#          legend.position = "none") +           # removes legend 
#    labs(x = "Number of Days per 1,000 Population", y = NULL) +
#    scale_x_continuous(limits = c(0, (max(E1_data$rate_per_1000_population) + 9)), # Keeps the x-axis the same length for all graphs, ranges from 0 to the max value plus 9 so that the last tick can be seen
#                       breaks = seq(0, (max(E1_data$rate_per_1000_population) + 9), by = 10)) # x-axis ticks range from 0 to the max value + 9, showing increments of 10     
# 
# })
#    ### Run graph 2 through plotly
# 
# ggplotly(E1_plot2_graph(), 
#          tooltip = "text") %>%     # uses text set up in ggplot aes above. 
#           ### Remove unnecessary buttons from the modebar
#          config(displayModeBar = TRUE,
#                  modeBarButtonsToRemove = bttn_remove,
#                  displaylogo = F, editable = F)
# 
# })


## Graph 2 data table ----

output$E1_2_table <- renderDataTable({
  datatable(E1_plot2_Data() %>% 
               select(!c("to_highlight")),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
                         #  columnDefs = list(list(visible=FALSE, targets=5))),
            colnames = c("Financial Year",
                         "Area Type",
                         "Area Name",
                         "Total Number of Bed Days",
                         "Rate per 1,000 Population"))
})

## Table 2 download button ---- 
# allows user to download selected data in .csv format


output$E1_2_table_download <- downloadHandler(
  filename = 'E1 - Bed days per 1000 population when patient ready for discharge for chosen year.csv',
  content = function(file) {
    write.table(E1_plot2_Data()%>% 
                   select(!"to_highlight"),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Financial Year",
                              "Area Type",
                              "Area Name",
                              "Total Number of Bed Days",
                              "Rate per 1000 Population"),
                sep = ",")
  }
)

