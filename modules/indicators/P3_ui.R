tabItem(tabName = P3_tab,
        fluidPage(
          titlePanel(paste0('P3 - % of replies for people with mental health ',
                            'problem that agree with statement ',
                     '"people took account of the things that mattered to me"')),
          mainPanel(
            p("This indicator has not been updated since 2020.")
            ),
          
          # Navigation buttons
          fluidRow(
              column(4, actionButton(inputId = "P3_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "p2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "p4_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
)