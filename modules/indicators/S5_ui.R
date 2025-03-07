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
                        p("The data for S5 is sourced from health board returns, which are ", 
                          "submitted quarterly and may be incomplete."),
                        p("Use the drop down menu to select which health board(s) ", 
                           "you wish to look at.")
                    )
             )), # end of fluidRow
          
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
                              # height = "50vh",
                              width = "100%"))
          ),
          
          ## Data source information  ----  
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("The data for S5 is sourced from health board returns, which are submitted quarterly and may be incomplete."),
                        br(),
                        p(paste0("Board returns were received from... "))) # Check if Shetland is within Grampian
             )),
          
          hr(), # page break
          
          ## Box containing graph 1 data table ----
          fluidRow(
             box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section. 
                Please note that the data for S5 is sourced from health board returns 
                which are submitted quarterly and may be incomplete.",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
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
          
          hr(), # page break
          
          
   # Graph 2 ---- 
          
          ## Text Above Graph ----
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("Below is a graph showing the incidents of physical violence per ",
                          "1,000 occupied bed days in each health board for your chosen ", 
                          "calendar year quarter."), 
                        p("Use the drop down menu to select which calendar quarter ", 
                          "you wish to look at."))
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
                 plotlyOutput("S5_plot2",
                              # height = "50vh",
                              width = "100%"))
          ),
          
          ## Data source information  ----  
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("The data for S5 is sourced from health board returns, which are submitted quarterly and may be incomplete."),
                        br(),
                        p(paste0("Board returns were received from... "))) # Check if Shetland is within Grampian
             )),
          
          hr(), # page break  
          
         ## Box containing graph 2 data table ----
          fluidRow(
             box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section.
                Please note that the data for S5 is sourced from health board returns 
                which are submitted quarterly and may be incomplete.",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("S5_2_table"))
          ),  # end of fluidRow
          
         
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
