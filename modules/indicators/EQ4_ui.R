tabItem(tabName = "EQ4_tab",
        fluidPage(
          h1("EQ4 - % of under 18 year old psychiatric admissions admitted out with NHS specialist Child and Adolescent Mental Health (CAMH) wards"),
          fluidRow(
            box(width = 9,
            img(src='infographics/EQ4.png',
                class = "infographic",
                alt = paste0(
                  "30.1% of under 18 year old psychiatric admissions were ",
                  "admitted outwith NHS specialist CAMH wards during the ",
                  "year-long period ending 31 March 2023. This compares with ",
                  "35.5% during the year ending 31 March 2022, and 29.3% ",
                  "during the year ending 31 March 2021.")),
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
        