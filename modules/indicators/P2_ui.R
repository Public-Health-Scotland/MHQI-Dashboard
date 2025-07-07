tabItem(tabName = "P2_tab",
        fluidPage(
          
          h1("P2 - % of adults with mental health problems supported at home who agree that their services and support had an impact in improving or maintaining their quality of life"),
          h3("Last Updated: September 2024"),
          fluidRow(
            box(width = 9,
                img(src='infographics/P2.png',
                    class = "infographic",
                    alt = P2_infographic_alt_text))
            ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("Due to a change in the source of the indicator in 2024, the data is 
                not comparable to previous data for 2021/22. The data is presented 
                as a range due to it being drawn from a survey on a sample and 
                not population data. Further information can be found in the ",
                  a(href="https://www.gov.scot/collections/health-and-care-experience-survey/",
                    target = "_blank",
                    "Health and Care Experience Survey.")), 
                p("Next update: July 2026")
            )
          ),
          
          fluidRow(
              column(4, actionButton(inputId = "P2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P3_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
        
