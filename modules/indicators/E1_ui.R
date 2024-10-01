### Beginning of E1 tab ----

tabItem(tabName = "E1_tab",
        fluidPage(
          tags$head( 
            tags$style(
              type = "text/css",
              
              # Prevent error messages from popping up on the interface.
              ".shiny-output-error { visibility: hidden; }", 
              ".shiny-output-error:before { visibility: hidden; }"
              
            ),
          ),
          ## Title for E1 tab ----
          h1(paste0(
            "E1 - Delayed Discharges: Number of days people spend in hospital ",
            "when they are clinically ready to be discharged (per 1,000 population)")
            ),
          
          
          hr(),     # page break 
          
          ## First Graph ----
          # Text above graph
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                         "Below is a graph showing the total number of days spent ",
                         "in hospital when patients are ready to be discharged over time, ",
                         "broken down by either council area of residence or health board of treatment. ",
                         "Use the drop down menus to select which areas you wish to look at."))
                       )
                   )
          ), # End of fluidRow
          
          # Drop down menus
          fluidRow(
            column(6,
                   box(width = NULL,
                       uiOutput("E1_plot1_areaType_output"))
            ),
            column(6,
                   box(width = NULL,
                       uiOutput("E1_plot1_areaName_output"))
            ),
          ), # End of fluidRow
          
          # Graph 1 output
          fluidRow(
            box(width = 12,
                phs_spinner("E1_plot1")
                )
          ),
          
          
          hr(), # page break
          
          
          ## Second Graph ----
          # Text above graph
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                     "Below is a graph showing the total number of days, per 1,000 population, ", 
                     "spent in hospital when patients are ready to be discharged over time, ",
                     "broken down by either council area of residence or health board of treatment. ",
                     "Use the drop down menus to select which areas you wish to look at."))
                     )
                   )
          ), # End of fluidRow
          
          # Year Drop down
          fluidRow(
            column(6,
                  box(width = NULL,
                      uiOutput("E1_plot2_year_output"))
                  )
              ),
          # Graph 2 output
          fluidRow(
            box(width = 12,
                phs_spinner("E1_plot2")
                )
          ),
          
          hr(), # page break
          
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                         "The first graph's data is presented in the table below."))
                   )
            )
          ), # End of fluidRow
          # Table with graph 1 data
          fluidRow(
            box(width = 12,
                dataTableOutput("E1_1_table")
            )
          ),
          
          fluidRow(
            column(4,
                 downloadButton(outputId = "E1_1_table_download", 
                                label = "Download as .csv", 
                                class = "E1_1_table_downloadbutton"),
                 tags$head(
                   tags$style(".E1_1_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .E1_1_table_downloadbutton { color: #FFFFFF; }")
                 )
          )
          ),

          hr(),
          
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                         "The second graph's data is presented in the table below."))
                   )
            )
          ), # End of fluidRow
          # Table with graph 2 data
          fluidRow(
            box(width = 12,
                dataTableOutput("E1_2_table")
            )
          ),
          
          fluidRow(
            column(4,
                downloadButton(outputId = "E1_2_table_download", 
                               label = "Download as .csv", 
                               class = "E1_2_table_downloadbutton"),
                tags$head(
                  tags$style(".E1_2_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .E1_2_table_downloadbutton { color: #FFFFFF; }")
                )
            )
          ),
          
          
          
          # mainPanel(
          #   tags$p("Below is a graph showing the changes over time."),
          #   
          #   fluidRow(
          #     column(6,uiOutput("E1_plot1_areaType_output")),
          #     column(6,uiOutput("E1_plot1_areaName_output"))
          #   ),
          # 
          #   fluidRow(
          #     plotlyOutput("E1_plot1"
          #                #   ,
          #                # width = "100%",
          #                # height = "50%"
          #                )
          #   ),
          #   br(),
          #   # dataTableOutput("diagnoses_table"),
          #   br(),
          #   br(),
          # 
          #   
          #   tags$p("Below is a graph showing a comparison between health boards and NHS Scotland for your selected financial year."),
          #   # br(),
          #   
          #   fluidRow(
          #      column(6,uiOutput("E1_plot2_year_output"))
          #   ),
          #   
          #   fluidRow(
          #      plotlyOutput("E1_plot2"
          #                   #   ,
          #                   # width = "100%",
          #                   # height = "50%"
          #      )
          #   ),
          #   br(),
          #   tags$p("Source: Delayed discharges in NHS Scotland annual publication.", 
          #          br(), 
          #          "Data shown is for ages 18 years and above"),
          #   # as copied from above -- dataTableOutput("diagnoses_table"),
          #   br(),
          #   br(),
            
          br(),

          ## Navigation Buttons ----
          fluidRow(
            column(4, actionButton(inputId = "E1_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "P4_prevButton", 
                                   label = "Previous Page", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EF1_nextButton", 
                                   label = "Next Page", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          ),
          # Insert go to top button
          go_2_top_bttn
         )
      )