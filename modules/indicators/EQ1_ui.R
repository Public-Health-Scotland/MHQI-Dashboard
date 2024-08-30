tabItem(tabName = "EQ1_tab",
        fluidPage(
          h1("EQ1 - Premature mortality rate = Standardised mortality rate ",
             "for persons in contact with mental health services"),
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
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the changes over time.")))
            ),
          
          fluidRow(
            box(width = 12,
                plotlyOutput("EQ1_plot1",
                             width = "100%"))
          ),
        fluidRow(
          column(6,
                 box(width = NULL,
                     uiOutput("EQ1_plot4_areaType_output"))
          ),
          column(6,
                 box(width = NULL,
                     uiOutput("EQ1_plot4_areaName_output"))
          ),
        ),
        br(),
        fluidRow(
          box(width = 12,
              plotlyOutput("EQ1_plot4",
                           width = "100%"))
        ),
        
        br(),
        
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
