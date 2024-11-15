tabItem(tabName = "P1_tab",
        fluidPage(

            h1("P1 - % of carers with a mental health condition that felt supported to continue in their caring role"),
            h2("Last Updated: September 2024"),
            fluidRow(
              box(width = 9,
                  img(src='infographics/P1.png',
                      class = "infographic",
                      alt = P1_infographic_alt_text)
                  )

            ),
            
            fluidRow(
              box(width = 9,
                  p("Further information can be found in the ",
                    a(href="https://www.gov.scot/collections/health-and-care-experience-survey/",
                      "Health and Care Experience Survey"),"."),
              ),
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
