tabItem(tabName = "T1_tab",
        fluidPage(
<<<<<<< Updated upstream
          h1("T1 - % of people who commence psychological therapy based treatment within 18 weeks of referral"),
          h3("Last Updated: September 2025"),
=======
          ## Title section ----
          h1(paste0(
            "T1 - Percentage (%) of patients seen 0 to 18 weeks after referral to start psychological therapy based treatment")),
          h3("Last Updated: October 2026"),
          
          hr(),       # page break
          
          
          ### [ T1 Health Board Trends ] ----
          
          ## Page separator ----
          h2("T1 - Section 1: Time Trend"),
          
          ## Text above Graph ---- 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                         "Below is an interactive graph showing the percentage of patients seen per quarter
                         who started treatment in psychological therapy within 18 weeks of referral.")),
                       p(paste0("Use the drop down menu to select a specific NHS Health Board.")))
            )), # end of fluidRow
          
          
          
          ## Graph selectors ---- 
          
>>>>>>> Stashed changes
          fluidRow(
          box(width = 9,
                img(src='infographics/T1.png',
                    class = "infographic",
                    alt = "Over three quarters (78.3%) of people started treatment within 18 weeks of referral in the quarter ending 30 June 2025, 
                    compared to 78.6% for the previous quarter, and 80.2% for the quarter ending 30 June 2024.")
              )
          ),
          
          fluidRow(
<<<<<<< Updated upstream
          box(width = 9,
              h2("Data source information and notes:"),
              p("Further information can be found in the ",
                a(href="https://publichealthscotland.scot/publications/psychological-therapies-waiting-times/",
                  target = "_blank",
                  "Psychological Therapies Waiting Times publication."), 
                " The publication also provides ", 
                a(href = "https://www.opendata.nhs.scot/dataset/psychological-therapies-waiting-times",
                  target = "_blank",
                  "NHS Board level open data.")), 
              p("Next update: October 2026")
              )
          ),
          
              fluidRow(
                column(4, actionButton(inputId = "T1_scot_hub_button", 
                                       label = "Scotland Hub", icon = icon("home"),
                                       class = "navpageButton")),
                column(4, actionButton(inputId = "data_prevButton", 
                                       label = "Data Tab", icon = icon("arrow-left"),
                                       class = "navpageButton")),
                column(4, actionButton(inputId = "T2_nextButton", 
                                       label = "Next Page - T2", icon = icon("arrow-right"),
                                       class = "navpageButton"))
              )
=======
            box(width = 12,
                title = paste0(
                  "Percentage (%) of patients seen 0 to 18 weeks after referral to psychological therapy based treatment
                  by quarter, in selected NHS health board"), 
                phs_spinner("T1_trendPlot"))   # spinner shows spinning circle while graph loads
          ),
          
          
#            ## Graph 1 data table ----
fluidRow(
  box(title = HTML(paste("Below is a table showing the data used to create the 
                                     above graph. It can be downloaded using the 'Download as .csv' 
                                     button underneath this section.", 
                         sep = "<br/>")),
      width = 12, 
      solidHeader = TRUE, 
      collapsible = TRUE, collapsed = FALSE,
      dataTableOutput("T1_1_table"))
),            


## Download button for table 1 ----
fluidRow(
  column(4,
         downloadButton(outputId = "T1_1_table_download", 
                        label = "Download as .csv", 
                        class = "tableDownloadButton"))
),




          hr(), # page break


          ## Data source information  ----

          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("Please note NHS 24 and NHS Golden Jubilee are included in the NHS Scotland total. 
                  NHS Golden Jubilee has only been included in the national total since April 2025. NHS 24
                  January to March 2026 is not currently available. As a result, NHS Scotland totals from 
                  April 2025 onwards are not directly comparable with earlier periods."),
                p("Further information can be found in the ",
                  a(href="https://publichealthscotland.scot/publications/psychological-therapies-waiting-times/",
                    target = "_blank",
                    "Psychological Therapies Waiting Times publication.")),
                p("Next update: January 2027")
            )
          ),

          fluidRow(
            column(4, actionButton(inputId = "T1_scot_hub_button",
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "data_prevButton",
                                   label = "Data Tab", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "T2_nextButton",
                                   label = "Next Page - T2", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          )
>>>>>>> Stashed changes

        ) # End of fluidPage
) # End of tab