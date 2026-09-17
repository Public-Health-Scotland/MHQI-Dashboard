tagList(
  
  # Title for E1 tab ----
  fluidRow(width = 12,
           h1("S1 - Suicide rate per 100,000 population"),
           h3("Last Updated: March 2026")
  ),
  
  linebreaks(1),
  
  # Graph 1 ----
  ## Section 1 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("S1 - Section 1: Time trend")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the changes over time in the crude ",
             "rate of death by probable suicide per 100,000 population ",
             "(Scottish residents aged 5+ only)."),
           p("This data is only shown for NHS Scotland overall.")
  ),
  
  # Geography dropdown menus
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("S1_plot1_areaType_output"))
    ),
    column(6,
           box(width = NULL,
               uiOutput("S1_plot1_areaName_output"))
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
                      altTextUI("S1_plot1_modal"),
                      title = uiOutput("S1_plot1_title"), # Since the title is reactive it is defined in the server
                      phs_spinner("S1_plot1"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      dataTableOutput("S1_1_table")))
    )
  ),
  
  ## Download button for table 1 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "S1_1_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )),
  
  linebreaks(2), # bigger page break between graphs 
  
  
  # Graph 2 ----
  ## Section 2 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("S1 - Section 2: Comparison of all deaths with deaths by probable suicide")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the change over time in the ", 
             "count of all deaths in Scotland alongside the count of ", 
             "deaths by probable suicide (Scottish residents aged 5+ ",
             "only).")
  ),
  
  # Geography dropdown menus
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("S1_plot2_areaType_output"))),
    column(6,
           box(width = NULL,
               uiOutput("S1_plot2_areaName_output")))
  ),

  
  ## Graph 2 output ----
  fluidRow(
    tabBox(width = NULL,
           type = "pills",
           # Graph
           tabPanel("Plot",
                    tagList(
                      linebreaks(1),
                      altTextUI("S1_plot2_modal"),
                      title = uiOutput("S1_plot2_title"), # Title is reactive and defined in server.R
                      phs_spinner("S1_plot2"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      dataTableOutput("S1_2_table")))
    )
  ),
  
  ## Download button for table 2 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "S1_2_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )
  ),
  
  
  linebreaks(1), # page break
  
  # Data source information  ----        
  fluidRow(width = 12,
           h2("Data source information and notes:"),
           p("These ", 
             a("crude rates per 100,000 population", 
               href = "#shiny-tab-glossary", 
               "data-toggle" = "tab"),
             " are taken from the biennial ScotSID (Scottish Suicide Information Database)
              report published by Public Health Scotland. These rates exclude non-Scottish 
              residents and individuals aged under 5. Further information 
              is available from the ", 
             a(href = "https://publichealthscotland.scot/publications/scottish-suicide-information-database/#",
               target = "_blank", 
               "ScotSID publication webpage.")),
           p("Releases of this dashboard prior to January 2026 presented five-year ",
             a("European age-sex standardised rates", 
               href = "#shiny-tab-glossary", 
               "data-toggle" = "tab"),
             " of death by probable suicide released by National Records of Scotland (NRS).
              Further information on this data is available from the ",
             a(href = "https://www.nrscotland.gov.uk/publications/probable-suicides-2024/#",
               target = "_blank", 
               "NRS probable suicide publication webpage.")),
           p("Next update: January 2028")
  ),
  
  # Insert go to top button
  go_2_top_bttn
)