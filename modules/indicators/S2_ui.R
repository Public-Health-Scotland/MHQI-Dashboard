tabItem(tabName = S2_tab,
        fluidPage(
          titlePanel("S2:"),
          mainPanel(
            h3("You are on Page 5"),
            fluidRow(
              column(4, actionButton(inputId = "S2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S5_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton")))
          ) # End of mainPanel
        ) # End of fluidPage
) # End of tabItem