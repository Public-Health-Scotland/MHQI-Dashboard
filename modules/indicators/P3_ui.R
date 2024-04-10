tabItem(tabName = P3_tab,
        fluidPage(
          titlePanel("P3"),
          mainPanel(
            h3("You are on P3"),
            fluidRow(
              column(4, actionButton(inputId = "P3_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "p2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "p4_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)