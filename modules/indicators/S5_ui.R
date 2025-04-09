# Beginning of S5 tab ----

tabItem(tabName = "S5_tab",
        fluidPage(
           tags$head( 
              tags$style(
                 type = "text/css",
                 
                 # Prevent error messages from popping up on the interface.
                 ".shiny-output-error { visibility: hidden; }", 
                 ".shiny-output-error:before { visibility: hidden; }"
                 
              ),
           ),
           
     # Title for S5 tab ----
          
          h1("S5 - Incidents of physical violence per 1,000 occupied psychiatric bed days"),
          h3("Last Updated: February 2025"),
          
          hr(),       # page break
          
     # Graph 1 ----
          
          ## Text Above Graph ---- 
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("Below is a graph showing the number of incidents of physical ",
                          "violence per 1,000 occupied psychiatric bed days by calendar ", 
                          "year quarter from January 2022."),
                        p("Use the drop down menu to select which health board(s) ", 
                           "you wish to look at."), 
                        em("Please note that NHS Orkney and NHS Shetland incident data is included in NHS Grampian figures."))
                    )
             ), # end of fluidRow
          
      ## Graph 1 - drop down menu ---- 
          fluidRow(
             column(6,
                    box(width = NULL,
                        uiOutput("S5_trendPlot_hbName_output"))
             )),          
          
          ## Graph 1 output ---- 
          fluidRow(
             box(width = 12,
                 plotlyOutput("S5_trendPlot",
                              height = 600,
                              width = "100%"))
          ),
          
          ## Data source information  ----  
           fluidRow(
              column(12,
                     box(width = NULL,
                         h3("Please note that multiple incidents can be linked to individual 
                            patients."),
                         h3("The data for S5 is sourced from health board returns 
                            which are submitted quarterly and may be incomplete."), 
                         h4("Board returns for Oct-Dec 2024 have been received from NHS Ayrshire & ", 
                            "Arran, NHS Dumfries & Galloway, NHS Fife, NHS Forth Valley, ", 
                            "NHS Grampian, NHS Greater Glasgow & Clyde, NHS Highland, ", 
                            "NHS Lanarkshire, NHS Lothian, NHS Tayside and NHS Western Isles."), 
                         h4("NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures."))
              )
           ),
          
          hr(), # page break
          
          ## Box containing graph 1 data table ----
          fluidRow(
             box(title = HTML(paste("Below is a table showing the data used to create the 
                                     above graph. It can be downloaded using the 'Download as .csv' 
                                     button underneath this section.", 
                                    em("* Where there are 10 of fewer patients either 
                                        followed up or in total, these figures have been 
                                        suppressed due to the risk of identifying individuals."),  # in italics em()   
                                    sep = "<br/>")),
                 width = 12, 
                 solidHeader = TRUE, 
                 collapsible = TRUE, collapsed = FALSE,
                 dataTableOutput("S5_1_table"))
          ),            
           
               
          ## Download button for table 1 ----
          fluidRow(
             column(4,
                    downloadButton(outputId = "S5_1_table_download", 
                                   label = "Download as .csv", 
                                   class = "tableDownloadButton"),
             tags$head(
                tags$style(".S5_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .S5_table_downloadbutton { color: #FFFFFF; }")
             ))
             
             ),
          
     hr(), # bigger page break between graphs          
     hr(), 
          
          
   # Graph 2 ---- 
          
          ## Text Above Graph ----
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("Below is a graph showing the incidents of physical violence per ",
                          "1,000 occupied psychiatric bed days in each health board for your chosen ", 
                          "calendar year quarter."), 
                        p("Use the drop down menu to select which calendar quarter ", 
                          "you wish to look at."),
                        em("Please note that NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures."))
                    
             )
          ), 
          
         ## Graph 2 - drop down menu ---- 
          fluidRow(
             column(6,
                    box(width = NULL,
                        uiOutput("S5_plot2_quarter_output"))
             )
          ),   
          
          ## Graph 2 output ---- 
            fluidRow(
               box(width = 12,
                   title = HTML(paste("Incidents of physical violence per 1,000 occupied 
                                      psychiatric bed days", 
                                      em("NHS Scotland health boards for your selected 
                                                 calendar quarter"),   # em() gives us italics
                                      sep = "<br/>")), # separates text two paragraphs.
                   plotlyOutput("S5_plot2",
                                height = 600,
                                width = "100%"))
            ),
   
   # Without title box:
          # fluidRow(
          #    box(width = 12,
          #        plotlyOutput("S5_plot2",
          #                     height = 600,
          #                     width = "100%"))
          # ),
          
   
         ## Data source information  ----  
         fluidRow(
            column(12,
                   box(width = NULL,
                       h3("Please note that multiple incidents can be linked to individual 
                          patients."),
                       h3("The data for S5 is sourced from health board returns which are 
                          submitted quarterly and may be incomplete."), 
                       h4("Board returns for Oct-Dec 2024 have been received from NHS Ayrshire & ", 
                          "Arran, NHS Dumfries & Galloway, NHS Fife, NHS Forth Valley, ", 
                          "NHS Grampian, NHS Greater Glasgow & Clyde, NHS Highland, ", 
                          "NHS Lanarkshire, NHS Lothian, NHS Tayside and NHS Western Isles."), 
                       h4("NHS Orkney and NHS Shetland patient data is included in NHS Grampian figures."))
            )
         ),
                
          hr(), # page break  
          
         ## Box containing graph 2 data table ----
         fluidRow(
            box(title = HTML(paste("Below is a table showing the data used to create the 
                                   above graph. It can be downloaded using the 'Download as .csv'
                                   button underneath this section.", 
                                   em("* Where there are 10 of fewer patients either followed up 
                                      or in total, these figures have been suppressed due to the 
                                      risk of identifying individuals."),  # in italics em()   
                                   sep = "<br/>")),
                width = 12, 
                solidHeader = TRUE, 
                collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("S5_2_table"))
            ), 
          
          
         
         ## Graph 2 - table download button ---- 
          fluidRow(
             column(4,
                    downloadButton(outputId = "S5_2_table_download", 
                                   label = "Download as .csv", 
                                   class = "S5_table_downloadbutton"),
                    tags$head(
                       tags$style(".S5_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .S5_table_downloadbutton { color: #FFFFFF; }")
                    ))
          ),
          
          hr(), # page break            
          
  
          
    # Navigation Buttons ----  
          fluidRow(
             column(4, actionButton(inputId = "S5_scot_hub_button", 
                                    label = "Scotland Hub", icon = icon("home"),
                                    class = "navpageButton")),
             column(4, actionButton(inputId = "S2_prevButton", 
                                    label = "Previous Page", icon = icon("arrow-left"),
                                    class = "navpageButton")),
             column(4, actionButton(inputId = "P1_nextButton", 
                                    label = "Next Page", icon = icon("arrow-right"),
                                    class = "navpageButton"))
          ),
          
        # Insert go to top button
          go_2_top_bttn,
          

          ) # End of fluidPage
        ) 
