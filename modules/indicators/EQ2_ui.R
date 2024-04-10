tabItem(tabName = EQ2_tab,
        fluidPage(
          titlePanel("EQ2"),
          mainPanel(
            h3("You are on EQ2"),
            fluidRow(
              column(4, actionButton(inputId = "EQ2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ4_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)