tabItem(tabName = EF2_tab,
        fluidPage(
          titlePanel("EF2"),
          mainPanel(
            h3("You are on EF2"),
            fluidRow(
              column(4, actionButton(inputId = "EF2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF3_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)