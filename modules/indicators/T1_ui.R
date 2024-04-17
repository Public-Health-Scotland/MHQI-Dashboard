tabItem(tabName = T1_tab,
        fluidPage(
          titlePanel(h1("T1 - % of people who commence Psychological therapy 
                           based treatment within 18 weeks of referral"),
                     h2("Last Updated: Septemberr 2023")),
          mainPanel(
            img(src='infographics/T1_20230921.png',
                class = "infographic",
                alt = paste0("More than four fifths (84.4%) of people started treatment within 18 weeks of referral in the quarter ending 31 December 2021", 
                "compared to 87.2% for the previous quarter, and 80% for the quarter ending 31 December 2020")),
            br(),
            p("Further information can be found in the ",
              a(href="https://publichealthscotland.scot/publications/psychological-therapies-waiting-times/",
                "Psychological Therapies Waiting Times publication"),
              ".")
          ),
          fluidRow(
            column(6, actionButton(inputId = "T1_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(6, actionButton(inputId = "T2_nextButton", 
                                   label = "Next Page - T2", icon = icon("arrow-right"),
                                   class = "navpageButton"))
            )
        ) # End of fluidPage
) # End of tab