tabItem(tabName = "EQ1_tab",
        fluidPage(
          titlePanel("EQ1"),
          mainPanel(
            h3("You are on EQ1"),
            fluidRow(
              column(4, actionButton(inputId = "EQ1_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF5_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ2_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)