tabItem(tabName = E1_tab,
        fluidPage(
          titlePanel(paste0(
            "E1 - ")),
          mainPanel(
            h3("You are on E1"),
            fluidRow(
              column(4, actionButton(inputId = "E1_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P4_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF1_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        )
)