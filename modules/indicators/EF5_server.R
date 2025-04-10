#### [ EF5 - 'Did Not Attend' appointments - Server ] ----

## Two graphs:
## HB trend graph - user can select multiple health boards to compare a single measure
## HB measures graph - user can select one health board to compare both 'number of' measures
## - % measure is included in the data table under graph

### [ EF5 Health Board Trends ] ----

## Health Board selector ---- (multiple)
output$EF5_trendPlot_hbName_output <- renderUI({
   shinyWidgets::pickerInput(
      "EF5_trendPlot_hbName",
      label = "Select NHS Health Board(s) (Maximum 4):",
      choices = EF5_hb_names,
      multiple = TRUE,
      options = list("max-options" = 4,
                     `selected-text-format` = "count > 1"),
      # No Scotland data on this one
      selected = "NHS Ayrshire & Arran"
      )
})

## Measure selector ---- (single)
output$EF5_trendPlot_measure_ouput <- renderUI({
  shinyWidgets::pickerInput(
    "EF5_trendPlot_measure",
    label = "Select measure to visualise:",
    choices = EF5_trend_measures,
    selected = "Percentage 'Did Not Attend' appointments"
    )
})


## Graph Data Reactive ---- 
# to create graph data based on HB selection
EF5_trendPlot_data <- reactive({
   EF5_data %>%
      filter(hb_name %in% input$EF5_trendPlot_hbName
             & measure %in% input$EF5_trendPlot_measure)
})


# Create the EF5 line chart ----

### Render plotly ----

output$EF5_trendPlot <- renderPlotly({ 
   
     ## Plotly version of graph ----
     plot_ly(data = EF5_trendPlot_data(),
             
       x = ~year_months, y = ~value, color = ~hb_name,
       
       # Tooltip text
       text = paste0("Location: ",
                     EF5_trendPlot_data()$hb_name,
                     "<br>",
                     "Calendar Quarter: ",
                     EF5_trendPlot_data()$year_months,
                     "<br>",
                     EF5_trendPlot_data()$measure,": ", EF5_trendPlot_data()$value),
       hoverinfo = "text",
       
       # Line aesthetics=
       type = 'scatter', mode = 'lines+markers',
       line = list(width = 3),
                   # Setting line colours - does not work
                   # color = c("#3F3685", "#9B4393", "#0078D4", "#1E7F84")),
       linetype = ~hb_name,
       linetypes = c("solid", "dot", "solid", "dot"),
       symbol = ~hb_name, 
       symbols = c("circle", "square", "triangle-up", "triangle-down"),
       marker = list(size = 12),
       # Size of graph
       # width = 1000, 
       height = 600,
       # Legend info
       name = ~str_wrap(hb_name, 15)) %>%
       
       layout(title = str_wrap(paste0("<b>",
                             input$EF5_trendPlot_measure, " in selected health boards, ", 
                             # first(EF5_trendPlot_data()$year_months)," to ", last(EF5_trendPlot_data()$year_months),
                             " by calendar quarter.", "</b>"), 54),
              yaxis = list(
                exponentformat = "none",
                separatethousands = TRUE,
                range = c(0, max(EF5_trendPlot_data()$value, na.rm = TRUE) * 110 / 100), 
                
                # Wrap the y axis title in spaces so it doesn't cover the...
                # tick labels.
                title = list(font = list(size = 13)),
                paste0(c(rep("&nbsp;", 20),
                         print(c(input$EF5_trendPlot_measure)), 
                         rep("&nbsp;", 20),
                         rep("\n&nbsp;", 3)
                ), 
                collapse = ""),
                showline = TRUE, 
                ticks = "outside"
              ),
              
              # Create diagonal x-axis ticks
              xaxis = list(tickangle = -45, 
                           title = paste0(c(rep("&nbsp;", 20),
                                            "<br>",
                                            "<br>",
                                            "Calendar year",
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
              displaylogo = F, editable = F)
     
   })
   

     
   #   ## ggplot2 version of graph run through ggplotly
   #   EF5_trendPlot_graph <- reactive ({
   #   # ggplotly tooltip information
   #   ggplot(data = EF5_trendPlot_data(),
   #          aes(x = year_months,
   #              y = value,
   #              text = paste0("Location: ",
   #                            EF5_trendPlot_data()$hb_name,
   #                            "<br>",
   #                            "Calendar Quarter: ",
   #                            EF5_trendPlot_data()$year_months,
   #                            "<br>",
   #                            EF5_trendPlot_data()$measure,": ", EF5_trendPlot_data()$value))) +
   #     geom_line() +
   #     geom_point(size = 2.5) +
   #     aes(group = hb_name,
   #         linetype = hb_name,
   #         color = hb_name,   # Have to do this outside so that the legends shows and so that there aren't 3 legends
   #         shape = hb_name) +
   #     # Adding PHS accessibility colour scheme for lines
   #     scale_color_discrete_phs(name = "", 
   #                              palette = "main-blues",
   #                              labels = ~ stringr::str_wrap(.x, width = 15)) +
   #     scale_linetype_manual(name = "",
   #                           values = c("solid", "dashed", "solid", "dashed"),
   #                           labels = ~ stringr::str_wrap(.x, width = 15)) +
   #     scale_shape_manual(name = "", 
   #                        values = c("circle", "square", "triangle-up", "triangle-down"), 
   #                        labels = ~ stringr::str_wrap(.x, width = 15)) +
   #     theme_classic() +                         # I normally use bw but will see what this looks like (de-clutters graph background)
   #     theme(
   #       # Set legend position to bottom and remove legend title
   #       legend.position = "bottom", 
   #       # legend.title = element_blank(),
   #       legend.text = element_text(size = 8, 
   #                                  colour = "black"),
   #       # panel.grid.major.x = element_line(),  # Shows vertical grid lines 
   #       panel.grid.major.y = element_line(),  # Shows horizontal grid lines 
   #       axis.title.x = element_text(size = 12,
   #                                   color = "black",
   #                                   face = "bold"),
   #       axis.text.x = element_text(angle = 25),
   #       axis.title.y = element_text(size = 12,
   #                                   color = "black",
   #                                   face = "bold")
   #        
   #       # legend.title = element_text(size = 9, 
   #       #                             colour = "black", 
   #       #                             face = "bold")
   #       ) +  
   #     labs(x = "\n Calendar Quarter", 
   #          y = paste0(str_wrap(input$EF5_trendPlot_measure, width = 30), "\n \n")) +
   #     scale_y_continuous(expand = c(0, 0),   # Ensures y axis starts from zero (important for Orkney and Shetland HBs which are all zero)
   #                        limits = c(0, (max(EF5_trendPlot_data()$value) + 0.5*max(EF5_trendPlot_data()$value)))) 
   #   # change to 1.2*max
   #   
   # })
            
   
   # ### Run ggplot graph through plotly ----
   # 
   # ggplotly(EF5_trendPlot_graph(),
   #          tooltip = "text") %>%        # uses text set up in ggplot aes above.
   #   # Needed to set the legend below the graph with ggplotly
   #   layout(legend = list(orientation = "h", x = 0.0, y = -0.4)) %>% 
   # ### Remove unnecessary buttons from the modebar ----
   # config(displayModeBar = TRUE,
   #        modeBarButtonsToRemove = bttn_remove,
   #        displaylogo = F, editable = F)
   # })


### Table below graph ----

output$EF5_trendPlot_table <- renderDataTable({
   datatable(EF5_trendPlot_data(),
             style = 'bootstrap',
             class = 'table-bordered table-condensed',
             rownames = FALSE,
             options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
             colnames = c("Calendar Quarter",
                          "Health Board",
                          EF5_trendPlot_measure))
})

# Create download button that allows users to download tables in .csv format.
output$EF5_trendPlot_table_download <- downloadHandler(
   filename = 'EF5 - Did not attend.csv',
   content = function(file) {
      write.table(EF5_trendPlot_data(),
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("Calendar Quarter",
                          "Health Board",
                          EF5_trendPlot_measure),
                  sep = ",")
      })


### [ EF5 Health Board Measures ] ----

## Health Board selector ---- (single)
output$EF5_measurePlot_hbName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EF5_measurePlot_hbName",
    label = "Select NHS Health Board:",
    choices = EF5_hb_names,
    # No Scotland data on this one
    selected = "NHS Ayrshire & Arran")
})


## Graph measure Data Reactive ----
# to create graph data based on HB selection
EF5_measurePlot_data <- reactive({
  EF5_measure_data %>%
    filter(hb_name %in% input$EF5_measurePlot_hbName)
})


## Create the EF5 bar chart ----
# This code creates a plot of the number of appointment measures and will let 
# the user choose which Health Baords to display.
# The table below the graph will have the percentage figure as well for reference
### Render plotly ----

output$EF5_measurePlot <- renderPlotly({

  ### Create reactive ggplot graph ----

  EF5_measurePlot_graph <- reactive ({

    # ggplotly tooltip information
    ggplot(data = EF5_measurePlot_data(),
           aes(x = year_months,
               y = value,
               fill = measure,
               text = paste0("Location: ",
                             EF5_measurePlot_data()$hb_name,
                             "<br>",
                             "Calendar Quarter: ",
                             EF5_measurePlot_data()$year_months,
                             "<br>",
                             EF5_measurePlot_data()$measure,": ", EF5_measurePlot_data()$value))) +

      # Number based measures as bar chart
      geom_bar(position="dodge", stat="identity") +
      aes(group = measure #,
          # color = measure   # Have to do this outside so that the legends shows and so that there aren't 3 legends
          ) +
      # Adding PHS accessibility colour scheme for lines
      scale_color_discrete_phs(name = "Measure", 
                               palette = "main-blues",
                               labels = ~ stringr::str_wrap(.x, width = 15)) +

      theme_classic() + 
      theme(panel.grid.major.y = element_line(),  # Shows horizontal grid lines
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
           y = "Number of Days \n") +
      scale_y_continuous(expand = c(0, 0),   # Ensures y axis starts from zero (important for Orkney and Shetland HBs which are all zero)
                         limits = c(0, (max(EF5_measurePlot_data()$value) + 0.5*max(EF5_measurePlot_data()$value))))

    })

  ### Run ggplot graph through plotly ----

  ggplotly(EF5_measurePlot_graph(),
           tooltip = "text") %>%        # uses text set up in ggplot aes above.
    ### Remove unnecessary buttons from the modebar ----
  config(displayModeBar = TRUE,
         modeBarButtonsToRemove = bttn_remove,
         displaylogo = F, editable = F)
})


### Table below EF5 HB measure graph ----

## Table Data Reactive ----
# to create graph data based on HB selection
EF5_measurePlot_tableData <- reactive({
  EF5_data %>%
    filter(hb_name %in% input$EF5_measurePlot_hbName)
})

# Table data output
output$EF5_measurePlot_table <- renderDataTable({
  datatable(EF5_measurePlot_tableData(),
            style = 'bootstrap',
            class = 'table-bordered table-condensed',
            rownames = FALSE,
            options = list(pageLength = 16, autoWidth = FALSE, dom = 'tip'),
            colnames = c("Calendar Quarter",
                         "Health Board",
                         "XX Value XX"))
})

# Create download button that allows users to download tables in .csv format.
output$EF5_measure_table_download <- downloadHandler(
  filename = 'EF5 - Did not attend - health board measures.csv',
  content = function(file) {
    write.table(EF5_measurePlot_data(),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Calendar Quarter",
                              "Health Board",
                              "XX Value XX"),
                sep = ",")
  })