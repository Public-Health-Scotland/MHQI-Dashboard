tabItem(tabName = "P4_tab",
        fluidPage(
          
          
          h1("P4 - Number of people with advance statements registered per year with the Mental Welfare Commission for Scotland"),
          h3("Last Updated: October 2024"),
          fluidRow(
            box(width = 9,
                img(src='infographics/P4.png',
                    class = "infographic",
                    alt = P4_infographic_alt_text)
                )
            
          ),
          
          fluidRow(
            box(width = 9,
                p("Further information can be found in the ",
                  a(href="https://www.gov.scot/collections/health-and-care-experience-survey/",
                    target = "_blank",
                    "Health and Care Experience Survey."))
                )
          ),
            
            
          # Navigation buttons
          fluidRow(
              column(4, actionButton(inputId = "P4_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P3_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "E1_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
