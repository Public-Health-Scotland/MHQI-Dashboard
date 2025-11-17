# Beginning of EF1 tab ----

tabItem(tabName = "EF1_tab",
        fluidPage(
          tags$head( 
            tags$style(
              type = "text/css",
              
              # Prevent error messages from popping up on the interface.
              ".shiny-output-error { visibility: hidden; }", 
              ".shiny-output-error:before { visibility: hidden; }"
              
            ),
          ),
          
          # Title for EF1 tab ----
          
          h1("EF1 - Incidents of physical violence per 1,000 occupied psychiatric bed days"),
          h3("Last Updated: September 2025"),
          
          hr(),       # page break
          
          # Graph 1 ----
          
          ## Page separator ----
          h2("EF1 - Section 1: Time Trend"),
          ## Text Above Graph ---- 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the number of incidents of physical ",
                         "violence per 1,000 occupied psychiatric bed days by calendar ", 
                         "year quarter from January 2022."),
                       p("Use the drop down menu to select which health board(s) ", 
                         "you wish to look at."))
            )
          ), # end of fluidRow
          
          ## Graph 1 - drop down menu ---- 
          fluidRow(
            column(6,
                   box(width = NULL,
                       uiOutput("EF1_trendPlot_hbName_output"))
            )),
          
          ## Graph 1 output ---- 
          fluidRow(
            box(width = 12,
                title = paste0(
                  "Incidents of physical violence per 1,000 occupied psychiatric bed days, ", 
                  "by calendar quarter, in selected NHS health board(s)"),
                phs_spinner("EF1_trendPlot"))
          ),
          
          ## Graph 1 data table ----
          fluidRow(
            box(title = HTML(paste("Below is a table showing the data used to create the 
                                     above graph. It can be downloaded using the 'Download as .csv' 
                                     button underneath this section.", 
                                   em("* Where there are 10 or fewer incidents or total occupied 
                                       psychiatric bed days, these figures have been suppressed 
                                       due to the risk of identifying individuals."),  # in italics em()   
                                   sep = "<br/>")),
                width = 12, 
                solidHeader = TRUE, 
                collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("EF1_1_table"))
          ),            
          
          
          ## Download button for table 1 ----
          fluidRow(
            column(4,
                   downloadButton(outputId = "EF1_1_table_download", 
                                  label = "Download as .csv", 
                                  class = "tableDownloadButton"))
          ),
          
          
          hr(), # bigger page break between graphs          
          hr(), 
          
          
          # Graph 2 ---- 
          
          ## Page separator ----
          h2("EF1 - Section 2: Single Year Comparison"),
          
          ## Text Above Graph ----
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the incidents of physical violence per ",
                         "1,000 occupied psychiatric bed days in each health board for your chosen ", 
                         "calendar year quarter."), 
                       p("Use the drop down menu to select which calendar quarter ", 
                         "you wish to look at."))
                   
            )
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
            box(width = 12,
                title = uiOutput("EF1_plot2_title"),
                phs_spinner("EF1_plot2"))
          ),
          
          
          ## Graph 2 data table ----
          fluidRow(
            box(title = HTML(paste("Below is a table showing the data used to create the 
                                   above graph. It can be downloaded using the 'Download as .csv'
                                   button underneath this section.", 
                                   em("* Where there are 10 or fewer incidents or total occupied 
                                       psychiatric bed days, these figures have been suppressed 
                                       due to the risk of identifying individuals."),  # in italics em()  
                                   sep = "<br/>")),
                width = 12, 
                solidHeader = TRUE, 
                collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("EF1_2_table"))
          ), 
          
          
          ## Graph 2 - table download button ---- 
          fluidRow(
            column(4,
                   downloadButton(outputId = "EF1_2_table_download", 
                                  label = "Download as .csv", 
                                  class = "tableDownloadButton"))
          ),
          
          hr(), # page break            
          
          
          ## Data source information  ----  
          
          fluidRow(
            column(12,
                   box(width = NULL,
                       h2("Data source information and notes:"),
                       p("Please note that multiple incidents can be linked to individual patients."),
                       p("'Physical violence' means physical harm inflicted on a person from another. 
                    This includes violence committed on or by any person including staff, 
                    patients and visitors."),
                       p("Next update: January 2026")
                   )
            )),
          
          
          hr(),
          
          # Navigation Buttons ----  
          fluidRow(
            column(4, actionButton(inputId = "EF1_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "E1_prevButton", 
                                   label = "Previous Page - E1", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EF2_nextButton", 
                                   label = "Next Page - EF2", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          ),
          
          # Insert go to top button
          go_2_top_bttn,
          
          
        ) # End of fluidPage
) 
