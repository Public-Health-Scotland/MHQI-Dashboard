tabItem(tabName = S2_tab,
        fluidPage(
          titlePanel("Page 5"),
          mainPanel(
            h3("You are on Page 5"),
            fluidRow(
              column(4, actionButton(inputId = "scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S1_navButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S5_navButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)