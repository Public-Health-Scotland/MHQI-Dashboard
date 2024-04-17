tabItem(tabName = P2_tab,
        fluidPage(
          titlePanel(paste0("P2 - % of adults with mental health problems ",
                            "supported at home who agree that their services and ",
                            "support had an impact in improving or maintaining ",
                            "their quality of life")),
          mainPanel(
            p("This indicator has not been updated since 2020.")
          ),
          
          fluidRow(
              column(4, actionButton(inputId = "P2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P3_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        
)