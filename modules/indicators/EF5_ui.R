tabItem(tabName = "EF5_tab",
        fluidPage(
          h1("EF5 - % of 'did not attend appointments' for community based services of people with mental health problems"),
          h3("Last Updated: August 2024"),
          fluidRow(
            box(width = 9,
                img(src='infographics/EF5.png',
                    #width = 250, height = 200,
                class = "infographic",
                alt = EF5_infographic_alt_text)
                )
          ),
          
          fluidRow(
            box(width = 9,
                     p("The data for EF5 is sourced is sourced from Health Board returns, which may be incomplete.")
                 )
          ),
          fluidRow(
              column(4, actionButton(inputId = "EF5_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF4_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ1_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        )
