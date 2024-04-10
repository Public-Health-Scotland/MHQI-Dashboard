tabItem(tabName = S5_tab,
        fluidPage(
          titlePanel("S5"),
          mainPanel(
            h3("You are on S5"),
            fluidRow(
              column(4, actionButton(inputId = "S5_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P1_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of mainPanel
        ) # End of fluidPage
)