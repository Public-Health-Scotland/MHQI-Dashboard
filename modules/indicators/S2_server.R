# S2 Trends Plot(s) ----


# Graph 1 - Comparing health boards % over time ---- 

## Picker for user selecting specific health board ---- 

output$S2_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "S2_trendPlot_hbName",
      label = "Select NHS health board (Maximum 4):",
      choices = sort(unique(as.character(S2_data$nhs_health_board))),
      multiple = TRUE,
      options = list("max-options" = 4,
                     `selected-text-format` = "count > 1"),
      selected = "NHS Ayrshire & Arran")
   })



## Graph Data Reactive ---- 
# to create graph data based on HB selection
S2_trendPlot_data <- reactive({
   S2_data %>%
      select(!c("year_quarter", "year")) %>% 
      filter(nhs_health_board %in% input$S2_trendPlot_hbName)
})


## Create the S2 line chart ----

### Render plotly ----

output$S2_trendPlot <- renderPlotly({ 
   
   ### Create reactive ggplot graph ----
   
   S2_plot_graph1 <- reactive ({
      
      ggplot(data = S2_trendPlot_data(), 
             aes(x = year_months, 
                 y = percentage_followed_up,  
                 text = paste0("Calendar quarter: ",
                               S2_trendPlot_data()$year_months,
                               "<br>",
                               "Health board: ",
                               S2_trendPlot_data()$nhs_health_board,
                               "<br>",
                               "Percentage followed up: ",
                               S2_trendPlot_data()$percentage_followed_up, "%"))) + # for tooltip in ggplotly - shows values on hover
         geom_line() +
         geom_point(size = 2.5) +
         aes(group = nhs_health_board,
             linetype = nhs_health_board,
             color = nhs_health_board,   # Have to do this outside so that the legends shows and so that there aren't 3 legends
             shape = nhs_health_board) +
         scale_color_discrete_phs(name = "Health board", 
                                  palette = "main-blues",
                                  labels = ~ stringr::str_wrap(.x, width = 15)) +
         # scale_color_manual(name = "Area name", 
         #                    values = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"),
         #                    labels = ~ stringr::str_wrap(.x, width = 15)) +
         scale_linetype_manual(name = "Health board", 
                               values = c("solid", "dashed", "solid", "dashed"),
                               labels = ~ stringr::str_wrap(.x, width = 15)) +
         scale_shape_manual(name = "Health board", 
                            values = c("circle", "square", "triangle-up", "triangle-down"), 
                            labels = ~ stringr::str_wrap(.x, width = 15)) +
         theme_classic() +                            # de-clutters graph background
         theme(panel.grid.major.x = element_line(),  # Shows vertical grid lines 
               panel.grid.major.y = element_line(),  # Shows horizontal grid lines 
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
         labs(x = "\n Calendar Quarter", 
              y = "Percentage (%)") +
         scale_y_continuous(expand = c(0, 0),   # Ensures y axis starts from zero (important as some are zero or NA)
                            limits = c(0, 101))
   })
   
   ### Run ggplot graph through plotly ----
   
   ggplotly(S2_plot_graph1(),
            tooltip = "text") %>%        # uses text set up in ggplot aes above. 
      ### Remove unnecessary buttons from the modebar ----
   config(displayModeBar = TRUE,
          modeBarButtonsToRemove = bttn_remove,
          displaylogo = F, editable = F)
   
})


### Table below graph ----

output$S2_1_table <- renderDataTable({
   datatable(S2_trendPlot_data(),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("Health Board",
                          "Calendar Quarter",
                          "Number of Patients Followed Up", 
                          "Total Number of Discharged Patients", 
                          "Percentage Followed Up (%)"))
})

# Create download button that allows users to download tables in .csv format.
output$S2_1_table_download <- downloadHandler(
   filename = 'S2 - Discharge followed up for chosen health boards.csv',
   content = function(file) {
      write.table(S2_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Health Board",
                                "Calendar Quarter",
                                "Number of Patients Followed Up", 
                                "Total Number of Discharged Patients", 
                                "Percentage Followed Up (%)"),
                  sep = ",")
   })



# S2 Graph - option 2 - All HBs percentages by Quarter ---- 


## Picker for user selecting Quarter ----

output$S2_plot2_quarter_output <- renderUI({
   shinyWidgets::pickerInput(
      "S2_plot2_quarter",
      label = "Select calendar quarter:",
      choices = unique(S2_data$year_months),
      selected = "OCt-Dec 2024")
})

## Selecting appropriate data for graph 2 ---- 

S2_plot2_data <- reactive({
   S2_data %>%
      select(nhs_health_board, year_months, number_of_patients_followed_up, 
             total_number_of_discharged_patients, percentage_followed_up) %>%
      filter(year_months %in% input$S2_plot2_quarter) %>% 
      mutate(nhs_health_board = fct_reorder(nhs_health_board, percentage_followed_up, # for ordering by percentage
                                            .na_rm = FALSE))     # required or crashes
})   

## Create the bar chart ----

### Render plotly ----

output$S2_plot2 <- renderPlotly({
   
   ### Create reactive ggplot graph ----
   
   S2_plot2_graph <- reactive({
      ggplot(S2_plot2_data(),  
             aes(x = percentage_followed_up, 
                 y = nhs_health_board,  
                 fill = nhs_health_board,
                 # for tooltip in ggplotly - shows values on hover:
                 text = paste0("Calendar quarter: ", S2_plot2_data()$year_months, 
                               "<br>",
                               "Health board: ", S2_plot2_data()$nhs_health_board,
                               "<br>",
                               "Percentage of patients followed up: ", S2_plot2_data()$percentage_followed_up, "%")
             )) + 
         geom_bar(stat = "identity",      # bars separated from each other
                  fill = "#0078D4",       # phs blue = #0078D4 
                  na.rm = FALSE) +   
         geom_text(aes(label = if_else(is.na(percentage_followed_up), 
                                       "NA", "")),   # "value" shown on graph is "NA" for NAs, no text for HBs with values 
                   na.rm = FALSE, 
                   nudge_x = 2,     # Moves "NA" along x axis. Only see part of "NA" e.g. just "A" otherwise 
                   size = 4) +         
         theme_classic() +                         
         theme(panel.grid.major.x = element_line(),  # Shows vertical grid lines 
               panel.grid.major.y = element_line(),  # Shows horizontal grid lines 
               axis.title.x = element_text(size = 12,
                                           color = "black",
                                           face = "bold"),
               axis.title.y = element_blank(), 
               legend.position = "none") +           # removes legend 
         labs(x = paste0("Percentage (%) of patients followed up within 7 days: ", S2_plot2_data()$year_months), 
              y = NULL) +
         scale_x_continuous(na.value = 0,       # required for adding "NA" value to graph
                            limits = c(0, 100),
                            n.breaks = 10,
                            expand = c(0, 0))  # remove spacing between hb names on y axis and 0% on x axis
   })
   
   ### Run graph 2 through plotly ----
   ggplotly(S2_plot2_graph(), 
            # uses text set up in ggplot aes above:
            tooltip = "text") %>%    
   ### Remove unnecessary buttons from the modebar ----
   config(displayModeBar = TRUE,
          modeBarButtonsToRemove = bttn_remove,
          displaylogo = F, editable = F)
   
})


## Table for graph 2 ----


output$S2_2_table <- renderDataTable({
   datatable(
      S2_plot2_data(), 
      style = 'bootstrap', 
      class = 'table_bordered table-condensed',
      rownames = FALSE, 
      options = list(
         pageLength = 16, 
         autoWidth = FALSE, 
         dom = 'tip'
      ), 
      colnames = c("Health Board", 
                   "Calendar Quarter", 
                   "Number of Patients Followed Up", 
                   "Total Number of Discharged Patients", 
                   "Percentage (%) Followed Up")
      )
   })


## Graph 2 data download button ----
# Allows users to the download tables in .csv format ----
output$S2_2_table_download <- downloadHandler(
   filename = 'S2 - Discharges followed up for chosen quarter.csv', 
   content = function(file) {
      write.table(S2_plot2_data(), 
                  file, 
                  row.names = FALSE, 
                  col.names = c("Health Board", 
                                "Calendar Quarter", 
                                "Number of Patients Followed Up", 
                                "Total Number of Discharged Patients", 
                                "Percentage (%) Followed Up"), 
                  sep = ",")
      
   }
)






# Graph option 3 - TESTING-  bar chart by HB, for 4 quarters(year), total discharged and number followed up ---- 

## Picker 1 - for user selecting Health Board  ----

output$S2_Plot3_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "S2_Plot3_hbName",
      label = "Select health board:",
      choices = sort(unique(as.character(S2_data$nhs_health_board))),
      selected = "NHS Ayrshire & Arran"
   )
})

## Picker 2 - for user selecting up to 2 years ---- 
output$S2_Plot3_year_output <- renderUI({
   shinyWidgets::pickerInput(
      "S2_Plot3_year",
      label = "Select calendar year (Maximum 3):",
      choices = sort(unique(as.character(S2_data$year))),
      multiple = TRUE, 
      options = list("max-options" = 3, 
                     `selected-text-format` = "count >1"),
      selected = 2024)
})


## Selecting appropriate data for graph and table 3 ---- 
#Need to do both as we need Numeric columns pivoted in graph and Character columns not pivoted in table. 

S2_plot3_data_for_graph <- reactive({
   S2_data %>%
      select(nhs_health_board, year_months, year, number_of_patients_followed_up, 
             total_number_of_discharged_patients) %>%
      tidyr::pivot_longer(cols = c("number_of_patients_followed_up", "total_number_of_discharged_patients"),
                          names_to = "total_or_followed_up",
                          values_to = "number",
                          values_drop_na = FALSE) %>% 
      mutate(number = as.double(number)) %>% 
      filter(nhs_health_board %in% input$S2_Plot3_hbName) %>% 
      filter(year %in% input$S2_Plot3_year)
})   


S2_plot3_data_for_table <- reactive({
   S2_data %>%
      filter(nhs_health_board %in% input$S2_Plot3_hbName) %>% 
      filter(year %in% input$S2_Plot3_year) %>% 
      select(!c("year_quarter"))
})   

## Create the bar chart ----

### Render plotly ----

output$S2_plot3 <- renderPlotly({
   
   ### Create reactive ggplot graph ----
   
   S2_plot3_graph <- reactive({
      ggplot(S2_plot3_data_for_graph(),  
             aes(x = year_months, 
                 y = number,  
                 fill = total_or_followed_up, 
                 group = total_or_followed_up,
                 text = paste0("Calendar quarter: ", S2_plot3_data_for_graph()$year_months,        # for tooltip in ggplotly - shows values on hover
                                "<br>",
                               "NHS health board: ", S2_plot3_data_for_graph()$nhs_health_board,
                               "<br>",
                               case_when(total_or_followed_up == "number_of_patients_followed_up" ~ 
                                            paste0("Number of patients followed up: ", S2_plot3_data_for_graph()$number), 
                                         total_or_followed_up == "total_number_of_discharged_patients" ~
                                            paste0("Total number of patients discharged: ", S2_plot3_data_for_graph()$number), 
                                         TRUE ~ "No Data")))
             ) +
         geom_bar(position = "dodge", 
                  stat = "identity",      # bars separated from each other
                  na.rm = FALSE) +
         geom_text(aes(label = if_else(is.na(number), 
                                       "NA", "")), # "value" shown on graph is "NA" for NAs, no text for HBs with values
                   na.rm = FALSE, 
                   nudge_y = 3,
                   size = 4) +
         scale_fill_manual(values = c("#9B4393",
                                      "#0078D4"), # phs blue = #0078D4  magenta = "#9B4393"
                           labels = c("Number of patients followed up", 
                                      "Total number of patients")) +
         theme_classic() +                         
         theme(panel.grid.major.x = element_line(),  
               panel.grid.major.y = element_line(),  
               axis.title.x = element_text(size = 12,
                                           color = "black",
                                           face = "bold"),
               axis.text.x = element_text(angle = 25),
               legend.position = "bottom") +        
         labs(x = paste0("Calendar year: ", S2_plot3_data_for_graph()$year), 
              y = "Number of Patients", 
              fill = NULL) +
         scale_y_continuous(na.value = 0,  # required for adding "NA" value to graph
                            #limits = c(0, 150), 
                            n.breaks = 10,
                            expand = c(0,0))  # remove spacing between dates on x axis and 0  on y axis
   })
   
   
   
   
   ### Run graph 3 through plotly ----
   ggplotly(S2_plot3_graph(), 
            tooltip = "text") %>%     # uses text set up in ggplot aes above. 
      ### Remove unnecessary buttons from the modebar ----
   config(displayModeBar = TRUE,
          modeBarButtonsToRemove = bttn_remove,
          displaylogo = F, editable = F)
   
})


## Table for graph 3 ----


output$S2_3_table <- renderDataTable({
   datatable(
      S2_plot3_data_for_table(), 
      style = 'bootstrap', 
      class = 'table_bordered table-condensed',
      rownames = FALSE, 
      options = list(
         pageLength = 16, 
         autoWidth = FALSE, 
         dom = 'tip'
      ), 
      colnames = c("Health Board", 
                   "Calendar Quarter", 
                   "Year",
                   "Number of Patients Followed Up", 
                   "Total Number of Discharged Patients", 
                   "Percentage (%) Followed Up")
   )
})


## Graph 3 data download button ----
# Allows users to the download tables in .csv format ----
output$S2_3_table_download <- downloadHandler(
   filename = 'S2 - Discharges followed up for chosen health board and year.csv', 
   content = function(file) {
      write.table(S2_plot3_data_for_table(), 
                  file, 
                  row.names = FALSE, 
                  col.names = c("Health Board", 
                                "Calendar Quarter", 
                                "Year",
                                "Number of Patients Followed Up", 
                                "Total Number of Discharged Patients", 
                                "Percentage (%) Followed Up"), 
                  sep = ",")
      
   }
)