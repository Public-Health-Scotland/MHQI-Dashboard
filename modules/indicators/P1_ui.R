tabItem(tabName = P1_tab,
        fluidPage(
          titlePanel(paste0("P1 - % of carers with a mental health condition that ",
                            "felt supported to continue in their caring role")),
          mainPanel(
            p("This indicator has not been updated since 2020."),
          ),
          
          fluidRow(
              column(4, actionButton(inputId = "P1_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S5_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P2_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
)