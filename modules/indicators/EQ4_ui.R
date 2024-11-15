tabItem(tabName = "EQ4_tab",
        fluidPage(
          h1("EQ4 - % of under 18 year old psychiatric admissions admitted out with NHS specialist Child and Adolescent Mental Health (CAMH) wards"),
          h2("Last Updated: June 2024"),
          fluidRow(
            box(width = 9,
            img(src='infographics/EQ4.png',
                class = "infographic",
                alt = EQ4_infographic_alt_text)
            )
          ),
          fluidRow(
            box(width = 9,
            p("The data for EQ4 is sourced from  ",
              a(href="https://www.publichealthscotland.scot/services/discovery/#section-1-1",
                "Discovery.")),
            )
          ),
            
            fluidRow(
              column(4, actionButton(inputId = "EQ2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ4_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        )
        