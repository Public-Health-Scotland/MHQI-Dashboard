# Beginning of S2 tab ----

tabItem(tabName = "S2_tab",
        fluidPage(
           tags$head( 
              tags$style(
                 type = "text/css",
                 
                 # Prevent error messages from popping up on the interface.
                 ".shiny-output-error { visibility: hidden; }", 
                 ".shiny-output-error:before { visibility: hidden; }"
                 
              ),
           ),
           
    # Title for S2 tab ----
           
           h1("S2 - Percentage (%) of all discharged psychiatric inpatients followed up by community 
              mental health services within 7 calendar days"),
           h3("Last Updated: March 2025"),
           
           hr(),       # page break
           
           
   # Graph 1 ---- 
           
           ## Text Above Graph ----
           fluidRow(
              column(12,
                     box(width = NULL,
                         p("Below is a graph showing the percentage (%) of psychiatric ",
                           "inpatients in each calendar quarter who were followed up by ", 
                           "community mental health services within 7 calendar days of being ", 
                           "discharged."), 
                         p("Use the drop down menu to select which health board(s) ", 
                           "you wish to look at."), 
                         em("Please note that NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures."))
                     )
              ), 
           
           ## Graph 1 - drop down menu ---- 
           fluidRow(
              column(6,
                     box(width = NULL,
                         uiOutput("S2_trendPlot_hbName_output"))
              )
           ),   
           
           ## Graph 1 - output ---- 
           fluidRow(
              box(width = 12,
                  title = HTML(paste("Percentage of psychiatric inpatients followed up by community 
                                     mental health services within 7 calendar days of being discharged.", 
                                     em("2022-2024 calendar quarters for your selected health board(s)"),   # em() gives us italics
                                     sep = "<br/>")), # separates text two paragraphs.
                  phs_spinner("S2_trendPlot"))   # Shows spinning circle when graph loading, height and width set       
           ),
           
           
           ## Graph 1 data table ----
           fluidRow(
              box(title = HTML(paste("Below is a table showing the data used to create the 
                                     above graph. It can be downloaded using the 'Download as .csv' 
                                     button underneath this section.", 
                                     em("* Where there are 10 of fewer patients either 
                                        followed up or in total, these figures have been 
                                        suppressed due to the risk of identifying individuals."),  # in italics em()   
                                     sep = "<br/>")),
                  width = 12, solidHeader = TRUE, 
                  collapsible = TRUE, collapsed = FALSE,
                  dataTableOutput("S2_1_table"))
              ),  
           
           ## Download button for table 1 ----
           fluidRow(
              column(4,
                     downloadButton(outputId = "S2_1_table_download", 
                                    label = "Download as .csv", 
                                    class = "S2_table_downloadbutton"),
                     tags$head(
                        tags$style(".S2_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .S2_table_downloadbutton { color: #FFFFFF; }")
                     ))
           ),
           
           hr(), # bigger page break between graphs          
           hr(), 
           
   # Graph 2 ---- 
           
           ## Text Above Graph ----
           fluidRow(
              column(12,
                     box(width = NULL,
                         p("Below is a graph showing the percentage (%) of psychiatric ",
                           "inpatients in your chosen calendar quarter, for all NHS health ", 
                           "boards, who were followed up by community mental health services ", 
                           "within 7 calendar days of being discharged."), 
                         p("Use the drop down menu to select which calendar quarter ", 
                           "you wish to look at."),
                         em("Please note that NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures."))
                     )
              ), 
           
           ## Graph 2 - drop down menu ---- 
           fluidRow(
              column(6,
                     box(width = NULL,
                         uiOutput("S2_plot2_quarter_output"))
                     )
              ),  
           
           ## Graph 2 - output ---- 
           fluidRow(
              box(width = 12,
                  title = HTML(paste("Percentage of psychiatric inpatients followed up 
                                            by community mental health services within 7 
                                            calendar days of being discharged.", 
                                     em("NHS Scotland health boards for your selected 
                                        calendar quarter"),   # em() gives us italics
                                     sep = "<br/>")), # separates text two paragraphs.
                  phs_spinner("S2_plot2"))
           ),
           
           
           ## Graph 2 data table ----

           fluidRow(
              box(title = HTML(paste("Below is a table showing the data used to create the 
                                     above graph. It can be downloaded using the 'Download as .csv' 
                                     button underneath this section.", 
                                     em("* Where there are 10 of fewer patients either 
                                        followed up or in total, these figures have been 
                                        suppressed due to the risk of identifying individuals."),  # in italics em()   
                                     sep = "<br/>")),
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("S2_2_table"))
           ),  # end of fluidRow
           
           ## Graph 2 - table download button ---- 
           fluidRow(
              column(4,
                     downloadButton(outputId = "S2_2_table_download", 
                                    label = "Download as .csv", 
                                    class = "S2_table_downloadbutton"),
                     tags$head(
                        tags$style(".S2_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .S2_table_downloadbutton { color: #FFFFFF; }")
                     ))
           ),
           
   hr(), # bigger page break between graphs          
   hr(),            
           
           
    # Graph 3 - HB total and followed up line graph ---- 
  
         ## Text Above Graph ----
         
         fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the total number of psychiatric ",
                         "inpatients who were discharged alongside the number who were ", 
                         "were followed up by community mental health services ", 
                         "within 7 calendar days of being discharged in each quarter ", 
                         "for your chosen health board."), 
                       p("Use the drop down menu to select which health board you wish to look at."), 
                       em("Please note that NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures."))
                   )
            ), 
   
           
           ## Drop down menu ---- 
           fluidRow(
              column(6,
                     box(width = NULL,
                         uiOutput("S2_Plot3_hbName_output"))
              )
           ),   
           
   
   
       ## Graph 3 - output ----
   
   fluidRow(
      box(width = 12,
          title = HTML(paste("Total number of psychiatric inpatients discharged and 
                             number followed up by community mental health services within 7 
                             calendar days.",
                             "For your chosen health board between Q1 (January-March) 
                             2022 and Q4 (October-December) 2024.", 
                             em("* Where there are 10 of fewer patients either    
                                        followed up or in total, these figures have been 
                                        suppressed due to the risk of identifying individuals."), 
                                sep = "<br/>")), # separates text two paragraphs.
          phs_spinner("S2_plot3"))
      ),  
           

   
         ## Graph 3 data table ----
           fluidRow(
              box(title = HTML(paste("Below is a table showing the data used to create the 
                                     above graph. It can be downloaded using the 'Download as .csv' 
                                     button underneath this section.", 
                                     em("* Where there are 10 of fewer patients either 
                                        followed up or in total, these figures have been 
                                        suppressed due to the risk of identifying individuals."),  # in italics em()   
                                     sep = "<br/>")),
                  width = 12, solidHeader = TRUE, 
                  collapsible = TRUE, collapsed = FALSE,
                  dataTableOutput("S2_3_table"))
              ),  
           
   
         ## Graph 3 - Table download button ----
           fluidRow(
              column(4,
                     downloadButton(outputId = "S2_3_table_download", 
                                    label = "Download as .csv", 
                                    class = "S2_table_downloadbutton"),
                     tags$head(
                        tags$style(".S2_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .S2_table_downloadbutton { color: #FFFFFF; }")
                     ))
           ),
           
   
           hr(), # page break             
           
   
 # Data source information  ----  
   fluidRow(
      column(12,
             box(width = NULL,
                 h2("Data source information and notes:"),
                 p("The data for S2 is sourced from health board returns which 
                 are submitted quarterly and may be incomplete. Data for NHS Orkney 
                 and NHS Shetland are included in the NHS Grampian figures."),
                 p("Board returns for Oct-Dec 2024 have been received from: 
                 NHS Ayrshire & Arran, NHS Dumfries & Galloway, NHS Fife, 
                 NHS Forth Valley, NHS Grampian, NHS Greater Glasgow & Clyde, 
                 NHS Highland, NHS Lanarkshire, NHS Lothian, NHS Tayside and 
                 NHS Western Isles."), 
                 p("Data from all hospital psychiatric inpatient wards and from 
                 all community mental health services of all care groups and 
                 ages is included."),
                 p("'Follow up' means one to one assessment face to face, or using 
                 digital or telephonic technology by a mental health practitioner."),
                 p("'Discharges' may include deaths and transfers out as well as 
                 seen and 'Did Not Attend' patients."))
             )
      ),       

   
   hr(), # page break           
   
           
     # Navigation Buttons ----  
           fluidRow(
              column(4, actionButton(inputId = "S2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S5_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
           ),
           
           # Insert go to top button
           go_2_top_bttn,

           
        ) # End of fluidPage
) 
