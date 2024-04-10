tabItem(tabName = S1_tab,
        fluidPage(
          titlePanel("S1"),
          mainPanel(
            h3("You are on Page 4"),
            fluidRow(
              column(4, actionButton(inputId = "S1_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T3_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S2_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)