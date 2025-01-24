tabItem(tabName = "EF4_tab",
        fluidPage(
          # Defining the title
          h1("EF4 - Total mental health spend as a % of total spend"),
          h3("Last Updated: February 2024"),
          
          hr(),      # page break
          
          ## Text Above Graph ----
          fluidRow(
             column(12,
                    box(width = NULL,
                        p(paste0(
                           "Below is a graph showing the percentage (%) of your selected ", 
                           "NHS Health Board's total spend that is attributable to total mental ", 
                           "health spend for each financial year. ",
                           "Use the drop down menus to select which Health Board and ", 
                           "measure(s) you wish to look at."))
                        )
             )), # end of fluidRow
          ## Drop down menus ---- 
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
            
          ## Graph output ---- 
          fluidRow(
            box(width = 12,
                plotlyOutput("EF4_trendPlot",
                             # height = "50vh",
                             width = "100%"))
            ),
          hr(), # page break
          
          fluidRow(
            box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("EF4_table")
            )
          ),
          fluidRow(
            column(4,
                   downloadButton(outputId = "EF4_table_download", 
                                  label = "Download as .csv", 
                                  class = "EF4_table_downloadbutton"),
                   tags$head(
                     tags$style(".EF4_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .EF4_table_downloadbutton { color: #FFFFFF; }")
                   )
            )
          ),
          
          
          hr(), # page break
          
          # Data source information  ----        
          fluidRow(
            column(12,
                box(width = NULL,
                    p("These data are sourced from data collected annually by Public Health Scotland (PHS) on expenditure within NHS Scotland, released in an ",
                      a(href="https://publichealthscotland.scot/media/25950/nhsscotland-mental-health-expenditure-2022-23.xlsx",
                        target = "_blank",
                         "excel workbook "),
                      "which also includes data for organisations providing these services (14 territorial NHS Boards and the State Hospital at Carstairs Lanarkshire), as part of the ",
                      a(href="https://publichealthscotland.scot/publications/scottish-health-service-costs/scottish-health-service-costs-summary-for-financial-year-2022-to-2023/",
                        target = "_blank",
                        "annual release of National Statistics covering expenditure in the financial year 2022/23."), 
                      " Data quality issues or inconsistencies are covered in the data found here."))
          )
          ),
          
          br(), 
          
          # Navigation Buttons ----  
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
            ),
          # Insert go to top button
          go_2_top_bttn
          
        ) # End of fluidPage
)
        