tabItem(tabName = "T1_tab",
        fluidPage(
          h1("T1 - % of people who commence psychological therapy based treatment within 18 weeks of referral"),
          h3("Last Updated: September 2024"),
          fluidRow(
          box(width = 9,
                img(src='infographics/T1.png',
                    class = "infographic",
                    alt = T1_infographic_alt_text)
              )
          ),
          
          fluidRow(
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
              p("Next update: October 2025")
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

        ) # End of fluidPage
) # End of tab