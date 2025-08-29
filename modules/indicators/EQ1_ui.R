# Beginning of EQ1 tab  ----

tabItem(tabName = "EQ1_tab",
        fluidPage(
          h1("EQ1 - Premature mortality rate Vs Standardised mortality rate ",
             "for persons in contact with mental health services"),
          h3("Last Updated: August 2024"),
          
          hr(),   # page break
          
          
          # First Graph ---- 
          
          ## Page separator ----
          h2("EQ1 - Section 1: Time Trend"),
          
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
            box(
              width = 12,
              title = uiOutput("EQ1_plot1_title"), # Since the title is reactive it is defined in the server
              phs_spinner("EQ1_plot1"))
            ),

          
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
          
          hr(),   # bigger page break between graphs
          hr(),
          
          # Second graph ----
          
          ## Page separator ----
          h2("EQ1 - Section 2: General Population Vs Mental Health Population Comparison"),
          
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
                       uiOutput("EQ1_plot2_areaType_output"))),
            column(6,
                   box(width = NULL,
                       uiOutput("EQ1_plot2_areaName_output")))
          ),
          
          # Graph 2 output
          fluidRow(
            box(width = 12,
                title = uiOutput("EQ1_plot2_title"), # Since the title is reactive it is defined in the server
                phs_spinner("EQ1_plot2"))
          ),
          
          
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
                        h2("Data source information and notes:"),
                        p("These data are sourced from mental health inpatient 
                          and day case (SMR04) Scottish Morbidity Records ", 
                          a("(see Glossary for more information on SMR04)",
                            href = "#shiny-tab-glossary", 
                            "data-toggle" = "tab"),
                          " and death registrations data which can be found on the ",
                          a("National Records of Scotland (NRS)",
                            # Note that page was archived on 28 November 2024: 
                            href = "https://webarchive.nrscotland.gov.uk/20241128122619/https://www.nrscotland.gov.uk/statistics-and-data/statistics/statistics-by-theme/vital-events/deaths/deaths-background-information",
                            target = "_blank"),
                          " website. Data quality issues or inconsistencies are 
                          covered in the data found here."), 
                        p("This indicator saw a change to it's methodology in 2023. 
                        Currently, the indicator is based on patients discharged 
                        from SMR04 in the last five calendar years, who died in the 
                        current calendar year. Patients are aged 0-74 and age 
                        standardised by the European standard population (ESP). 
                        These values are divided by the published NRS premature 
                        mortality age standardised rate for Scotland (ESP mortality 
                        rate of those aged under 75), reported by calendar year."), 
                        p("Prior to 2023, this indicator was based on patients 
                          discharged from SMR04 in the previous three financial 
                          years, who died in the current financial year. Patients 
                          were aged 18-74 and age standardised by Scottish 
                          population. These values were divided by Public Health 
                          Scotland (PHS) calculated general population mortality 
                          rates for 18-74 age-sex standardised Scottish population, 
                          reported by financial year.")
                        )
                    )
             ),
       
          hr(),
       
          # Navigation Buttons ----
          
          fluidRow(
            column(4, actionButton(inputId = "EQ1_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EF5_prevButton", 
                                   label = "Previous Page - EF5", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EQ2_nextButton", 
                                   label = "Next Page - EQ2", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          ),
      
        # Insert go to top button
       go_2_top_bttn
          
          
        ) # End of fluidPage
)