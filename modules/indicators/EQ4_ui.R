tabItem(tabName = EQ4_tab,
        fluidPage(
          titlePanel("EQ4"),
          mainPanel(
            h3("You are on EQ4"),
            fluidRow(
              column(4, actionButton(inputId = "EQ2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ4_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton"))
            )
          )
        )
)