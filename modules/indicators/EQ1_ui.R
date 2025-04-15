# Beginning of EQ1 tab  ----

tabItem(tabName = "EQ1_tab",
        fluidPage(
          h1("EQ1 - Premature mortality rate = Standardised mortality rate ",
             "for persons in contact with mental health services"),
          h3("Last Updated: August 2024"),
          
          hr(),   # page break
          
          
          # First Graph ---- 
          # Text above graph
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the changes over time of the premature ",
                         "mortality rates for persons in contact with mental health services, ", 
                         "showing how many times higher it is than the mortality rate for ", 
                         "the general population.",
                         br(), 
                         "This is broken down by either council area or health board of ", 
                         "residence. Please use the drop down menus to select which ", 
                         "areas you wish to look at.")))
          ),
          
          
          # Geography Drop Down Menus
          fluidRow(
            column(6,
                   box(width = NULL,
                       uiOutput("EQ1_plot1_areaType_output"))
            ),
            column(6,
                   box(width = NULL,
                       uiOutput("EQ1_plot1_areaName_output"))
            )
          ),
          
          # Graph 1 output
          fluidRow(
            box(width = 12,
                phs_spinner("EQ1_plot1"))
          ),
          hr(), # page break
          
          # Box containing graph data table ----
          fluidRow(
            box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("EQ1_1_table")
                )
            ),          
          
          # Download button below data table ----
          fluidRow(
            column(4,
                   downloadButton(outputId = "EQ1_1_table_download", 
                                  label = "Download as .csv", 
                                  class = "tableDownloadButton")
                   )
            ),
          
          hr(),   # page break
          
          
          # Second graph ---- 
          # Text above graph 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the changes over time of the ", 
                         "mortality rates (per 100,000 population) for the general ", 
                         " population and the mental health population for your chosen area.",
                         br(), 
                         "This is broken down by either council area or health board of ", 
                         "residence. Please use the drop down menus to select which ", 
                         "area you wish to look at.")))
          ),
          
          # Geography Drop Down Menus
          fluidRow(
            column(6,
                   box(width = NULL,
                       uiOutput("EQ1_plot4_areaType_output"))),
            column(6,
                   box(width = NULL,
                       uiOutput("EQ1_plot4_areaName_output")))
          ),
          
          # Graph 2 output
          fluidRow(
            box(width = 12,
                phs_spinner("EQ1_plot4"))
          ),
          hr(), # page break
          
          fluidRow(
            box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("EQ1_2_table")
            )
          ),
          fluidRow(
            column(4,
                   downloadButton(outputId = "EQ1_2_table_download", 
                                  label = "Download as .csv", 
                                  class = "tableDownloadButton"))
            ),
          
          hr(), # page break
          
       # Data source information  ----   
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("These data are sourced from mental health inpatient and day case Scottish Morbidity Records ", 
                          a("(SMR04)",
                             href = "https://publichealthscotland.scot/resources-and-tools/health-intelligence-and-data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/what-are-the-smr-datasets/",
                             target = "_blank"),
                          " and death registrations data which can be found on the ",
                          a("National Records of Scotland ",
                            href="https://www.nrscotland.gov.uk/statistics-and-data/statistics/statistics-by-theme/vital-events/deaths/deaths-background-information",
                            target = "_blank"),
                          " website. Data quality issues or inconsistencies are covered in the data found here.")
                        )
                    )),
       
          br(),
       
          # Navigation Buttons ----
          
          fluidRow(
            column(4, actionButton(inputId = "EQ1_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EF5_prevButton", 
                                   label = "Previous Page", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EQ2_nextButton", 
                                   label = "Next Page", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          ),
      
        # Insert go to top button
       go_2_top_bttn
          
          
        ) # End of fluidPage
)