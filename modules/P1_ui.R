tabItem(tabName = P1_tab,
        fluidPage(
          titlePanel("P1"),
          mainPanel(
            h3("You are on P1"),
            fluidRow(
              column(4, actionButton(inputId = "scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S1_navButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P2_navButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)