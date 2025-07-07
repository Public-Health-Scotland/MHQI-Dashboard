tabItem(tabName = "P1_tab",
        fluidPage(

            h1("P1 - % of carers with a mental health condition that felt supported to continue in their caring role"),
            h3("Last Updated: September 2024"),
            fluidRow(
              box(width = 9,
                  img(src='infographics/P1.png',
                      class = "infographic",
                      alt = P1_infographic_alt_text),
                  p("This compares with 24% of carers with a mental health condition in 2021/22.")
                  )

            ),
            
            fluidRow(
              box(width = 9,
                  h2("Data source information and notes:"),
                  p("The data is presented as a range due to it being drawn from a 
                    survey on a sample and not population data. Further information 
                    can be found in the ",
                    a(href="https://www.gov.scot/collections/health-and-care-experience-survey/",
                      target = "_blank",
                      "Health and Care Experience Survey.")), 
                  p("Next update: July 2026")
                  )
              ),  
            
          fluidRow(
              column(4, actionButton(inputId = "P1_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S5_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P2_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
