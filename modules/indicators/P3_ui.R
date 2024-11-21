tabItem(tabName = "P3_tab",
        fluidPage(
          
          h1("P3 - % of replies for people with mental health problem that agree with statement 'people took account of the things that mattered to me'"),
          h3("Last Updated: September 2024"),
          fluidRow(
            box(width = 9,
                img(src='infographics/P3.png',
                    class = "infographic",
                    alt = P3_infographic_alt_text),
                p("Due to change in the source of the indicator, the data is not comparable to previous data for 2021/22.")
                )
            
          ),
          
          fluidRow(
            box(width = 9,
                p("Further information can be found in the ",
                  a(href="https://www.gov.scot/collections/health-and-care-experience-survey/",
                    "Health and Care Experience Survey"),"."),
            ),
          ),
          
  
          # Navigation buttons
          fluidRow(
              column(4, actionButton(inputId = "P3_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "p2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "p4_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
