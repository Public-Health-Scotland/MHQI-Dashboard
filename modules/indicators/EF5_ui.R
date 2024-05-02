tabItem(tabName = EF5_tab,
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
)