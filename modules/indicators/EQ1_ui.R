tabItem(tabName = "EQ1_tab",
        fluidPage(
          titlePanel("EQ1 - Premature mortality rate = Standardised mortality rate for persons in contact with mental health services"),
          mainPanel(
            img(src='infographics/EQ1.png',
                class = "infographic",
                alt = paste0(
                  "The mortality rate for persons in contact with the mental ",
                  "health service in Scotland is 2.71 times higher than the ",
                  "mortality rate for the general population when ",
                  "standardised by age and sex in 2021/22. This compares ",
                  "with 2.62 in 2020/21.")),
            br(),
            p("The data for EQ1 are sourced from SMR04 and death registrations ",
              a(href="https://www.nrscotland.gov.uk/statistics-and-data/statistics/statistics-by-theme/vital-events/deaths/deaths-background-information",
                "(National Records of Scotland; NRS)."))
          ),
          
            fluidRow(
              column(4, actionButton(inputId = "EQ1_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF5_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ2_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )   # End of fluidPage
        )
