# E1 Graphs ---- 

# Two Graphs: 
# 1. HB/CA trend graph - user selects up to 4 HBs or CAs to compare total bed days over time
# 2. Bar Chart - user selects year and either HB or CA to compare bed days per 1,000

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
    choices = unique(as.character(
      E1_data$area_name
      [E1_data$area_type %in% input$E1_plot1_areaType]
    )),
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
  create_trend_plot(
    data = E1_plot1_Data(),
    x_column = "fyear",
    y_column = "dd_bed_days",
    group_column = "area_name",
    x_axis_title = "Financial year",
    y_axis_title = "Total Number of Days",
    tooltip_columns = c(
      "Financial year" = "fyear",
      setNames("area_name", input$E1_plot1_areaType),
      "Total number of days" = "dd_bed_days",
      "Rate per 1,000 population" = "rate_per_1000_population"),
    tooltip_suffix = c("", "", "comma", ""))
})


## Table below graph 1 ----
output$E1_1_table <- renderDataTable({
  datatable(E1_plot1_Data() %>% 
              # Add commas to large numbers but keep "NA" as a visible value on dashboard:
              mutate(dd_bed_days = if_else(is.na(dd_bed_days), 
                                           "NA", 
                                           formatC(dd_bed_days,
                                                   format = "f",
                                                   digits = 0, # digits after decimal point
                                                   big.mark =",")),
                     rate_per_1000_population = if_else(is.na(rate_per_1000_population),
                                                        "NA", 
                                                        formatC(rate_per_1000_population,
                                                                format = "f",
                                                                digits = 2, # digits after decimal point
                                                                big.mark =","))),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                           # Right align numeric columns - it's columns 4:5 but use 3:4 as rownames = FALSE
                           columnDefs = list(list(className = 'dt-right', targets = 3:4))), 
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
    selected = "2025/26")
})

## Selecting appropriate data for graph 2 ---- 
# Taking Orkney and Shetland out of the graph, adding ordering, adding colours for graph
E1_plot2_Data <- reactive({
  E1_data %>%
    filter(area_type == "Health board") |> 
    select(fyear, area_type, area_name, dd_bed_days, rate_per_1000_population) %>%
    filter(fyear %in% input$E1_plot2_year) %>% 
    mutate(area_name = fct_reorder(area_name, rate_per_1000_population)) # for ordering by most to least bed days
})                                                            


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
  create_bar_plot(
    data = E1_plot2_Data(),
    x_column = "rate_per_1000_population",
    y_column = "area_name",
    x_axis_title = "Number of Days per 1,000 Population",
    y_axis_title = "",
    
    tooltip_columns = c(
      "Financial Year" = "fyear",
      "Health board of treatment" = "area_name",
      "Bed days per 1,000 population" = "rate_per_1000_population"
    ),
    tooltip_suffix = c("", "", "")
  )
})


## Graph 2 data table ----
output$E1_2_table <- renderDataTable({
  datatable(E1_plot2_Data_for_table() %>% 
              # Add commas to large numbers but keep "NA" as a visible value on dashboard:
              mutate(dd_bed_days = if_else(is.na(dd_bed_days), 
                                           "NA", 
                                           formatC(dd_bed_days,
                                                   format = "f",
                                                   digits = 0, # digits after decimal point
                                                   big.mark =",")),
                     rate_per_1000_population = if_else(is.na(rate_per_1000_population),
                                                        "NA", 
                                                        formatC(rate_per_1000_population,
                                                                format = "f",
                                                                digits = 2, # digits after decimal point
                                                                big.mark =","))),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                           # Right align numeric columns - it's columns 4:5 but use 3:4 as rownames = FALSE
                           columnDefs = list(list(className = 'dt-right', targets = 3:4))), 
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