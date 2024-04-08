tabItem(tabName = T1_tab,
        fluidPage(
          titlePanel("T1 - % of people who commence psychological therapy 
                           based treatment within 18 weeks of referral",
                     h5("Last Updated: Septemberr 2023")),
          mainPanel(
            h3("Text description of T1"),
            fluidRow(
              column(6, actionButton(inputId = "scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(6, actionButton(inputId = "T2_navButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          )
        ) # End of fluidPage
) # End of tab