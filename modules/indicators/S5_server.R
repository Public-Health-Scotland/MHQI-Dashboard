# S5 Trends Plot(s) ----

# Two Graphs: 
# 1. HB trend graph - user selects up to 4 HBs to compare incidents per 1000 bed days over time
# 2. Measure graph for quarter - user selects calendar quarter to compare HB's incidents. 

# Tables: 
# Graphs show incidents per 1000 bed days, but tables also include "total bed days" and 
# "no. of incidents"


# Graph 1 - comparing HBs over time ---- 
## Health Board Selector ---- 
# Picker for user selecting up to 4 health boards
output$S5_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "S5_trendPlot_hbName",
      label = "Select NHS health board(s) (Maximum 4):",
      choices = sort_hb_names(unique(S5_data$nhs_health_board)),  # pulled out in data_preparation.R
      multiple = TRUE,
      options = list("max-options" = 4,
                     `selected-text-format` = "count > 1"),
      # No Scotland data has been calculated for HB returns indicators: S2, S5, EF5
      selected = "NHS Ayrshire & Arran")
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
S5_trendPlot_data <- reactive({
   S5_data %>%
      select(!c("year_quarter", "year")) %>% 
      filter(nhs_health_board %in% input$S5_trendPlot_hbName)
})


## Create the S5 line chart ----
output$S5_trendPlot <- renderPlotly({
  create_trend_plot(
    data = S5_trendPlot_data(),
    x_column = "year_months",
    y_column = "incidents_per_1000_bed_days",
    group_column = "nhs_health_board",
    x_axis_title = "Quarter",
    y_axis_title = "Incidents per 1,000 occupied psychiatric bed days",
    tooltip_columns = c(
      "Quarter" = "year_months",
      "Health board" = "nhs_health_board",
      "Incidents per 1,000 occupied psychiatric bed days" = "incidents_per_1000_bed_days"
    ),
    tooltip_suffix = c("", "", ""))
})


## Table below graph 1 ----
output$S5_1_table <- renderDataTable({
   datatable(S5_trendPlot_data() %>% 
                # Add "NA" as a value to table on dashboard:
               mutate(across(number_of_incidents:incidents_per_1000_bed_days, ~replace(., is.na(.), "NA"))) %>% 
               # Add commas to large values but keep "NA" or "*" character values:
               mutate(total_occupied_psychiatric_bed_days = if_else(!grepl("\\D", total_occupied_psychiatric_bed_days), 
                                                                             format(as.numeric(total_occupied_psychiatric_bed_days), 
                                                                                    big.mark = ",", trim = T), 
                                                                    total_occupied_psychiatric_bed_days), 
                      number_of_incidents = if_else(!grepl("\\D", number_of_incidents),
                                                    format(as.numeric(number_of_incidents), 
                                                           big.mark = ",", trim = T), 
                                                    number_of_incidents)),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                            # Right align numeric columns - it's columns 3:5 but use 2:4 as rownames = FALSE
                            columnDefs = list(list(className = 'dt-right', targets = 2:4))), 
             colnames = c("NHS Health Board",
                          "Quarter",
                          "Number of Incidents", 
                          "Total Occupied Psychiatric Bed Days", 
                          "Incidents per 1,000 Bed Days"))
})

## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$S5_1_table_download <- downloadHandler(
   filename = 'S5 - Incidences of physical violence.csv',
   content = function(file) {
      write.table(S5_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("NHS Health Board",
                                "Quarter",
                                "Number of Incidents", 
                                "Total Occupied Psychiatric Bed Days", 
                                "Incidents per 1,000 Bed Days"),
                  sep = ",")
   })


# Graph 2 - All HBs incidents by Quarter ----
## Picker for user selecting Quarter ----
output$S5_plot2_quarter_output <- renderUI({
   shinyWidgets::pickerInput(
      "S5_plot2_quarter",
      label = "Select quarter:",
      choices = unique(S5_data$year_months),
      selected = "Apr-Jun 2026")
})

## Selecting appropriate data for graph 2 ---- 
S5_plot2_data <- reactive({
   S5_data %>%
      select(!c("year_quarter", "year")) %>%
    filter(nhs_health_board != "NHS Orkney" & 
             nhs_health_board != "NHS Shetland") %>%
    mutate(across(c(number_of_incidents, total_occupied_psychiatric_bed_days,), as.numeric)) |> 
    mutate(across(where(is.numeric), ~replace_na(., 0))) |> 
      filter(year_months %in% input$S5_plot2_quarter) %>%
      # for ordering graph by value:
      mutate(nhs_health_board = fct_reorder(nhs_health_board, incidents_per_1000_bed_days,
                                            .na_rm = FALSE)) %>%  # This row is required or crashes
      # For adding "NA" annotation to graph:
      mutate(graph_value = if_else(is.na(incidents_per_1000_bed_days),
                                   0, incidents_per_1000_bed_days),
             graph_value_label = if_else(is.na(incidents_per_1000_bed_days),
                                   "NA", as.character(incidents_per_1000_bed_days)))
 })



## Selecting appropriate data for table 2 ---- 
S5_plot2_data_for_table <- reactive({
   S5_data %>%
      select(!c("year_quarter", "year")) %>%  
      filter(year_months %in% input$S5_plot2_quarter)
})

## Graph 2 title ----
output$S5_plot2_title <- renderUI({
  
  req(input$S5_plot2_quarter)
  
  paste0("Incidents of physical violence per 1,000 occupied psychiatric bed days, by ", 
         "NHS health board, in ", input$S5_plot2_quarter)
})

## Create the bar chart ----
output$S5_plot2 <- renderPlotly({
  create_bar_plot(
    data = S5_plot2_data(),
    x_column = "graph_value",
    y_column = "nhs_health_board",
    x_axis_title = "Incidents per 1,000 occupied psychiatric bed days",
    y_axis_title = "",
    
    tooltip_columns = c(
      "Quarter" = "year_months",
      "Health board" = "nhs_health_board",
      "Incidents per 1,000 occupied psychiatric bed days" = "graph_value"
    ),
    
    tooltip_suffix = c("", "", "")
  )
})


## Table for graph 2 ----
output$S5_2_table <- renderDataTable({
   datatable(
      S5_plot2_data_for_table() %>% 
         # Add "NA" as a value to table on dashboard:
         mutate(across(number_of_incidents:incidents_per_1000_bed_days, ~replace(., is.na(.), "NA"))) %>% 
        # Add commas to large values but keep "NA" or "*" character values:
        mutate(total_occupied_psychiatric_bed_days = if_else(!grepl("\\D", total_occupied_psychiatric_bed_days), 
                                                             format(as.numeric(total_occupied_psychiatric_bed_days), 
                                                                    big.mark = ",", trim = T), 
                                                             total_occupied_psychiatric_bed_days), 
               number_of_incidents = if_else(!grepl("\\D", number_of_incidents),
                                             format(as.numeric(number_of_incidents), 
                                                    big.mark = ",", trim = T), 
                                             number_of_incidents)),
      style = 'bootstrap', 
      class = 'table_bordered table-condensed',
      rownames = FALSE, 
      options = list(
         pageLength = 16, 
         autoWidth = FALSE, 
         dom = 'tip', 
         # Right align numeric columns - it's columns 3:5 but use 2:4 as rownames = FALSE
         columnDefs = list(list(className = 'dt-right', targets = 2:4))),
      colnames = c("NHS Health Board",
                   "Quarter",
                   "Number of Incidents", 
                   "Total Occupied Psychiatric Bed Days", 
                   "Incidents per 1,000 Bed Days")
   )
   })

## Graph 2 data download button ----
# Allows users to the download tables in .csv format ----
output$S5_2_table_download <- downloadHandler(
   filename = 'S5 - Incidences of physical violence for chosen quarter.csv', 
   content = function(file) {
      write.table(S5_plot2_data_for_table(),  
                  file, 
                  row.names = FALSE, 
                  col.names = c("NHS Health Board",
                                "Quarter",
                                "Number of Incidents", 
                                "Total Occupied Psychiatric Bed Days", 
                                "Incidents per 1,000 Bed Days"), 
                  sep = ",")
      
   }
)