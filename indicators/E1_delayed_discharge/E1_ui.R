# Beginning of E1 tab ----

tagList(
  
  # Title for E1 tab ----
  fluidRow(width = 12,
           h1("E1 - Delayed Discharges: Number of days people spend in hospital 
             within mental health specialties when they are clinically ready to be 
             discharged (per 1,000 population)"),
           h3("Last Updated: July 2026")
  ),
  
  linebreaks(1),
  
  # Graph 1 ----
  ## Section 1 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("E1 - Section 1: Time Trend")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the total number of days spent ",
             "in hospital for mental health specialties when patients ",
             "are ready to be discharged over time, broken down by ",
             "either council area of residence or health board of treatment."),
           p("Use the drop down menus to select which areas you wish to look at."),
           em("Please note that NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures.")
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
    )
  ),
  
  ## Graph 1 output ----
  fluidRow(
    tabBox(width = NULL,
           type = "pills",
           # Graph
           tabPanel("Plot",
                    tagList(
                      linebreaks(1),
                      altTextUI("E1_plot1_modal"),
                      title = uiOutput("E1_plot1_title"), # Title is reactive and defined in E1_server.R
                      phs_spinner("E1_plot1"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      dataTableOutput("E1_1_table")))
    )
  ),
  
  ## Download button for table 1 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "E1_1_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )),
  
  linebreaks(2), # bigger page break between graphs 
  
  
  # Graph 2 ----
  ## Section 2 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("E1 - Section 2: Single Year Comparison")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the number of days, per 1,000 ", 
             "population, spent in hospital for mental health specialties when patients are ",
             "ready to be discharged over time, broken down by health board of treatment."), 
           p("Use the drop down menu to select which financial year you wish to look at."),
           em("Please note that NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures.")
  ),
  
  ## Graph 2 drop down menus ----
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("E1_plot2_year_output"))
    )
  ),
  
  ## Graph 2 output ----
  fluidRow(
    tabBox(width = NULL,
           type = "pills",
           # Graph
           tabPanel("Plot",
                    tagList(
                      linebreaks(1),
                      altTextUI("E1_plot2_modal"),
                      title = uiOutput("E1_graph2_selected_fyear"), # Title is reactive and defined in E1_server.R
                      phs_spinner("E1_plot2"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      dataTableOutput("E1_2_table")))
    )
  ),
  
  ## Download button for table 2 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "E1_2_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )
  ),
  
  
  linebreaks(1), # page break
  
  # Data source information  ----        
  fluidRow(width = 12,
           h2("Data source information and notes:"),
           p("E1 data is for ages 18 years and above and includes 
                        the mental health specialty Learning Disability. 
                        NHS Orkney and NHS Shetland patient data is included in 
                        NHS Grampian figures."), 
           p("The data relate to delays due to health and social care, 
                        patient and family related reasons, and it is acknowledged 
                        that some discharge arrangements may be more complex due to 
                        the specific care needs of the patient."),
           p("NHS Board level data on annual delayed discharge bed 
                        days by specialty is sourced and published in data tables 
                        by Public Health Scotland (PHS) as part of the ",
             a("delayed discharges in NHS Scotland annual publication,",
               href="https://publichealthscotland.scot/publications/delayed-discharges-in-nhs-scotland-annual/delayed-discharges-in-nhs-scotland-annual-summary-of-occupied-bed-days-and-census-figures-data-to-march-2026/",
               target = "_blank"),
             " which covers a summary of occupied bed days and census 
                          figures up to March 2026."),
           p("Mid-year population estimates time series data comes 
                          from the ",
             a("National Records of Scotland", 
               # Note that page was archived on 28 November 2024: 
               # href="https://www.nrscotland.gov.uk/statistics-and-data/statistics/statistics-by-theme/population/population-estimates/mid-year-population-estimates/population-estimates-time-series-data",
               href = "https://www.nrscotland.gov.uk/publications/population-estimates-time-series-data/",
               target = "_blank"), 
             " website. For this publication,  the population estimates for 
                          financial year 2025/26 have not been released yet and so they are copied from 2024/25."), 
           p("Figures prior to July 2016 are not comparable with the 
                          figures from July 2016 onwards due to revised data 
                          definitions and national data requirements which were 
                          introduced from 1 July 2016 to ensure improved data 
                          quality and alignment of census information and associated 
                          bed days and provide more robust and consistent reporting 
                          across Scotland. In this publication, financial year 2016/17 
                          only includes data for July 2016 to March 2017 and figures 
                          and rates are calculated using these months only."), 
           p("Any further data quality issues or inconsistencies are 
                        covered in the ", 
             a("delayed discharges in NHS Scotland annual publication.",
               href="https://publichealthscotland.scot/publications/delayed-discharges-in-nhsscotland-annual/delayed-discharges-in-nhsscotland-annual-annual-summary-of-occupied-bed-days-and-census-figures-data-to-march-2025/",
               target = "_blank")),
           p("Next update: January 2027")
  ),
  
  # Insert go to top button
  go_2_top_bttn
)