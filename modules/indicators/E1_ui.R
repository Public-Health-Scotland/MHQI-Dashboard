# Beginning of E1 tab ----

tabItem(tabName = "E1_tab",
        fluidPage(
          tags$head( 
            tags$style(
              type = "text/css",
              
              # Prevent error messages from popping up on the interface.
              ".shiny-output-error { visibility: hidden; }", 
              ".shiny-output-error:before { visibility: hidden; }"
              
            ),
          ),
          
     # Title for E1 tab ----
          
          h1("E1 - Delayed Discharges: Number of days people spend in hospital ",
            "when they are clinically ready to be discharged (per 1,000 population)"),
          h3("Last Updated: December 2024"),
          
          
          hr(),     # page break 
          
      # Graph 1 ----
     
          ## Text above graph ----
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the total number of days spent ",
                         "in hospital for mental health specialties when patients ",
                         "are ready to be discharged over time, broken down by ",
                         "either council area of residence or health board of treatment."),
                       p("Use the drop down menus to select which areas you wish to look at."),
                       em("Please note that NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures."))
                   )
          ), 
          
          ## Graph 1 drop down menus ----
          fluidRow(
            column(6,
                   box(width = NULL,
                       uiOutput("E1_plot1_areaType_output"))
            ),
            column(6,
                   box(width = NULL,
                       uiOutput("E1_plot1_areaName_output"))
            ),
          ), 
          
          ## Graph 1 output ----
          fluidRow(
            box(width = 12,
                title = uiOutput("E1_graph1_selected_areaName"), # Title is reactive and defined in E1_server.R
                phs_spinner("E1_plot1"), # shows spinning circle while graph is loading 
                )   
            ),
          
     ## Graph 1 data table ----
          fluidRow(
            box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section.",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("E1_1_table")
            )
          ),
          
     ## Download button for table 1 ----
          fluidRow(
            column(4,
                   downloadButton(outputId = "E1_1_table_download", 
                                  label = "Download as .csv", 
                                  class = "tableDownloadButton")
                   )),
          
          
     hr(), # bigger page break between graphs          
     hr(), 
          
          
    # Graph 2 ----
     
          ## Text above graph ----
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the number of days, per 1,000 ", 
                         "population, spent in hospital for mental health specialties when patients are ",
                         "ready to be discharged over time, broken down by ", 
                         #"either council area of residence or ", 
                         "health board of treatment."), 
                       p("Use the drop down menu to select which year you wish to look at."),
                       # OR p("Use the drop down menus to select which year and areas you wish to look at."),
                       em("Please note that NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures."))
                     )
                   ),
          
      ## Graph 2 drop down menu ---- 
          fluidRow(
            column(6,
                  box(width = NULL,
                      uiOutput("E1_plot2_year_output"))
                  )
              ),
    
      ## Graph 2 output ----
          fluidRow(
            box(width = 12,
                title = uiOutput("E1_graph2_selected_fyear"), # Title is reactive and defined in E1_server.R 
                phs_spinner("E1_plot2")
                )  
          ),
           
     ## Graph 2 data table ---- 
          fluidRow(
            box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section.",
                width = 12, solidHeader = TRUE, 
                collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("E1_2_table"))
          ),
          
    ## Graph 2 - download table button ---- 
          fluidRow(
            column(4,
                   downloadButton(outputId = "E1_2_table_download", 
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
                        p("The above data is for ages 18 years and above and includes the mental health specialty Learning Disability. 
                          NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures."), 
                        p("Data is sourced from data collected by Public Health Scotland (PHS) as part of the ",
                          a("delayed discharges in NHS Scotland annual publication,",
                            href="https://publichealthscotland.scot/publications/delayed-discharges-in-nhsscotland-annual/delayed-discharges-in-nhsscotland-annual-annual-summary-of-occupied-bed-days-and-census-figures-data-to-march-2024-planned-revision/",
                            target = "_blank"),
                          " which covers a summary of occupied bed days and census figures up to March 2024. Data quality issues or inconsistencies are covered in the data found here."),
                        p("Mid-year population estimates time series data comes from the ",
                          a("National Records of Scotland", 
                            # Note that page was archived on 28 November 2024: 
                           # href="https://www.nrscotland.gov.uk/statistics-and-data/statistics/statistics-by-theme/population/population-estimates/mid-year-population-estimates/population-estimates-time-series-data",
                           href = "https://webarchive.nrscotland.gov.uk/20241128121747/https://www.nrscotland.gov.uk/statistics-and-data/statistics/statistics-by-theme/population/population-estimates/mid-year-population-estimates",
                            target = "_blank"), 
                          " website.")
                        )
             
          )),
          
          br(), 

          # Navigation Buttons ----
          fluidRow(
            column(4, actionButton(inputId = "E1_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "P4_prevButton", 
                                   label = "Previous Page", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EF1_nextButton", 
                                   label = "Next Page", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          ),
          # Insert go to top button
          go_2_top_bttn
         )
      )