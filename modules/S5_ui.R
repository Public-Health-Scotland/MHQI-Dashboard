tabItem(tabName = S5_tab,
        fluidPage(
          titlePanel("Page 6"),
          mainPanel(
            h3("You are on Page 6"),
            fluidRow(
              column(4, actionButton(inputId = "scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S2_navButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P1_navButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of mainPanel
        ) # End of fluidPage
)