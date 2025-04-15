### [ EQ1 PLOT 1 - Premature Mortality Trend ] ----

## Picker for selecting HB or CA ----

output$EQ1_plot1_areaType_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot1_areaType",
    label = "Select type of geography:",
    choices = unique_area_types,
    selected = "Health board"
  )
})

## Picker for user selecting specific geographies ----

output$EQ1_plot1_areaName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot1_areaName",
    label = "Select area(s) (Maximum 4):",
    choices = sort(unique(as.character(
      EQ1_data$area_name
      [EQ1_data$area_type %in% input$EQ1_plot1_areaType]
    )))
    ,
    multiple = TRUE,
    options = list(
      "max-options" = 4,
      `selected-text-format` = "count > 1"
    ),
    selected = "NHS Scotland"
  )
})

## Graph 1 title ----
output$EQ1_plot1_title <- renderUI({
  
  # Measures section
  req(input$EQ1_plot1_areaType)
  
  paste0("Premature mortality rate for mental health service patients compared ",
         "to general population in selected ", str_to_lower(input$EQ1_plot1_areaType), "(s), by financial year:")

  
})

## Selecting appropriate data for graph 1 ----

EQ1_plot1_Data <- reactive({
  EQ1_data %>%
    select(Year,
           area_type,
           area_name,
           risk_ratio,
           SMR04_Pop_Rate,
           General_Pop_Rate) %>%
    mutate(risk_ratio = round(risk_ratio, 2)) %>%      # because values are e.g., "5.239755"
    filter(area_type %in% input$EQ1_plot1_areaType
           & area_name %in% input$EQ1_plot1_areaName)
})


# Create the risk ratios line chart ----

### Render Plotly ----

output$EQ1_plot1 <- renderPlotly({
  ### Create reactive ggplot graph ----
  
  EQ1_plot1_graph <- reactive({
    ggplot(data = EQ1_plot1_Data(),
           aes(
             x = Year,
             y = risk_ratio,
             text = paste0(
               "Financial year: ",
               # for tooltip in ggplotly - shows values on hover
               EQ1_plot1_Data()$Year,
               "<br>",
               "Area of residence: ",
               EQ1_plot1_Data()$area_name,
               "<br>",
               "Premature mortality rate: ",
               EQ1_plot1_Data()$risk_ratio
             )
           )) +
      geom_line() +
      geom_point(size = 2.5) +
      aes(
        group = area_name,
        linetype = area_name,
        # Have to do this outside so that the legends shows and so that there aren't 3 legends
        color = area_name,
        shape = area_name
      ) +
      scale_color_discrete_phs(
        name = "Area name",
        palette = "main-blues",
        labels = ~ stringr::str_wrap(.x, width = 15) 
      ) +
      # scale_color_manual(name = "Area name:",
      #                    values = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"),    # MS 27/09 - keeping this in for now - until spoken about phsstyles
      #                    labels = ~ stringr::str_wrap(.x, width = 15)) +
      scale_linetype_manual(
        name = "Area name",
        values = c("solid", "dashed", "solid", "dashed"),
        labels = ~ stringr::str_wrap(.x, width = 15)
      ) +
      scale_shape_manual(
        name = "Area name",
        values = c("circle", "circle", "triangle-up", "triangle-up"),
        labels = ~ stringr::str_wrap(.x, width = 15)
      ) +
      theme_classic() +                         # de-clutters graph background
      theme(
        panel.grid.major.x = element_line(),
        # Shows vertical grid lines
        panel.grid.major.y = element_line(),
        # Shows horizontal grid lines
        axis.title.x = element_text(
          size = 12,
          color = "black",
          face = "bold"
        ),
        axis.title.y = element_text(angle = 0,     # angle and vjust for turning title horizontal 
                                    vjust = 0.5,
                                    size = 12,
                                    color = "black",
                                    face = "bold"),
        legend.text = element_text(size = 8,
                                   colour = "black"),
        legend.title = element_text(
          size = 9,
          colour = "black",
          face = "bold"
        )
      ) +
      labs(x = "Year",
           y = "Premature Mortality Rate") +
      scale_y_continuous(expand = c(0, 0),   # Ensures y axis starts from zero
                         limits = c(0, (
                           max(EQ1_plot1_Data()$risk_ratio) + 0.5 * max(EQ1_plot1_Data()$risk_ratio)
                         )))
  })
  
  
  ### Run graph 1 through plotly ----
  
  ggplotly(EQ1_plot1_graph(),
           tooltip = "text") %>%     # uses text set up in ggplot aes above.
  # ### Remove unnecessary buttons from the modebar ---- 
   config(displayModeBar = TRUE,                  
          modeBarButtonsToRemove = bttn_remove,
          displaylogo = F, editable = F)
  
})

## Graph 1 Table ----
# Year, area_type, area_name, risk_ratio, SMR04_Pop_Rate, General_Pop_Rate
output$EQ1_1_table <- renderDataTable({
  datatable(
    EQ1_plot1_Data(),
    style = 'bootstrap',
    class = 'table-bordered table-condensed',
    rownames = FALSE,
    options = list(
      pageLength = 16,
      autoWidth = FALSE,
      dom = 'tip'
    ),
    colnames = c(
      "Financial year",
      "Area Type",
      "Area Name",
      "Risk ratio",
      "SMR04 population rate",
      "General population rate"
    )
  )
})

# Create download buttons that allows users to the download tables in .csv format.
output$EQ1_1_table_download <- downloadHandler(
  filename = 'EQ1 - Mortality rate risk ratio trends.csv',
  content = function(file) {
    write.table(
      EQ1_plot1_Data(),
      file,
      #Remove row numbers as the .csv file already has row numbers.
      row.names = FALSE,
      col.names = c(
        "Financial year",
        "Area Type",
        "Area Name",
        "Risk ratio",
        "SMR04 population rate",
        "General population rate"
      ),
      sep = ","
    )
  }
)


### [ EQ1 PLOT 2 - Mortality rates in general population Vs mental health population ] ----

## Picker for user selecting HB or CA ----

output$EQ1_plot2_areaType_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot2_areaType",
    label = "Select type of geography:",
    choices = unique_area_types,
    selected = "Health board"
  )
})

## Picker for user selecting specific geographies ----
output$EQ1_plot2_areaName_output <- renderUI({
  shinyWidgets::pickerInput(
    "EQ1_plot2_areaName",
    label = "Select area:",
    choices = sort(unique(
      as.character(EQ1_reformatted_data$area_name
                   [EQ1_reformatted_data$area_type %in% input$EQ1_plot2_areaType])
    )),
    multiple = TRUE,
    options = list(
      "max-options" = 1,
      `selected-text-format` = "count > 1"
    ),
    selected = "NHS Scotland"
  )
})

## Graph 2 title ----
output$EQ1_plot2_title <- renderUI({
  
  # Measures section
  req(input$EQ1_plot2_areaName)
  
  paste0("General population and mental health population mortality rates in ",
         input$EQ1_plot2_areaName, ", by financial year:")

})

## Selecting appropriate data for graph 2 ----

EQ1_plot2_Data <- reactive({
  EQ1_reformatted_data %>%
    select(Rate_Type, Year, area_type, area_name, Rate) %>%
    filter(area_type %in% input$EQ1_plot2_areaType
           & area_name %in% input$EQ1_plot2_areaName)
})


# Create the combined general population and MH rates bar chart ----

### Render plotly ----

output$EQ1_plot2 <- renderPlotly({
   ### Create reactive ggplot bar graph ----
   
   EQ1_plot2_graph <- reactive({
      ggplot(data = EQ1_plot2_Data(),
             aes(
                x = Year,
                y = Rate,
                fill = Rate_Type,
                # colours defined below
                text = paste0(
                   "Financial year: ",
                   EQ1_plot2_Data()$Year,
                   "<br>",
                   "Area of residence: ",
                   EQ1_plot2_Data()$area_name,
                   "<br>",
                   "Rate Type: ",
                   EQ1_plot2_Data()$Rate_Type,
                   "<br>",
                   "Rate (per 100,000 population): ",
                   EQ1_plot2_Data()$Rate
                )
             )) +
         geom_bar(stat = "identity", position = "dodge") +     # creates bar graph with bars separated from each other
         scale_fill_manual(values = phs_colours(c("phs-blue", "phs-blue-50"))) +
         theme_classic() +
         theme(  
            panel.grid.major.x = element_line(),
            # Shows vertical grid lines
            panel.grid.major.y = element_line()#,
            # Shows horizontal grid lines
            # axis.title.x = element_text(
            #    size = 12,
            #    color = "black",
            #    face = "bold"
            # ) #,
            # axis.title.y = element_text(angle = 0,     # angle and vjust for turning title horizontal 
            #                             vjust = 0.5,
            #                             size = 12,
            #                             color = "black",
            #                             face = "bold")
         ) +
         #labs(x = "Year"#,
           #   fill = "",
          #    y = "Mortality Rate",
          #    fill = "Population Group:") +
       #  )+
         scale_y_continuous(expand = c(0, 0),      # Ensures y axis starts from zero
                            limits = c(0, (
                               max(EQ1_plot2_Data()$Rate) + 0.5 * max(EQ1_plot2_Data()$Rate)
                            )))
      
   })
   
   
   ### Run graph 2 through plotly ----
   
   ggplotly(EQ1_plot2_graph(),
            tooltip = "text") %>%     # uses text set up in ggplot aes above.
     ### Remove unnecessary buttons from the modebar ---- 
            config(displayModeBar = TRUE,
                   modeBarButtonsToRemove = bttn_remove,
                   displaylogo = F, 
                   editable = F) %>% 
      layout(title = list(text = paste0("General Population and Mental Health Population Mortality Rates", 
                                        "<br>",
                                        "Selected Area: ", input$EQ1_plot2_areaName), 
             # title = list(text = paste0("Comparison of mortality rates (per 100,000 population) per year between", 
             #                "<br>",
             #                "the general population and the mental health population.",
             #                "<br>",
             #                "Selected Area: ", input$EQ1_plot2_areaName), 
                          automargin = TRUE),
             xaxis = list(title = list(text = "Year", 
                                       font = list(size = 15, color = "black"))), 
             yaxis = list(title = list(text = "Mortality Rate (per 100,000 population)", 
                                       font = list(size = 15, color = "black"), 
                                       standoff = 5)), 
         # #            exponentformat = "none",
         # #            separatethousands = TRUE,
         # #            range = c(0, max(EQ1_plot1_Data()$SMR04_Pop_Rate, na.rm = TRUE)
         # #                      + (max(EQ1_plot1_Data()$SMR04_Pop_Rate, na.rm = TRUE)*0.1)

         # #            showline = TRUE,
         # #            ticks = "outside"
         # #          ),
         legend = list(orientation = "v",    # "v" or "h" verticle or horizontal 
                       title = list(text = 'Population Group:')
                       ))
   # testing Legend at bottom (might need to add "legend.position = "bottom"," to theme() in ggplot
      #    legend = list(orientation = "h",    # "v" or "h" verticle or horizontal 
      #                  x = 0.3, 
      #                  y = -0.2, 
      #                  title = list(text = 'Population Group: '),
      #                  bordercolor = "#111",      # Default: "#444" is clear
      #                  borderwidth = 5,       # Sets the width (in px) of the border enclosing the legend. Default: 0
      #                  entrywidth = 18,   #Sets the width (in px or fraction) of the legend. Use 0 to size the entry based on the text width, when `entrywidthmode` is set to "pixels".
      #                  entrywidthmode = "pixels" # Default: "pixels" Determines what entrywidth means.
      #                  # indentation = -3)  # not doing anything - Sets the indentation (in px) of the legend entries. (set as greater than or equal to -15)
      # ))
   
})


### Tables below graphs ----



# Rate_Type, Year, area_type, area_name, Rate
output$EQ1_2_table <- renderDataTable({
  datatable(
    EQ1_plot2_Data(),
    style = 'bootstrap',
    class = 'table-bordered table-condensed',
    rownames = FALSE,
    options = list(
      pageLength = 16,
      autoWidth = FALSE,
      dom = 'tip'
    ),
    colnames = c("Rate type",
                 "Financial year",
                 "Area Type",
                 "Area Name",
                 "Rate")
  )
})

# Download button 
output$EQ1_2_table_download <- downloadHandler(
  filename = paste0("EQ1 - Mortality rate trend for chosen area.csv"),
  content = function(file) {
    write.table(
      EQ1_plot2_Data(),
      file,
      #Remove row numbers as the .csv file already has row numbers.
      row.names = FALSE,
      col.names = c("Rate type",
                    "Financial year",
                    "Area Type",
                    "Area Name",
                    "Rate"),
      sep = ","
    )
  }
)