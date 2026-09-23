#### [ EF5 - 'Did Not Attend' appointments - UI ] ----

## Two graphs:
## HB trend graph - user can select multiple health boards to compare a single measure
## HB measures graph - user can select one health board to compare both 'number of' measures
## - % measure is included in the data table under graph

tagList(
  
  # Title for EF5 tab ----
  fluidRow(width = 12,
           h1("EF5 - Percentage (%) of 'Did Not Attend' appointments for community based ",
              "services of people with mental health conditions"),
           h3("Last Updated: July 2026")
  ),
  
  linebreaks(1),
  
  # Graph 1 ----
  ## Section 1 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("EF5 - Section 1: Time Trend")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p(paste0(
             "Below is an interactive graph which can be used to visualise ",
             "either the total number of community service based ", 
             "appointments for mental health conditions or the number/percentage ",
             "of those appointments where patients 'Did Not Attend', ",
             "across different NHS health boards and in 3 month periods.")),
           p(paste0("Use the drop down menus to select which health board(s) ", 
                    "and measure you wish to look at."))
  ),
  
  ## Graph 1 drop down menus ----
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("EF5_trendPlot_hbName_output"))
    ),
    column(6,
           box(width = NULL,
               uiOutput("EF5_trendPlot_measure_ouput"))
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
                      altTextUI("EF5_trendPlot_modal"),
                      title = uiOutput("EF5_trendPlot_selected_measure"), # Since the title is reactive it is defined in the server
                      phs_spinner("EF5_trendPlot"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      dataTableOutput("EF5_trendPlot_table")))
    )
  ),
  
  ## Download button for table 1 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "EF5_trendPlot_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )),
  
  linebreaks(2), # bigger page break between graphs 
  
  
  # [ EF5 Health Board Measures ] ----
  
  # Graph 2 ----
  ## Section 2 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("EF5 - Section 2: 'Did Not Attend' Vs Total")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p(paste0(
             "Below is an interactive graph where you can select an individual ",
             "health board to visualise ",
             "the total number of community based appointments for mental ",
             "health conditions and the number of community based appointments ",
             "for mental health conditions where patients ",
             "'Did Not Attend', in 3 month periods.")),
           p(paste0(
             "Use the drop down menus to select which health board you wish to visualise."))
  ),
  
  ## Graph 2 drop down menus ----
  fluidRow(
    # Health Board selector
    column(6,
           box(width = NULL,
               uiOutput("EF5_measurePlot_hbName_output"))
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
                      altTextUI("EF5_measurePlot_modal"),
                      title = uiOutput("EF5_measurePlot_selected_hb"), # Title is reactive and defined in server
                      phs_spinner("EF5_measurePlot"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      dataTableOutput("EF5_measurePlot_table")))
    )
  ),
  
  ## Download button for table 1 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "EF5_measurePlot_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )
  ),
  
  
  linebreaks(1), # page break
  
  # Data source information  ----        
  fluidRow(width = 12,
           h2("Data source information and notes:"),
           p("The data for EF5 is sourced from health board returns 
                        which are submitted quarterly and may be incomplete.
                        Data completeness and performance against an indicator 
                        can vary between boards."), 
           p("Board returns for January-March 2026 have been received from: 
                        NHS Ayrshire & Arran, NHS Borders,
                        NHS Fife, NHS Forth Valley, NHS Grampian, 
                        NHS Greater Glasgow & Clyde, NHS Highland, NHS Orkney,
                        NHS Shetland, NHS Tayside and NHS Western Isles."), 
           p("Data for all community mental health outpatient appointments, 
                          all ages and all care groups are requested in the 
                          health board returns. Individual health board data may 
                          be limited to services that record activity on specific 
                          reporting software systems."), 
           p("All reasons for 'Did Not Attend' are included but not 
                          reported in this indicator."),
           p("Next update: October 2026")
  ),
  
  # Insert go to top button
  go_2_top_bttn
)