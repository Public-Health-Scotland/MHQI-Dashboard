# Beginning of EQ1 tab  ----

tabItem(tabName = "EQ1_tab",
        fluidPage(
          h1("EQ1 - Premature mortality rate = Standardised mortality rate ",
             "for persons in contact with mental health services"),
          
          hr(),   # page break
          
          
          # First Graph ---- 
          # Text above graph
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the changes over time of the ", 
                         "mortality rates for persons in contact with mental health ", 
                         "services. ",
                         br(), 
                         "This is broken down by either council area or health board of ", 
                         "residence. Please use the drop down menus to select which ", 
                         "areas you wish to look at.")))
          ),
          
          # Geography Drop Down Menus
          fluidRow(
            column(6,
                   box(width = NULL,
                       uiOutput("EQ1_plot1_areaType_output"))
            ),
            column(6,
                   box(width = NULL,
                       uiOutput("EQ1_plot1_areaName_output"))
            ),
          ),
          
          # Graph 1 output
          fluidRow(
            box(width = 12,
                phs_spinner("EQ1_plot1"))
          ),
          hr(), # page break
          
          fluidRow(
            box(title = "This section can be expanded to view the data in the graph above as a table.",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
                dataTableOutput("EQ1_1_table")
            )
          ),
          fluidRow(
            column(4,
                   downloadButton(outputId = "EQ1_1_table_download", 
                                  label = "Download as .csv", 
                                  class = "EQ1_1_table_downloadbutton"),
                   tags$head(
                     tags$style(".EQ1_1_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .EQ1_1_table_downloadbutton { color: #FFFFFF; }")
                   )
            )
          ),
          
          hr(),   # page break
          
          
          # Second graph ---- 
          # Text above graph 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the changes over time of the ", 
                         "mortality rates for the general population and the mental ", 
                         "health population for your chosen area.",
                         br(), 
                         "This is broken down by either council area or health board of ", 
                         "residence. Please use the drop down menus to select which ", 
                         "area you wish to look at.")))
          ),
          
          # Geography Drop Down Menus
          fluidRow(
            column(6,
                   box(width = NULL,
                       uiOutput("EQ1_plot4_areaType_output"))),
            column(6,
                   box(width = NULL,
                       uiOutput("EQ1_plot4_areaName_output"))),
          ),
          
          # Graph 2 output
          fluidRow(
            box(width = 12,
                phs_spinner("EQ1_plot4"))
          ),
          hr(), # page break
          
          fluidRow(
            box(title = "This section can be expanded to view the data in the graph above as a table.",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
                dataTableOutput("EQ1_2_table")
            )
          ),
          fluidRow(
            column(4,
                   downloadButton(outputId = "EQ1_2_table_download", 
                                  label = "Download as .csv", 
                                  class = "EQ1_2_table_downloadbutton"),
                   tags$head(
                     tags$style(".EQ1_2_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .EQ1_2_table_downloadbutton { color: #FFFFFF; }")
                   )
            )
          ),
          br(),
          
          # Navigation Buttons ----
          go_2_top_bttn,
          
          br(),
          
          fluidRow(
            column(4, actionButton(inputId = "EQ1_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EF5_prevButton", 
                                   label = "Previous Page", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EQ2_nextButton", 
                                   label = "Next Page", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          )
          
          
          
          
        ), # End of fluidPage
)


# titlePanel(paste0(
#   "EQ1 - Premature mortality rate = Standardised mortality rate ",
#   "for persons in contact with mental health services")),





#   mainPanel(
#     tags$p("Below is a graph showing the changes over time."),
#     
#     fluidRow(
#       column(6,uiOutput("EQ1_plot1_areaType_output")),
#       column(6,uiOutput("EQ1_plot1_areaName_output"))
#     ),
#     
#     fluidRow(
#       plotlyOutput("EQ1_plot1"
#                    #   ,
#                    # width = "100%",
#                    # height = "50%"
#       )
#     ),
#     
#     br(),
#     # br(),
#     # fluidRow(
#     #   plotlyOutput("EQ1_plot2"
#     #                #   ,
#     #                # width = "100%",
#     #                # height = "50%"
#     #   )
#     # ),
#     # br(),
#     # br(),
#     # fluidRow(
#     #   plotlyOutput("EQ1_plot3"
#     #                #   ,
#     #                # width = "100%",
#     #                # height = "50%"
#     #   )
#     # ),
#     # br(),
#     fluidRow(
#       column(6,uiOutput("EQ1_plot4_areaType_output")),
#       column(6,uiOutput("EQ1_plot4_areaName_output"))
#     ),
#     br(),
#     fluidRow(
#       plotlyOutput("EQ1_plot4"
#                    #   ,
#                    # width = "100%",
#                    # height = "50%"
#       )
#     ),
#     br(),
#     
#     
#     
#     br(),
#     
#     go_2_top_bttn,
#     
#     # tags$a(href = '#E1_top',
#     #        icon("circle-arrow-up",
#     #             lib = "glyphicon"),
#     #        "Back to top"),
#     br(),
#     br(),
#     # ), # End of mainPanel
#     
#     
#     
#     
#     
#     fluidRow(
#       column(4, actionButton(inputId = "EQ1_scot_hub_button", 
#                              label = "Scotland Hub", icon = icon("home"),
#                              class = "navpageButton")),
#       column(4, actionButton(inputId = "EF5_prevButton", 
#                              label = "Previous Page", icon = icon("arrow-left"),
#                              class = "navpageButton")),
#       column(4, actionButton(inputId = "EQ2_nextButton", 
#                              label = "Next Page", icon = icon("arrow-right"),
#                              class = "navpageButton"))
#     )
#   ) # End of mainPanel
# ) # End of fluidPage
# )
# 
