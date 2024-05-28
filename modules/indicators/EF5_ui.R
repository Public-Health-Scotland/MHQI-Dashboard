tabItem(tabName = EF5_tab,
        fluidPage(
          titlePanel("EF5 - % of did not attend appointments for community based services of people with mental health problems"),
          mainPanel(
            img(src='infographics/EF5.png',
                class = "infographic",
                alt = paste0(
                  "The percentage of people who did not attend their ",
                  "appointment for mental health problems at community based ",
                  "services ranged from 8% to 19% for the quarter ending 30 ",
                  "June 2023.")),
            br(),
            p("The data for EF5 is sourced is sourced from health board returns, which may be incomplete.")
          ),
          
          fluidPage(
          titlePanel("EF5"),
          mainPanel(
            h3("You are on EF5"),
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
          )
        )
)   # End of fluidPage
)