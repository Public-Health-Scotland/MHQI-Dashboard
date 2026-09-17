# Beginning of S2 tab ----

tagList(
  
  # Title for S2 tab ----
  fluidRow(width = 12,
           h1("S2 - Percentage (%) of all discharged psychiatric inpatients 
              followed up by community mental health services within 7 calendar days"),
           h3("Last Updated: July 2026")
  ),
  
  linebreaks(1),
  
  # Graph 1 ----
  ## Section 1 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("S2 - Section 1: Time Trend")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the percentage (%) of psychiatric ",
             "inpatients in each calendar quarter who were followed up by ", 
             "community mental health services within 7 calendar days of being ", 
             "discharged."), 
           p("Use the drop down menu to select which health board(s) ", 
             "you wish to look at."), 
           em("Please note that data for NHS Lanarkshire, NHS Orkney and NHS Shetland is not available.")
  ),
  
  ## Graph 1 drop down menus ----
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("S2_trendPlot_hbName_output"))
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
                      altTextUI("S2_trendPlot_modal"),
                      title = paste0(
                        "Percentage of psychiatric inpatients followed up by community ",
                        "mental health services within 7 calendar days of being discharged, ",
                        "by calendar quarter, in selected NHS health board(s)"),
                      phs_spinner("S2_trendPlot"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      em("* Where there are 10 of fewer patients either followed up or in total, 
                      these figures have been suppressed due to the risk of identifying individuals."),
                      dataTableOutput("S2_1_table")))
    )
  ),
  
  ## Download button for table 1 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "S2_1_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )),
  
  linebreaks(2), # bigger page break between graphs 
  
  
  # Graph 2 ----
  ## Section 2 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("S2 - Section 2: Quarter Comparison")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the percentage (%) of psychiatric ",
             "inpatients in your chosen calendar quarter, for all NHS health ", 
             "boards, who were followed up by community mental health services ", 
             "within 7 calendar days of being discharged."), 
           p("Use the drop down menu to select which calendar quarter ", 
             "you wish to look at."),
           em("Please note that data for NHS Lanarkshire, NHS Orkney and NHS Shetland is not available.")
  ),
  
  ## Graph 2 drop down menus ----
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("S2_plot2_quarter_output"))
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
                      altTextUI("S2_plot2_modal"),
                      title = uiOutput("S2_plot2_title"),
                      phs_spinner("S2_plot2"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      em("* Where there are 10 of fewer patients either 
                                        followed up or in total, these figures have been 
                                        suppressed due to the risk of identifying individuals."),
                      dataTableOutput("S2_2_table")))
    )
  ),
  
  ## Download button for table 2 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "S2_2_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )
  ),
  
  
  linebreaks(2), # page break
  
  # Graph 3 - HB total and followed up line graph ---- 
  ## Section 3 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("S2 - Section 3: Followed-up Vs Total")
           )),
  
  ## Text above graph ----
  fluidRow(width = NULL,
           p("Below is a graph showing the total number of psychiatric ",
             "inpatients who were discharged alongside the number who were ", 
             "were followed up by community mental health services ", 
             "within 7 calendar days of being discharged in each quarter ", 
             "for your chosen health board."), 
           p("Use the drop down menu to select which health board you wish to look at."), 
           em("Please note that data for NHS Orkney and NHS Shetland is not available due to small numbers.")
  ),
  
  ## Graph 3 drop down menus ----
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("S2_Plot3_hbName_output"))
    )
  ),
  
  ## Graph 3 output ----
  fluidRow(
    tabBox(width = NULL,
           type = "pills",
           # Graph
           tabPanel("Plot",
                    tagList(
                      linebreaks(1),
                      altTextUI("S2_plot3_modal"),
                      title = uiOutput("S2_plot3_title"), # Title is reactive and defined in E1_server.R
                      phs_spinner("S2_plot3"))), # shows spinning circle while graph is loading
           # Data table
           tabPanel("Data",
                    tagList(
                      linebreaks(1),
                      title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                      em("* Where there are 10 of fewer patients either followed up or in total, 
                      these figures have been suppressed due to the risk of identifying individuals."),
                      dataTableOutput("S2_3_table")))
    )
  ),
  
  ## Download button for table 3 ----
  fluidRow(
    column(4,
           downloadButton(outputId = "S2_3_table_download", 
                          label = "Download as .csv", 
                          class = "tableDownloadButton")
    )
  ),
  
  linebreaks(1),
  
  # Data source information  ----        
  fluidRow(width = 12,
           h2("Data source information and notes:"),
           p("The data for S2 is sourced from health board returns which 
             are submitted quarterly and may be incomplete. Data completeness 
             and performance against an indicator can vary between boards."),
           p("Data for NHS Orkney and NHS Shetland is not available due to small numbers."),
           p("Board returns for January-March 2026 have been received from: 
                 NHS Ayrshire & Arran, NHS Borders, 
                        NHS Fife, NHS Forth Valley, NHS Grampian, 
                        NHS Greater Glasgow & Clyde, NHS Highland, 
                         NHS Tayside and NHS Western Isles."), 
           p("Data from all hospital psychiatric inpatient wards and from 
             all community mental health services of all care groups and 
             ages is included. The following specialties are included where
             available: General Psychiatry; Child and Adolescent Psychiatry; 
             Forensic Psychiatry; Psychiatry of Old Age; Learning Disability; 
             and Psychotherapy."),
           p("'Discharges' may include deaths and transfers out as well as 
             seen and 'Did Not Attend' patients."),
           p("'Follow up' means one to one assessment face to face, or using 
             digital or telephonic technology by a mental health practitioner, 
             which can include Psychiatrists, Mental Health Nurses, Psychologists, 
             and other Allied Health Professions as well as Social Workers 
             and Mental Health Officers."),
           p("'Community mental health services' - The Scottish Government's ",
             a(href = "https://www.gov.scot/publications/core-mental-health-standards/pages/12/", 
               "'Core mental health standards' publication", 
               target = "_blank"), 
             " states: 'Community Services: This is care and support which 
             can be accessed without the need to be admitted to an inpatient 
             hospital ward.'"),
           p("Next update: October 2026")
  ),
  
  # Insert go to top button
  go_2_top_bttn
)