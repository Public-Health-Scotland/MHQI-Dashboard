tabItem(tabName = P2_tab,
        fluidPage(
          titlePanel("P2"),
          mainPanel(
            h3("You are on P2"),
            fluidRow(
              column(4, actionButton(inputId = "P2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P3_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)