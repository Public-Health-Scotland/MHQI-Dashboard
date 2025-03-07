# S5 Trends Plot(s) ----

# Graph 1 - comparing health boards over time ----

## Picker for user selecting specific health board ---- 

output$S5_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "S5_trendPlot_hbName",
      label = "Select NHS health board (Maximum 4):",
      choices = sort(unique(as.character(S5_data$nhs_health_board))),
      multiple = TRUE,
      options = list("max-options" = 4,
                     `selected-text-format` = "count > 1"),
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

### Render plotly ----

output$S5_trendPlot <- renderPlotly({ 
   
   ### Create reactive ggplot graph ----
   
   S5_plot_graph <- reactive ({
      
      ggplot(data = S5_trendPlot_data(), 
             aes(x = year_months, 
                 y = incidents_per_1000_bed_days,  
                 # for tooltip in ggplotly - shows values on hover:
                 text = paste0("Calendar quarter: ",                
                               S5_trendPlot_data()$year_months, 
                               "<br>",
                               "Health board: ",
                               S5_trendPlot_data()$nhs_health_board,
                               "<br>",
                               "Incidents per 1,000 bed days: ",
                               S5_trendPlot_data()$incidents_per_1000_bed_days))) + 
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
              y = "Incidents per 1,000 occupied bed days") +
         scale_y_continuous(expand = c(0, 0),   # Ensures y axis starts from zero (important as some are zero or NA)
                            limits = c(0, 100)  # NOTE THAT THIS NEEDS TO BE FLUID - TRYING BELOW - as some hb's quarters are near 100 (Western Isles
                            # Below is not yet working, probably due to NAs?:
                            # limits = c(0, (max(S5_data$incidents_per_1000_bed_days) + 9)), # Keeps the y-axis the same length for all graphs, ranges from 0 to the max value plus 9 so that the last tick can be seen
                            # breaks = seq(0, (max(S5_data$incidents_per_1000_bed_days) + 9), by = 10))   # y-axis ticks range from 0 to the max value + 9, showing increments of 10
         )
   })
   

   ### Run ggplot graph through plotly ----
   
   ggplotly(S5_plot_graph(),
            # uses text set up in ggplot aes above:
            tooltip = "text") %>%         
      ### Remove unnecessary buttons from the modebar ----
   config(displayModeBar = TRUE,
          modeBarButtonsToRemove = bttn_remove,
          displaylogo = F, editable = F)
   
   
})



## Table below graph 1 ----

output$S5_1_table <- renderDataTable({
   datatable(S5_trendPlot_data(),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("NHS Health Board",
                          "Calendar Quarter",
                          "Number of Incidents", 
                          "Total Occupied Psychiatric Bed Days", 
                          "Incidents per 1,000 Bed Days"))
})

## Table 1 download button ---- 
# Create download button that allows users to download tables in .csv format.
output$S5_table_download <- downloadHandler(
   filename = 'S5 - Incidences of physical violence.csv',
   content = function(file) {
      write.table(S5_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("NHS Health Board",
                                "Calendar Quarter",
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
      label = "Select calendar quarter:",
      choices = unique(S5_data$year_months),
      selected = "Jul-Sep 2024")
})

## Selecting appropriate data for graph 2 ---- 

S5_plot2_data <- reactive({
   S5_data %>%
      select(!c("year_quarter", "year")) %>%  
      filter(year_months %in% input$S5_plot2_quarter) %>% 
      # for ordering by value:
      mutate(nhs_health_board = fct_reorder(nhs_health_board, incidents_per_1000_bed_days, 
                                            .na_rm = FALSE)) # This row is required or crashes
 })   


## Create the bar chart ----

### Render plotly ----

output$S5_plot2 <- renderPlotly({
   
   ### Create reactive ggplot graph ----
   
   S5_plot2_graph <- reactive({
      ggplot(S5_plot2_data(),  
             aes(x = incidents_per_1000_bed_days, 
                 y = nhs_health_board,  
                 fill = nhs_health_board,
                 # for tooltip in ggplotly - shows values on hover:
                 text = paste0("Calendar quarter: ", S5_plot2_data()$year_months,        
                               "<br>",
                               "Health board: ", S5_plot2_data()$nhs_health_board,
                               "<br>",
                               "Incidents per 1,000 occupied bed days: ", S5_plot2_data()$incidents_per_1000_bed_days)
             )) + 
         geom_bar(stat = "identity",      # bars separated from each other
                  fill = "#0078D4",       # phs blue = #0078D4 
                  na.rm = FALSE) +   
         geom_text(aes(label = if_else(is.na(incidents_per_1000_bed_days), 
                                       "NA", "")),   # "value" shown on graph is "NA" for NAs, no text for HBs with values 
                   na.rm = FALSE, 
                   nudge_x = 1,     # NA only shows as "A" without this 
                   size = 4) +         
         theme_classic() +                         
         theme(panel.grid.major.x = element_line(),  # Shows vertical grid lines 
               panel.grid.major.y = element_line(),  # Shows horizontal grid lines 
               axis.title.x = element_text(size = 12,
                                           color = "black",
                                           face = "bold"),
               axis.title.y = element_blank(), 
               legend.position = "none") +           # removes legend 
         labs(x = paste0("Incidents per 1,000 bed days: ", S5_plot2_data()$year_months), 
              y = NULL) +
         
         # Not yet all working
         scale_x_continuous(na.value = 0,  # required for adding "NA" value to graph
                            # Below not yet working. Because of NAs? 
                            # limits = c(0, (max(S5_data$incidents_per_1000_bed_days) + 9)),# Keeps the x-axis the same length for all graphs, ranges from 0 to the max value plus 9 so that the last tick can be seen
                            # breaks = seq(0, (max(S5_data$incidents_per_1000_bed_days) + 9), by = 10),  # x-axis ticks range from 0 to the max value + 9, showing increments of 10
                            limits = c(0, 100),  # NOTE THAT THIS NEEDS TO BE FLUID ^ TRYING ABOVE as some hb's quarters are near 100 (Western Isles)
                            n.breaks = 10,
                            expand = c(0, 0))  # remove spacing between hb names on y axis and 0% on x axis
      })
                            
                            
  
   
   
   ### Run graph 2 through plotly ----
   ggplotly(S5_plot2_graph(), 
            # uses text set up in ggplot aes above:
            tooltip = "text") %>%    
   ### Remove unnecessary buttons from the modebar ----
   config(displayModeBar = TRUE,
          modeBarButtonsToRemove = bttn_remove,
          displaylogo = F, editable = F)
   
})

## Table for graph 2 ----

output$S5_2_table <- renderDataTable({
   datatable(
      S5_plot2_data(), 
      style = 'bootstrap', 
      class = 'table_bordered table-condensed',
      rownames = FALSE, 
      options = list(
         pageLength = 16, 
         autoWidth = FALSE, 
         dom = 'tip'
      ), 
      colnames = c("NHS Health Board",
                   "Calendar Quarter",
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
      write.table(S5_plot2_data(), 
                  file, 
                  row.names = FALSE, 
                  col.names = c("NHS Health Board",
                                "Calendar Quarter",
                                "Number of Incidents", 
                                "Total Occupied Psychiatric Bed Days", 
                                "Incidents per 1,000 Bed Days"), 
                  sep = ",")
      
   }
)
