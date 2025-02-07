tabItem(tabName = "EF5_tab",
        fluidPage(
           
          h1(paste0(
            "EF5 - % of 'did not attend' appointments for community based ",
            "services of people with mental health conditions"),
          h3("Last Updated: August 2024"),
          
          hr(),       # page break
          
          ## Text Above Graph ---- 
          fluidRow(
             column(12,
                    box(width = NULL,
                        p(paste0(
                          "Below is an interactive graph which can be used to visualise",
                          "either the total number of community service based ", 
                          "appointments for mental health conditions or the number/percentage ",
                          "of those appointments where patients 'did not attend', ",
                          "across different NHS health boards and in 3 month periods.")),
                        p(paste0("Use the drop down menus to select which Health Board(s) ", 
                          "and measure you wish to look at."))
                        )
                    )
             ), # end of fluidRow
          
          ## Drop down menus ---- 
          
          fluidRow(
            # Health Board selector
             column(6,
                    box(width = NULL,
                        uiOutput("EF5_trendPlot_hbName_output"))
                    ),
             # Measure selector
             column(6,
                    box(width = NULL,
                        uiOutput("EF5_trendPlot_measure_ouput"))
                    )
             ),
          
          ## Graph output ---- 
          fluidRow(
             box(width = 12,
                 plotlyOutput("EF5_trendPlot",
                              # height = "50vh",
                              width = "100%"))
          ),
          
          hr(), # page break        
          
          fluidRow(
             box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("EF5_table"))
             ),  
          
          fluidRow(
             column(4,
                    downloadButton(outputId = "EF5_trendPlot_table_download", 
                                   label = "Download as .csv", 
                                   class = "EF5_table_downloadbutton"),
                    tags$head(
                       tags$style(".EF5_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .EF5_table_downloadbutton { color: #FFFFFF; }")
                    ))
             ),
          
          hr(), # page break
          
          # Data source information  ----        
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("The data for EF5 is sourced from Health Board returns which are submitted quarterly and may be incomplete."))
                    )
             ),
         
          
          br(), 
          
          # Navigation Buttons ----  
          fluidRow(
             column(4, actionButton(inputId = "EF5_scot_hub_button", 
                                    label = "Scotland Hub", icon = icon("home"),
                                    class = "navpageButton")),
             column(4, actionButton(inputId = "EF4_prevButton", 
                                    label = "Previous Page", icon = icon("arrow-left"),
                                    class = "navpageButton")),
             column(4, actionButton(inputId = "EQ1_nextButton", 
                                    label = "Next Page", icon = icon("arrow-right"),
                                    class = "navpageButton"))
          ),
          
          # Insert go to top button
          go_2_top_bttn,
          
          br()
          
          ) # End of fluidPage
        )
)