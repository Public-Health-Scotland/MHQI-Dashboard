#### [ EF5 - 'Did Not Attend' appointments - UI ] ----

## Two graphs:
## HB trend graph - user can select multiple health boards to compare a single measure
## HB measures graph - user can select one health board to compare both 'number of' measures
## - % measure is included in the data table under graph

tabItem(tabName = "EF5_tab",
        fluidPage(
          ## Title section ----
          h1(paste0(
            "EF5 - Percentage (%) of 'Did Not Attend' appointments for community based ",
            "services of people with mental health conditions")),
          h3("Last Updated: July 2025"),
          
          hr(),       # page break
          
          
          ### [ EF5 Health Board Trends ] ----
          
          ## Text above Graph ---- 
          fluidRow(
             column(12,
                    box(width = NULL,
                        p(paste0(
                          "Below is an interactive graph which can be used to visualise ",
                          "either the total number of community service based ", 
                          "appointments for mental health conditions or the number/percentage ",
                          "of those appointments where patients 'Did Not Attend', ",
                          "across different NHS health boards and in 3 month periods.")),
                        p(paste0("Use the drop down menus to select which health board(s) ", 
                          "and measure you wish to look at."))
                        )
                    )
             ), # end of fluidRow
          
          ## Graph selectors ---- 
          
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
                 title = uiOutput("EF5_trendPlot_selected_measure"), # Since the title is reactive it is defined in the server
                 phs_spinner("EF5_trendPlot"))   # spinner shows spinning circle while graph loads
          ),
          
          
          ## Table below graph ----
          fluidRow(
             box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("EF5_trendPlot_table"))
             ),  
          
          fluidRow(
             column(4,
                    downloadButton(outputId = "EF5_trendPlot_table_download", 
                                   label = "Download as .csv", 
                                   class = "tableDownloadButton")
                    )
             ),
          
          hr(), # bigger page break between graphs
          hr(),
          
          # [ EF5 Health Board Measures ] ----
          
          ## Text above Graph ---- 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                         "Below is an interactive graph where you can select an individual ",
                         "health board to visualise ",
                         "the total number of community based appointments for mental ",
                         "health conditions and the number of community based appointments ",
                         "for mental health conditions where patients ",
                         "'Did Not Attend', in 3 month periods.")),
                       p(paste0(
                         "Use the drop down menus to select which health board you wish to visualise."))
                   )
            )
          ), # end of fluidRow
          
          ## Graph selectors ---- 
          
          fluidRow(
            # Health Board selector
            column(6,
                   box(width = NULL,
                       uiOutput("EF5_measurePlot_hbName_output"))
                   )
            ),
          
          ## Graph output ---- 
          fluidRow(
            box(width = 12,
                title = uiOutput("EF5_measurePlot_selected_hb"), # Since the title is reactive it is defined in the server
                phs_spinner("EF5_measurePlot"))
            ),
          
          hr(), # page break
          
          ## Table below graph ----
          fluidRow(
            box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("EF5_measurePlot_table"))
          ),  
          
          fluidRow(
            column(4,
                   downloadButton(outputId = "EF5_measurePlot_table_download", 
                                  label = "Download as .csv", 
                                  class = "tableDownloadButton")
            )
          ),
          
          hr(), # page break
          
          # Data source information  ----        
          fluidRow(
             column(12,
                    box(width = NULL,
                        h2("Data source information and notes:"),
                        p("The data for EF5 is sourced from health board returns 
                        which are submitted quarterly and may be incomplete.
                        Data completeness and performance against an indicator 
                        can vary between boards."), 
                        p("Board returns for January-March 2025 have been received from: 
                        NHS Ayrshire & Arran, NHS Dumfries & Galloway, NHS Fife, 
                        NHS Forth Valley, NHS Grampian, NHS Highland, 
                        NHS Lothian, NHS Orkney, NHS Shetland, and 
                        NHS Western Isles."), 
                        p("All community mental health outpatient appointments, 
                          all ages and all care groups are included."), 
                        p("All reasons for 'Did Not Attend' are included but not 
                          reported in this indicator.")))
          ),
         
          
          hr(), 
          
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
