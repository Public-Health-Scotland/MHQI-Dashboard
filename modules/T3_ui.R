tabItem(tabName = T3_tab,
        fluidPage(
          titlePanel("Page 3"),
          mainPanel(
            h3("Text description of T3"),
            fluidRow(
              column(4, actionButton(inputId = "scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T2_navButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S1_navButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)