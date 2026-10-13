# S2 Trends Plot(s) ----

# Three graphs: 
# 1. Comparing HBs percentages over time, user selects up to 4 HBs 
# 2. All HBs percentages by user selected quarter
# 3. Total discharges and followed up, user selects HB.


# Graph 1 - Comparing health boards % over time ---- 
## Picker for user selecting specific health board ---- 
output$S2_trendPlot_hbName_output <- renderUI({
  
  create_hb_picker(
    input_id = "S2_trendPlot_hbName",
    choices = S2_data$nhs_health_board,
    selected = "NHS Ayrshire & Arran"
  )
  
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
S2_trendPlot_data <- reactive({
  S2_data %>%
    select(!c("year_quarter", "year")) %>% 
    filter(nhs_health_board %in% input$S2_trendPlot_hbName)
})


## Create graph 1 line chart ----
### Render plotly ----
output$S2_trendPlot <- renderPlotly({
  selected_hbs <- input$S2_trendPlot_hbName
  notes <- c()
  if ("NHS Lanarkshire" %in% selected_hbs) {
    notes <- c(notes,
               "Data are not available for NHS Lanarkshire."
    )
  }
  if ("NHS Shetland" %in% selected_hbs) {
    notes <- c(notes,
               "Data for NHS Shetland are not available due to small numbers."
    )
  }
  if ("NHS Orkney" %in% selected_hbs) {
    notes <- c(notes,
               "Data for NHS Orkney are not available due to small numbers."
    )
  }
  annotation_text <- paste(notes, collapse = "<br>")
  p <- create_trend_plot(
    data = S2_trendPlot_data(),
    x_column = "year_months",
    y_column = "percentage_followed_up",
    group_column = "nhs_health_board",
    y_axis_title = "Percentage followed up",
    tooltip_value_title = "Percentage followed up",
    tooltip_suffix = "%",
    x_axis_title = "Quarter"
  )
  if (nzchar(annotation_text)) {
    p <- p %>%
      plotly::layout(
        margin = list(b = 120),
        annotations = list(
          list(
            text = annotation_text,
            x = 0.5,
            y = 1,
            xref = "paper",
            yref = "paper",
            xanchor = "centre",
            yanchor = "middle",
            showarrow = FALSE,
            align = "centre"
          )
        )
      ) 
  }
  p
})


## Table below graph 1 ----
output$S2_1_table <- renderDataTable({
  datatable(S2_trendPlot_data() %>% 
              # Add "NA" as a value to table on dashboard:
              mutate(across(number_of_patients_followed_up:total_number_of_discharged_patients, ~replace(., is.na(.), "NA"))) %>% 
              # Add % sign to percentage variable:
              mutate(percentage_followed_up = if_else(is.na(percentage_followed_up),
                                                      "NA",
                                                      paste0(percentage_followed_up, "%"))) %>% 
              # Add commas to large values but keep "NA" or "*" character values (values are all currenlty under 1000 so don't need this yet):
              mutate(total_number_of_discharged_patients = if_else(!grepl("\\D", total_number_of_discharged_patients), 
                                                                   format(as.numeric(total_number_of_discharged_patients), 
                                                                          big.mark = ",", trim = T), 
                                                                   total_number_of_discharged_patients)),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                           # Right align numeric columns - it's columns 3:5 but use 2:4 as rownames = FALSE
                           columnDefs = list(list(className = 'dt-right', targets = 2:4))), 
            colnames = c("Health Board",
                         "Quarter",
                         "Number of Patients Followed Up", 
                         "Total Number of Discharged Patients", 
                         "Percentage Followed Up (%)"))
})

## Graph 1 data download button ----
# Allows users to download tables in .csv format 
output$S2_1_table_download <- downloadHandler(
  filename = 'S2 - Discharge followed up for chosen health boards.csv',
  content = function(file) {
    write.table(S2_trendPlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Health Board",
                              "Quarter",
                              "Number of Patients Followed Up", 
                              "Total Number of Discharged Patients", 
                              "Percentage Followed Up (%)"),
                sep = ",")
  })



# Graph 2 - All HBs percentages by Quarter ---- 
## Picker for user selecting Quarter ----
output$S2_plot2_quarter_output <- renderUI({
  shinyWidgets::pickerInput(
    "S2_plot2_quarter",
    label = "Select quarter:",
    choices = unique(S2_data$year_months),
    selected = "Apr-Jun 2026")
})

## Selecting appropriate data for graph 2 ---- 
# Taking Orkney and Shetland out of the graph, adding ordering, adding NA for annotations
S2_plot2_data <- reactive({
  S2_data %>%
    select(nhs_health_board, year_months, number_of_patients_followed_up, 
           total_number_of_discharged_patients, percentage_followed_up) %>%
    mutate(across(c(number_of_patients_followed_up, total_number_of_discharged_patients), as.numeric)) |> 
    mutate(across(where(is.numeric), ~replace_na(., 0))) |> 
    filter(year_months %in% input$S2_plot2_quarter) %>% 
    mutate(nhs_health_board = fct_reorder(nhs_health_board, percentage_followed_up, # for ordering by percentage
                                          .na_rm = FALSE)) %>%      # required or crashes
    #For adding "NA" annotation to graph:
    mutate(graph_value = if_else(is.na(percentage_followed_up),
                                 0, percentage_followed_up),
           graph_value_label = if_else(is.na(percentage_followed_up),
                                       "NA", as.character(percentage_followed_up)))
})   

## Selecting appropriate data for table 2 ---- 
S2_plot2_data_for_table <- reactive({
  S2_data %>% 
    select(nhs_health_board, year_months, number_of_patients_followed_up, 
           total_number_of_discharged_patients, percentage_followed_up) %>%
    filter(year_months %in% input$S2_plot2_quarter) 
})


## Graph 2 title ----
output$S2_plot2_title <- renderUI({
  
  req(input$S2_plot2_quarter)
  
  paste0("Percentage of psychiatric inpatients followed up by community ",
         "mental health services within 7 calendar days of being discharged, ",
         "by NHS health board, in ", input$S2_plot2_quarter)
  
  
})

## Create graph 2 ----
output$S2_plot2 <- renderPlotly({
  
  create_bar_plot(
    data = S2_plot2_data(),
    
    x_column = "graph_value",
    y_column = "nhs_health_board",
    
    board_column = "nhs_health_board", #add hb in to colour as hb name changes for diff indicators
    
    x_axis_title = "Percentage of patients followed up",
    y_axis_title = "",
    
    tooltip_1_column = "year_months",
    tooltip_1_title = "Quarter",
    
    tooltip_2_column = "nhs_health_board",
    tooltip_2_title = "Health board",
    
    tooltip_3_column = "graph_value_label",
    tooltip_3_title = "Percentage of patients followed up",
    tooltip_3_suffix = "%",
    
    graph_height = 600
  )
  
})


## Table for graph 2 ----
output$S2_2_table <- renderDataTable({
  datatable(
    S2_plot2_data_for_table() %>% 
      # Add "NA" as a value to table on dashboard:
      mutate(across(number_of_patients_followed_up:total_number_of_discharged_patients, ~replace(., is.na(.), "NA"))) %>% 
      # Add % sign to percentage variable:
      mutate(percentage_followed_up = if_else(is.na(percentage_followed_up),
                                              "NA",
                                              paste0(percentage_followed_up, "%"))) %>% 
      # Add commas to large values but keep "NA" or "*" character values (values are all currenlty under 1000 so don't need this yet):
      mutate(total_number_of_discharged_patients = if_else(!grepl("\\D", total_number_of_discharged_patients), 
                                                           format(as.numeric(total_number_of_discharged_patients), 
                                                                  big.mark = ",", trim = T), 
                                                           total_number_of_discharged_patients)),
    style = 'bootstrap', 
    class = 'table_bordered table-condensed',
    rownames = FALSE, 
    options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip', 
                   # Right align numeric columns - it's columns 3:5 but use 2:4 as rownames = FALSE
                   columnDefs = list(list(className = 'dt-right', targets = 2:4))), 
    colnames = c("Health Board", 
                 "Quarter", 
                 "Number of Patients Followed Up", 
                 "Total Number of Discharged Patients", 
                 "Percentage (%) Followed Up")
  )
})


## Graph 2 data download button ----
# Allows users to the download tables in .csv format
output$S2_2_table_download <- downloadHandler(
  filename = 'S2 - Discharges followed up for chosen quarter.csv', 
  content = function(file) {
    write.table(S2_plot2_data_for_table(), 
                file, 
                row.names = FALSE, 
                col.names = c("Health Board", 
                              "Quarter", 
                              "Number of Patients Followed Up", 
                              "Total Number of Discharged Patients", 
                              "Percentage (%) Followed Up"), 
                sep = ",")
    
  }
)



# Graph 3 - by HB - Total discharged and number followed up ---- 

## Picker 1 - for user selecting Health Board  ----

output$S2_Plot3_hbName_output <- renderUI({
  shinyWidgets::pickerInput(
    "S2_Plot3_hbName",
    label = "Select health board:",
    choices = sort(unique(as.character(S2_data$nhs_health_board))),
    selected = "NHS Ayrshire & Arran"
  )
})


## Selecting appropriate data for graph and table 3 ----
#Need to do both as we need Numeric columns pivoted in graph and Character columns not pivoted in table.

S2_plot3_data_for_graph <- reactive({
  S2_pivoted_data %>%
    filter(nhs_health_board %in% input$S2_Plot3_hbName) 
})


S2_plot3_data_for_table <- reactive({
  S2_data %>%
    filter(nhs_health_board %in% input$S2_Plot3_hbName) %>%
    select(!c("year_quarter", "year"))
})

## Graph 3 title ----
output$S2_plot3_title <- renderUI({
  
  req(input$S2_Plot3_hbName)
  
  paste0("Total number of psychiatric inpatients discharged and number followed up ",
         "by community mental health services within 7 calendar days, by calendar quarter, ",
         "in ", input$S2_Plot3_hbName)
})


## Create graph 3 - line graph ----

### Render plotly ----
output$S2_plot3 <- renderPlotly({
  
  selected_hbs <- input$S2_Plot3_hbName
  
  # Create any notes required for the selected boards
  notes <- character(0)
  
  if ("NHS Lanarkshire" %in% selected_hbs) {
    notes <- c(
      notes,
      "Data are not available for NHS Lanarkshire."
    )
  }
  
  if (any(c("NHS Orkney", "NHS Shetland") %in% selected_hbs)) {
    notes <- c(
      notes,
      "Data are not available due to small numbers."
    )
  }
  
  annotation_text <- paste(notes, collapse = "<br>")
  
  # Create the two-line trend plot
  S2_plot3_plotly <- create_trend_plot(
    data = S2_plot3_data_for_graph(),
    
    x_column = "year_months",
    y_column = "number",
    
    # This creates one line for each value in total_or_followed_up
    group_column = "total_or_followed_up",
    
    x_axis_title = "Quarter",
    y_axis_title = "Number of patients",
    
    tooltip_value_title = "Number",
    tooltip_suffix = "",
    
    graph_height = 600
  )
  
  # Add chart-specific note in the centre
  if (nzchar(annotation_text)) {
    
    S2_plot3_plotly <- S2_plot3_plotly %>%
      plotly::layout(
        annotations = list(
          list(
            text = annotation_text,
            x = 0.5,
            y = 0.5,
            xref = "paper",
            yref = "paper",
            xanchor = "center",
            yanchor = "middle",
            align = "center",
            showarrow = FALSE,
            font = list(
              size = 14,
              color = "#333333"
            ),
            bgcolor = "rgba(255,255,255,0.85)"
          )
        )
      )
  }
  
  S2_plot3_plotly
})


## Table for graph 3 ----
output$S2_3_table <- renderDataTable({
  datatable(
    S2_plot3_data_for_table() %>% 
      # Add "NA" as a value to table on dashboard:
      mutate(across(number_of_patients_followed_up:total_number_of_discharged_patients, 
                    ~replace(., is.na(.), "NA"))) %>% 
      # Add % sign to percentage variable:
      mutate(percentage_followed_up = if_else(is.na(percentage_followed_up),
                                              "NA",
                                              paste0(percentage_followed_up, "%"))) %>% 
      # Add commas to large values but keep "NA" or "*" character values (values are all currenlty under 1000 so don't need this yet):
      mutate(total_number_of_discharged_patients = if_else(!grepl("\\D", total_number_of_discharged_patients), 
                                                           format(as.numeric(total_number_of_discharged_patients), 
                                                                  big.mark = ",", trim = T), 
                                                           total_number_of_discharged_patients)),
    style = 'bootstrap', 
    class = 'table_bordered table-condensed',
    rownames = FALSE, 
    options = list(
      pageLength = 16, 
      autoWidth = FALSE, 
      dom = 'tip', 
      # Right align numeric columns - it's columns 3:5 but use 2:4 as rownames = FALSE
      columnDefs = list(list(className = 'dt-right', targets = 2:4))), 
    colnames = c("Health Board", 
                 "Quarter",
                 "Number of Patients Followed Up", 
                 "Total Number of Discharged Patients", 
                 "Percentage (%) Followed Up")
  )
})


## Graph 3 data download button ----
# Allows users to the download tables in .csv format
output$S2_3_table_download <- downloadHandler(
  filename = 'S2 - Discharges followed up for chosen health board and year.csv', 
  content = function(file) {
    write.table(S2_plot3_data_for_table(), 
                file, 
                row.names = FALSE, 
                col.names = c("Health Board", 
                              "Quarter", 
                              "Number of Patients Followed Up", 
                              "Total Number of Discharged Patients", 
                              "Percentage (%) Followed Up"), 
                sep = ",")
    
  }
)