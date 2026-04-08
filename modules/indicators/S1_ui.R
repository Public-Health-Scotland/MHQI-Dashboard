tabItem(tabName = "S1_tab",
        fluidPage(
          
          h1("S1 - Suicide rate per 100,000 population"),
          h3("Last updated: March 2026"),
          
          hr(),   # page break
          
 
          # First Graph ---- 
          
          ## Page separator ----
          h2("S1 - Section 1: Time trend"),
          
          # Text above graph
          fluidRow(
              column(12,
                     box(width = NULL,
                         p("Below is a graph showing the changes over time in the crude ",
                           "rate of death by probable suicide per 100,000 population ",
                           "(Scottish residents aged 5+ only).",
                           br(), 
                           "This data is only shown for NHS Scotland overall.")))
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

          # Graph 1 output
          fluidRow(
              box(
                  width = 12,
                  title = uiOutput("S1_plot1_title"), # Since the title is reactive it is defined in the server
                  phs_spinner("S1_plot1"))
          ),
          
          
          # Box containing graph data table ----
          fluidRow(
              box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section",
                  width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                  dataTableOutput("S1_1_table")
              )
          ),          
          
          # Download button below data table ----
          fluidRow(
              column(4,
                     downloadButton(outputId = "S1_1_table_download", 
                                    label = "Download as .csv", 
                                    class = "tableDownloadButton")
              )
          ),
          
          hr(),   # bigger page break between graphs
          hr(),
          
          # Second graph ----
          
          ## Page separator ----
          h2("S1 - Section 2: Comparison of all deaths with deaths by probable suicide"),
          
          # Text above graph 
          fluidRow(
              column(12,
                     box(width = NULL,
                         p("Below is a graph showing the change over time in the ", 
                           "count of all deaths in Scotland alongside the count of ", 
                           "deaths by probable suicide (Scottish residents aged 5+ ",
                           "only).")))
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
          
          # Graph 2 output
          fluidRow(
              box(width = 12,
                  title = uiOutput("S1_plot2_title"), # Since the title is reactive it is defined in the server
                  phs_spinner("S1_plot2"))
          ),
          
          
          fluidRow(
              box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section",
                  width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                  dataTableOutput("S1_2_table")
              )
          ),
          
          fluidRow(
              column(4,
                     downloadButton(outputId = "S1_2_table_download", 
                                    label = "Download as .csv", 
                                    class = "tableDownloadButton")
                     )
          ),
          
          hr(), # page break
          
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("These ", 
                  a("crude rates per 100,000 population", 
                    href = "#shiny-tab-glossary", 
                    "data-toggle" = "tab"),
                  " are taken from the biennial ScotSID (Scottish Suicide Information Database)
                  report published by Public Health Scotland. These rates exclude non-Scottish residents and individuals aged under 5.
                  Further information 
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
                )), 
          
          
          fluidRow(
            column(4, actionButton(inputId = "S1_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "T3_prevButton", 
                                   label = "Previous page - T3", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "S2_nextButton", 
                                   label = "Next page - S2", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          )
          ) # End of fluidPage
        ) 
