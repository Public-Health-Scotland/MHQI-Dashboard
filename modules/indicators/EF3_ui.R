tabItem(tabName = EF3_tab,
        fluidPage(
          titlePanel("EF3"),
          mainPanel(
            h3("You are on EF3"),
            fluidRow(
              column(4, actionButton(inputId = "EF3_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF4_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)