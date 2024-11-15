tabItem(tabName = "EQ2_tab",
        fluidPage(
          h1("EQ2 - Number of emergency detention certificates (EDCs) per 100,000 population"),
          h2("Last Updated: October 2024"),
          fluidRow(
            box(width = 9,
            img(src='infographics/EQ2.png',
                class = "infographic",
                alt = paste0(
                  "In Scotland in 2022/23, the number of emergency detention ",
                  "certificates per 100,000 population was 60.0. This is a ",
                  "slight increase from 59.5 in 2021/22.")),)
          ),
          fluidRow(
            box(width = 9,
            p("This data is sourced from the  ",
              a(href="https://www.mwcscot.org.uk/publications?type=44&leg=54",
                "Mental Welfare Commission.")),
            )
          ),
            
            fluidRow(
              column(4, actionButton(inputId = "EQ2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ4_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
        