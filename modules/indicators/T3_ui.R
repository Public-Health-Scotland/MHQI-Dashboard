tabItem(tabName = T3_tab,
        fluidPage(
          titlePanel("T3"),
          mainPanel(
            h3("Text description of T3"),
            fluidRow(
              column(4, actionButton(inputId = "T3_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T2_prevButton", 
                                     label = "Previous Page: T2", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S1_nextButton", 
                                     label = "Next Page: S1", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)