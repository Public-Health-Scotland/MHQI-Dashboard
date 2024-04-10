tabItem(tabName = T2_tab,
        fluidPage(
          titlePanel("T2"),
          mainPanel(
            h3("Text description of T2"),
            fluidRow(
              column(4, actionButton(inputId = "T2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T1_prevButton", 
                                     label = "Previous Page: T1", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T3_nextButton", 
                                     label = "Next Page: T3", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)