tabItem(tabName = P4_tab,
        fluidPage(
          titlePanel(paste0("P4 - Number of people with advance statements ",
                            "registered per year with the Mental Welfare ",
                            "Commission for Scotland")),
          mainPanel(
            p("This indicator has not been updated since 2021.")
            ),
          
          # Navigation buttons
          fluidRow(
              column(4, actionButton(inputId = "P4_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P3_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "E1_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
        ) # End of fluidPage
)