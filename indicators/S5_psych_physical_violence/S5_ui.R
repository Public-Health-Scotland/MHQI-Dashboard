# Beginning of S5 tab ----

tagList(
  
  # Title for S5 tab ----
  fluidRow(width = 12,
           h1("S5 - Incidents of physical violence per 1,000 occupied psychiatric bed days"),
           h3("Last Updated: July 2026")
  ),
  
  linebreaks(1),
  
  # Graph 1 ----
  ## Section 1 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("S5 - Section 1: Time Trend")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the number of incidents of physical ",
             "violence per 1,000 occupied psychiatric bed days by calendar ", 
             "year quarter from January 2022."),
           p("Use the drop down menu to select which health board(s) ", 
             "you wish to look at."), 
           em("Please note that NHS Orkney and NHS Shetland incident data is included in NHS Grampian figures.")
  ),
  
  ## Graph 1 drop down menus ----
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("S5_trendPlot_hbName_output"))
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
                      altTextUI("S5_trendPlot_modal"),
                      title = paste0(
                        "Incidents of physical violence per 1,000 occupied psychiatric bed days, ", 
                        "by calendar quarter, in selected NHS health board(s)"),
                      phs_spinner("S5_trendPlot"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      em("* Where there are 10 or fewer incidents or total occupied psychiatric bed days, 
                      these figures have been suppressed due to the risk of identifying individuals."),
                      dataTableOutput("S5_1_table")))
    )
  ),
  
  ## Download button for table 1 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "S5_1_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )),
  
  linebreaks(2), # bigger page break between graphs 
  
  
  # Graph 2 ----
  ## Section 2 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("S5 - Section 2: Quarter Comparison")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the incidents of physical violence per ",
             "1,000 occupied psychiatric bed days in each health board for your chosen ", 
             "calendar year quarter."), 
           p("Use the drop down menu to select which calendar quarter ", 
             "you wish to look at."),
           em("Please note that NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures.")
  ),
  
  ## Graph 2 drop down menus ----
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("S5_plot2_quarter_output"))
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
                      altTextUI("S5_plot2_modal"),
                      title = uiOutput("S5_plot2_title"), # Title is reactive and defined in E1_server.R
                      phs_spinner("S5_plot2"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      em("* Where there are 10 or fewer incidents or total occupied 
                                       psychiatric bed days, these figures have been suppressed 
                                       due to the risk of identifying individuals."),
                      dataTableOutput("S5_2_table")))
    )
  ),
  
  ## Download button for table 2 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "S5_2_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )
  ),
  
  
  linebreaks(1), # page break
  
  # Data source information  ----        
  fluidRow(width = 12,
           h2("Data source information and notes:"),
           p("The data for S5 is sourced from health board returns which are submitted 
            quarterly and may be incomplete. Data completeness and performance 
            against an indicator can vary between boards."),
           p("Data for NHS Orkney and NHS Shetland are included in the NHS Grampian figures."),
           p("Board returns for January-March 2026 have been received from: 
               NHS Ayrshire & Arran, NHS Borders, 
                NHS Fife, NHS Forth Valley, NHS Grampian, 
                NHS Greater Glasgow & Clyde, NHS Highland, NHS Tayside and NHS Western Isles."), 
           p("To ensure accurate reporting, NHS Dumfries & Galloway data for 
             Jan-Mar 2025 are not available due to a transition between data 
             reporting software systems. Future submissions are expected 
             to be accurate."),
           p("Please note that multiple incidents can be linked to individual patients."),
           p("'Physical violence' means physical harm inflicted on a person from another. 
            This includes violence committed on or by any person including staff, 
            patients and visitors."),
           p("Next update: October 2026")
  ),
  
  # Insert go to top button
  go_2_top_bttn
)