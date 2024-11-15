tabItem(tabName = "S1_tab",
        fluidPage(
          
          h1("S1 - Suicide Rates per 100,000 population"),
          h2("Last Updated: August 2024"),
          fluidRow(
            box(width = 9,
                img(src='infographics/S1.png',
                    class = "infographic",
                    alt = S1_infographic_alt_text)
            )
            
          ),
          
          fluidRow(
            box(width = 9,
                p(paste0(
                  "Further information can be found in the [THIS LINK IS BROKEN]",
                  a(href="https://www.scotpho.org.uk/health-wellbeing-and-disease/suicide/key-points/",
                  "ScotPHO website"),
                  ".")),
            ),
          ), 
          
          
          fluidRow(
            column(4, actionButton(inputId = "S1_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "T3_prevButton", 
                                   label = "Previous Page", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "S2_nextButton", 
                                   label = "Next Page", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          )
          ) # End of fluidPage
        ) 
