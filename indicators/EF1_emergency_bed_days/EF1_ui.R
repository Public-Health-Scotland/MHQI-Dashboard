# Beginning of EF1 tab ----

tagList(
  
  # Title for EF1 tab ----
  fluidRow(width = 12,
           h1("EF1 - Rate of emergency psychiatric bed days for adults (per 100,000 population)"),
           h3("Last Updated: July 2026")
           ),
  
  linebreaks(1),
  
  # Graph 1 ----
  ## Section 1 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("EF1 - Section 1: Time Trend")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the number of days adults are in ",
             "psychiatric hospital beds following emergency admission per ",
             "100,000 of the population by calendar year quarter from April 2022."),
           p("Use the drop down menu to select which health board(s) ", 
             "you wish to look at.")
  ),
  
  ## Graph 1 - drop down menu ---- 
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("EF1_trendPlot_hbName_output"))
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
                      altTextUI("EF1_trendPlot_modal"),
                      title = paste0(
                        "Rate of emergency psychiatric bed days for adults (per 100,000 population), ", 
                        "by calendar quarter, in selected NHS health board(s)"),
                      phs_spinner("EF1_trendPlot"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      dataTableOutput("EF1_1_table")))
    )
  ),
  
  ## Download button for table 1 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "EF1_1_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton"))
  ),
  
  linebreaks(2), # bigger page break between graphs

  
  # Graph 2 ---- 
  ## Section 1 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("EF1 - Section 2: Single Quarter Comparison")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the rate of emergency bed days ",
             "for adults in each health board for your chosen ", 
             "calendar year quarter."), 
           p("Use the drop down menu to select which calendar quarter ", 
             "you wish to look at.")
  ),
  
  ## Graph 2 - drop down menu ---- 
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("EF1_plot2_quarter_output"))
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
                      altTextUI("EF1_plot2_modal"),
                      title = uiOutput("EF1_plot2_title"),
                      phs_spinner("EF1_plot2"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      dataTableOutput("EF1_2_table")))
    )
  ),
  
  ## Download button for table 2 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "EF1_2_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton"))
  ),
          
  linbreaks(1),     
          
  ## Data source information  ----  
  
  fluidRow(width = 12,
           h2("Data source information and notes:"),
           p("The data for EF1 is sourced from ",
             a(href = "https://www.nssdiscovery.scot.nhs.uk/",
               target = "_blank",
               "Discovery"),
             " using SMR04 (Scottish Morbidity Records) data ", 
             a("(see Glossary for more information on SMR04).",
               href = "#shiny-tab-glossary", 
               "data-toggle" = "tab"),
             " NHS Board level data is available from the Discovery 
                  online management information system to health and social care 
                  staff from organisation across Scotland including: Scottish 
                  Government, territorial and special health boards, local 
                  authorities and health and social care partnerships. Discovery 
                  is not open to members of the public, the press, academia, or 
                  researchers. At time of data extraction data completeness was below 90% for NHS Fife and NHS Highland. Data completeness 
                  for Scotland overall at the time of data extraction was 96%, well above the NHS Scotland 90% threshold for 
                  publications. Estimates of completeness of 
                  SMR records in recent years can be found ", 
             a(href = "https://publichealthscotland.scot/resources-and-tools/health-intelligence-and-data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/completeness/", 
               target = "_blank",
               "on the Public Health Scotland SMR Completeness open data web page.",),
             p("Next update: October 2026")
           )
  ),
  
  # Insert go to top button
  go_2_top_bttn
          
)