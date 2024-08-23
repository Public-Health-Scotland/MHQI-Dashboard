tabItem(tabName = "EF4_tab",
        fluidPage(
          # Defining the title
          h1("EF4 - Total mental health spend as a % of total spend"),
          fluidRow(
            column(6,
                   box(width = NULL,
                       uiOutput("EF4_trendPlot_hbName_output"))
                   ),
            column(6,
                   box(width = NULL,
                       uiOutput("EF4_trendPlot_measure_output"))
                   ),
                ),
            # ),
          fluidRow(
            box(width = 12,
                plotlyOutput("EF4_trendPlot",
                             # height = "50vh",
                             width = "100%"))
            ),
          fluidRow(
            column(12,
                box(width = NULL,
                    p("These data are sourced from data collected annually by Public Health Scotland (PHS) on expenditure within NHS Scotland, released in an ",
                      a(href="https://publichealthscotland.scot/media/17844/nhsscotland-mental-health-expenditure.xlsx",
                         "excel workbook "),
                      "which also includes data for organisations providing these services (14 territorial NHS Boards and the State Hospital at Carstairs Lanarkshire), as part of the ",
                      a(href="https://publichealthscotland.scot/publications/scottish-health-service-costs/scottish-health-service-costs-high-level-costs-summary-2021-to-2022/",
                        "annual release of National Statistics covering expenditure in the financial year 2021/22.")))
          ),
          
          ),
            
          fluidRow(
              column(4, actionButton(inputId = "EF4_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF3_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF5_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
        ) # End of fluidPage
)
        