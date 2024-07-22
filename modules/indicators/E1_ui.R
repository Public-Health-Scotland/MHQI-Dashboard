tabItem(tabName = "E1_tab",
        fluidPage(
          titlePanel(paste0(
            "E1 - Number of days people spend in hospital when they are ",
            "clinically ready to be discharged (per 1,000 population)")),
          mainPanel(
            tags$p("Below is a graph showing the changes over time."),
            
            fluidRow(
              column(6,uiOutput("E1_plot1_areaType_output")),
              column(6,uiOutput("E1_plot1_areaName_output"))
            ),

            fluidRow(
              plotlyOutput("E1_plot1"
                         #   ,
                         # width = "100%",
                         # height = "50%"
                         )
            ),
            br(),
            # dataTableOutput("diagnoses_table"),
            br(),
            br(),

            
            tags$p("Below is a graph showing a comparison between health boards and NHS Scotland for your selected financial year."),
            # br(),
            # tags$p(paste0("Below is a graph showing a comparison between health boards for year "), E1_plot2_year_output),   # MS: this is wrong
            
            fluidRow(
               column(6,uiOutput("E1_plot2_year_output"))
            ),
            
            fluidRow(
               plotlyOutput("E1_plot2"
                            #   ,
                            # width = "100%",
                            # height = "50%"
               )
            ),
            br(),
            tags$p("Source: Delayed discharges in NHS Scotland annual publication", 
                   br(), 
                   "For ages 18 years and above"),
            # as copied from above -- dataTableOutput("diagnoses_table"),
            br(),
            br(),
            
            go_2_top_bttn,

            # tags$a(href = '#E1_top',
            #        icon("circle-arrow-up",
            #             lib = "glyphicon"),
            #        "Back to top"),
            br(),
            br(),
          # ), # End of mainPanel
          
          
          
          
          
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
          )
         )
      )
)
