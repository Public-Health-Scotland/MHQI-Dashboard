# E1 Graphs ---- 

# Two Graphs: 
# 1. HB/CA trend graph - user selects up to 4 HBs or CAs to compare total bed days over time
# 2. Bar Chart - user selects year and either HB or CA to cpmpare bed days per 1,000

# Tables: 
# Both: Year, HB/CA, area name, total bed days, rate per 1000 population

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
      select(fyear, area_type, area_name, dd_bed_days, rate_per_1000_population) %>%
      filter(area_type %in% input$E1_plot1_areaType          # don't think we really need this first filter but doesn't harm anything?
             & area_name %in% input$E1_plot1_areaName)
})
 
## Reactive graph 1 title ---- 

g1_title <- reactive({
   req(input$E1_plot1_areaType)
   
   g1_title_options <- if_else(input$E1_plot1_areaType == "Health board", 
                               paste0("Total number of days spent in hospital within mental health specialties when ",
                                      "patients are ready to be discharged, by financial year, in selected NHS health board(s)"),
                               paste0("Total number of days spent in hospital within mental health specialties when ",
                                      "patients are ready to be discharged, by financial year, in selected council area(s)"))
})

output$E1_graph1_selected_areaName <- renderText({
   g1_title()
}) 


## Create the discharges line chart ----

output$E1_plot1 <- renderPlotly({
   
   # Assign to an object so we can add Orkney/Shetland data title note afterwards
   E1_plot1_plotly <- plot_ly(data = E1_plot1_Data(), 
                    
                    x = ~fyear, 
                    y = ~dd_bed_days, 
                    color = ~area_name, 
                    
                    # Tooltip text - Health board of treatment OR Council area of residence
                    text = if_else(E1_plot1_Data()$area_type == "Health board", 
                                   paste0("Financial year: ",
                                          E1_plot1_Data()$fyear,
                                          "<br>",
                                          "Health board of treatment: ",
                                          E1_plot1_Data()$area_name,
                                          "<br>",
                                          "Total number of days: ",
                                          E1_plot1_Data()$dd_bed_days, 
                                          "<br>",
                                          "Rate per 1,000 population: ",
                                          E1_plot1_Data()$rate_per_1000_population),
                                   paste0("Financial year: ",
                                          E1_plot1_Data()$fyear,
                                          "<br>",
                                          "Council area of residence: ",
                                          E1_plot1_Data()$area_name,
                                          "<br>",
                                          "Total number of days: ",
                                          E1_plot1_Data()$dd_bed_days, 
                                          "<br>",
                                          "Rate per 1,000 population: ",
                                          E1_plot1_Data()$rate_per_1000_population)),
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
               
               layout(# graph title is in a box above the graph and Orkney/Shetland 
                      # reminder title is below this code. 
                      yaxis = list(exponentformat = "none",
                                   separatethousands = TRUE,  
                                   range = list(0, max(E1_plot1_Data()$dd_bed_days, na.rm = TRUE) * 1.2), 
                                   # Wrap the y axis title in spaces so it doesn't cover the tick labels.
                                   title = paste0(c(rep("&nbsp;", 20),
                                                    print("Total Number of Days"), 
                                                    rep("&nbsp;", 20),
                                                    rep("\n&nbsp;", 3)),
                                                  collapse = ""),#),
                                   showline = TRUE, 
                                   ticks = "outside"),
                      
                      xaxis = list(tickangle = -45,            # Diagonal x-axis ticks
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
                                    bordercolor = 'rgba(255, 255, 255, 0)'))%>%
      
      ### Remove any buttons we don't need from the modebar ----
      config(displayModeBar = TRUE,
             modeBarButtonsToRemove = list('select2d', 'lasso2d', 
                                           # 'zoomIn2d', 'zoomOut2d', 'autoScale2d', 
                                           'toggleSpikelines', 
                                           'hoverCompareCartesian', 
                                           'hoverClosestCartesian'), 
             displaylogo = F, 
             editable = F)
  
     ### Add Orkney/ Shetland reminder title ---- 
  
         if #("NHS Orkney" %in% input$E1_plot1_areaName &    # Not necessary
        #     "NHS Shetland" %in% input$E1_plot1_areaName) {
        #    E1_plot1_plotly <- E1_plot1_plotly %>% 
        #       layout(title = "NHS Orkney & NHS Shetland values are included in NHS Grampian data")
        #    } else if 
             ("NHS Orkney" %in% input$E1_plot1_areaName) {
              E1_plot1_plotly <- E1_plot1_plotly %>%
                 layout(title = "NHS Orkney & NHS Shetland values are included in NHS Grampian data")
              } else if ("NHS Shetland" %in% input$E1_plot1_areaName) {
                 E1_plot1_plotly <- E1_plot1_plotly %>% 
                    layout(title = "NHS Orkney & NHS Shetland values are included in NHS Grampian data")
                 } else {
                    E1_plot1_plotly <- E1_plot1_plotly %>% layout(title = NULL)
                    }
  
  
  ### Return the plot ----
  E1_plot1_plotly
  
      
})


## Table below graph 1 ----
 
 output$E1_1_table <- renderDataTable({
   datatable(E1_plot1_Data() %>% 
                # Add "NA" as a value to table on dashboard:
                mutate(across(dd_bed_days:rate_per_1000_population, ~replace(., is.na(.), "NA"))),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("Financial Year",
                          "Area Type",
                          "Area Name",
                          "Total Number of Bed Days",
                          "Rate per 1,000 Population"))
    })

 ## Table 1 download button ---- 
 output$E1_1_table_download <- downloadHandler(
    filename = 'E1 - Total bed days in chosen area(s) for patients ready to be discharged.csv',
    content = function(file) {
       write.table(E1_plot1_Data(),
                   file,
                   #Remove row numbers as the .csv file already has row numbers.
                   row.names = FALSE,
                   col.names = c("Financial Year",
                                 "Area Type",
                                 "Area Name",
                                 "Total Number of Bed Days",
                                 "Rate per 1,000 Population"),
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
# Taking Orkney and Shetland out of the graph, adding ordering, adding colours for graph
E1_plot2_Data <- reactive({
   E1_data %>%
      select(fyear, area_type, area_name, dd_bed_days, rate_per_1000_population) %>%
     # filter(area_type == "Health board") %>% 
      filter(area_type == "Health board" &
                (area_type == "Health board" &
                    (area_name != "NHS Orkney" & area_name !="NHS Shetland"))) %>%
      filter(fyear %in% input$E1_plot2_year) %>% 
      mutate(area_name = fct_reorder(area_name, rate_per_1000_population)) %>%    # for ordering by most to least bed days
      mutate(to_highlight = if_else(area_name == "NHS Scotland",                  # for highlighting NHS Scotland 
                                    "#3F3685", "#0078D4"))                       # changed from "yes" and "no" so that these colours 
})                                                             # appear on the graph and don't have a legend using "marker = list(color... )"

## Selecting appropriate data for table 2 ---- 
E1_plot2_Data_for_table <- reactive({
   E1_data %>%
      select(fyear, area_type, area_name, dd_bed_days, rate_per_1000_population) %>%
      filter(area_type == "Health board")  %>%
      filter(fyear %in% input$E1_plot2_year) 
   })
   
## Reactive graph 2 title ---- 

output$E1_graph2_selected_fyear <- renderUI({
   req(input$E1_plot2_year)
   
   paste0("Number of days spent in hospital within mental health specialties when ",
          "patients are ready to be discharged, per 1,000 population, by NHS health board, ",
          "in ", input$E1_plot2_year)
   
})


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
           marker = list(#color = '#0078D4', 
              color = ~to_highlight,
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
                          range = list(0, max(E1_data$rate_per_1000_population, na.rm = TRUE) * 1.1),
                          # Re: range - all time highest figure so that quarters can be compared visually when clicking through them
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


## Graph 2 data table ----

output$E1_2_table <- renderDataTable({
  datatable(E1_plot2_Data_for_table() %>% 
               # Add "NA" as a value to table on dashboard:
               mutate(across(dd_bed_days:rate_per_1000_population, ~replace(., is.na(.), "NA"))),
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
    write.table(E1_plot2_Data_for_table(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Financial Year",
                              "Area Type",
                              "Area Name",
                              "Total Number of Bed Days",
                              "Rate per 1,000 Population"),
                sep = ",")
  }
)

