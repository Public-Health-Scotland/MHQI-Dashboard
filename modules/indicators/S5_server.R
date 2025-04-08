# S5 Trends Plot(s) ----

# Two Graphs: 
# 1. HB trend graph - user selects up to 4 HBs to compare incidents per 1000 bed days over time
# 2. Measures graph for quarter - user selects calendar quarter to compare HBs incidents. 

# Tables: 
# Graphs show incidents per 1000 bed days, but tables also include "total bed days" and 
# "no. of incidents"


# S2 - Graph 1 - comparing HBs over time ---- 

## Health Board Selector ---- 
# Picker for user selecting up to 4 health boards

output$S5_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "S5_trendPlot_hbName",
      label = "Select NHS health board(s) (Maximum 4):",
      choices = S5_hb_names,  # pulled out in data_preparation.R
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

### Render plotly ----

output$S5_trendPlot <- renderPlotly({ 
  
   # Plotly version of graph 
   
   plot_ly(data = S5_trendPlot_data(), 
           
           x = ~year_months, 
           y = ~incidents_per_1000_bed_days, 
           color = ~nhs_health_board, 
           
           # Tooltip text
           text = paste0("Calendar quarter: ",                
                         S5_trendPlot_data()$year_months, 
                         "<br>",
                         "Health board: ",
                         S5_trendPlot_data()$nhs_health_board,
                         "<br>",
                         "Incidents per 1,000 bed days: ",
                         S5_trendPlot_data()$incidents_per_1000_bed_days), 
           hoverinfo = "text", 
           
           # Line aesthetics: 
           type = 'scatter',
           mode = 'lines+markers', 
           line = list(width = 3), 
           colors = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
           linetype = ~nhs_health_board, 
           linetypes = c("solid", "dashed", "solid", "dashed"),   # Note it is  "dot" rather than "dashed" in EF5
           symbol = ~nhs_health_board,
           symbols = c("circle", "square", "triangle-up", "triangle-down"),
           marker = list(size = 12),
           # Size of graph:
           # width = 1000, 
           height = 600,
           # Legend info:
           name = ~str_wrap(nhs_health_board, 15)) %>%
      
      layout(title = str_wrap(paste0("<b>", 
                                     "Incidents of violence per 1,000 bed days in selected health board(s), ", 
                                     # first(S5_trendPlot_data()$year_months)," to ", last(S5_trendPlot_data()$year_months),
                                     " by calendar quarter.", 
                                     "</b>"), 
                              54), 
             yaxis = list(exponentformat = "none",
                          separatethousands = TRUE,  # it's per 1,000 so do we need to do this? 
                          range = c(0, max(S5_trendPlot_data()$incidents_per_1000_bed_days, na.rm = TRUE) * 110 / 100), # May have to edit this, had to change na.rm = TRUE to false
                        
                        
                         # Wrap the y axis title in spaces so it doesn't cover the...
                         # tick labels.
                         title = #list(font = list(size = 13),
                            paste0(c(rep("&nbsp;", 20),
                                     print("Incidents per 1,000 occupied bed days"), 
                                     rep("&nbsp;", 20),
                                     rep("\n&nbsp;", 3)),
                                     collapse = ""),#),
                         showline = TRUE, 
                         ticks = "outside"
             ),
             
             # Create diagonal x-axis ticks
             xaxis = list(tickangle = -45, 
                          title = paste0(c(rep("&nbsp;", 20),
                                           "<br>",
                                           "<br>",
                                           "Calendar quarter",
                                           rep("&nbsp;", 20),
                                           rep("\n&nbsp;", 3)),
                                         collapse = ""),
                          showline = TRUE, 
                          ticks = "outside"),
             
             # Set the graph margins.
             margin = list(l = 90, r = 60, b = 170, t = 90),  
             
             # Set the font sizes.
             font = list(size = 13),
             
             # Add a legend so that the user knows which colour, line type...
             # and symbol corresponds to which location of treatment.
             # Make the legend background and legend border white.              
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


      ## OLD GGplot2 version of graph run through plotly ----
      ### Render plotly

      # output$S5_trendPlot <- renderPlotly({ 
      #    
      #    ### Create reactive ggplot graph
      #    
      #    S5_plot_graph <- reactive ({
      #       
      #       ggplot(data = S5_trendPlot_data(), 
      #              aes(x = year_months, 
      #                  y = incidents_per_1000_bed_days,  
      #                  # for tooltip in ggplotly - shows values on hover:
      #                  text = paste0("Calendar quarter: ",                
      #                                S5_trendPlot_data()$year_months, 
      #                                "<br>",
      #                                "Health board: ",
      #                                S5_trendPlot_data()$nhs_health_board,
      #                                "<br>",
      #                                "Incidents per 1,000 bed days: ",
      #                                S5_trendPlot_data()$incidents_per_1000_bed_days))) + 
      #          geom_line() +
      #          geom_point(size = 2.5) +
      #          aes(group = nhs_health_board,
      #              linetype = nhs_health_board,
      #              color = nhs_health_board,   # Have to do this outside so that the legends shows and so that there aren't 3 legends
      #              shape = nhs_health_board) +
      #          scale_color_discrete_phs(name = "Health board", 
      #                                   palette = "main-blues",
      #                                   labels = ~ stringr::str_wrap(.x, width = 15)) +
      #          # scale_color_manual(name = "Area name", 
      #          #                    values = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"),
      #          #                    labels = ~ stringr::str_wrap(.x, width = 15)) +
      #          scale_linetype_manual(name = "Health board", 
      #                                values = c("solid", "dashed", "solid", "dashed"),
      #                                labels = ~ stringr::str_wrap(.x, width = 15)) +
      #          scale_shape_manual(name = "Health board", 
      #                             values = c("circle", "square", "triangle-up", "triangle-down"), 
      #                             labels = ~ stringr::str_wrap(.x, width = 15)) +
      #          theme_classic() +                            # de-clutters graph background
      #          theme(panel.grid.major.x = element_line(),  # Shows vertical grid lines 
      #                panel.grid.major.y = element_line(),  # Shows horizontal grid lines 
      #                axis.title.x = element_text(size = 12,
      #                                            color = "black",
      #                                            face = "bold"),
      #                axis.text.x = element_text(angle = 25),
      #                axis.title.y = element_text(size = 12,
      #                                            color = "black",
      #                                            face = "bold"),
      #                legend.text = element_text(size = 8, 
      #                                           colour = "black"), 
      #                legend.title = element_text(size = 9, 
      #                                            colour = "black", 
      #                                            face = "bold")) +  
      #          labs(x = "\n Calendar Quarter", 
      #               y = "Incidents per 1,000 occupied bed days") +
      #          scale_y_continuous(expand = c(0, 0),   # Ensures y axis starts from zero (important as some are zero or NA)
      #                             limits = c(0, 100)  # NOTE THAT THIS NEEDS TO BE FLUID - TRYING BELOW - as some hb's quarters are near 100 (Western Isles
      #                             # Below is not yet working, probably due to NAs?:
      #                             # limits = c(0, (max(S5_data$incidents_per_1000_bed_days) + 9)), # Keeps the y-axis the same length for all graphs, ranges from 0 to the max value plus 9 so that the last tick can be seen
      #                             # breaks = seq(0, (max(S5_data$incidents_per_1000_bed_days) + 9), by = 10))   # y-axis ticks range from 0 to the max value + 9, showing increments of 10
      #          )
      #    })
      #    
      # 
      #    ### Run ggplot graph through plotly
      #    
      #    ggplotly(S5_plot_graph(),
      #             # uses text set up in ggplot aes above:
      #             tooltip = "text") %>%         
      #       ### Remove unnecessary buttons from the modebar
      #    config(displayModeBar = TRUE,
      #           modeBarButtonsToRemove = bttn_remove,
      #           displaylogo = F, editable = F)
      #    
      #    
      # })



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
      selected = "Oct-Dec 2024")
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
                            # Trying to make limits fluid but breaks error = requires a finite number in the "to=" (is this a problem if there are NAs?):
                            limits = c(0, max(S5_data$incidents_per_1000_bed_days) + 10), # x-axis now fluid, ranges from 0 to the max value plus 10 so that the last tick can be seen (this part is not working)
                           # breaks = seq(0, (max(S5_data$incidents_per_1000_bed_days) + 10), by = 5),  # x-axis ticks range from 0 to the max value + 10, in increments of 5
                            breaks = seq(0, 150, by = 5),  # x-axis ticks range from 0 to 150 (chosen as current max is <100, will be an issue if any value is >150 in future), showing increments of 5 as most values are < 40
                            # n.breaks = 11,   # This didn't change anything
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
