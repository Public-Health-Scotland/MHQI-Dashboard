tabItem(tabName = EF1_tab,
        fluidPage(
          titlePanel("EF1"),
          mainPanel(
            h3("You are on EF1"),
            fluidRow(
              column(4, actionButton(inputId = "EF1_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "E1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF2_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)