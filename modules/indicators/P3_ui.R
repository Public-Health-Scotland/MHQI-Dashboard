tabItem(tabName = "P3_tab",
        fluidPage(
          titlePanel(paste0('P3 - % of replies for people with mental health ',
                            'problem that agree with statement ',
                     '"people took account of the things that mattered to me"')),
          mainPanel(
            img(src='infographics/P3.png',
                class = "infographic",
                alt = paste0(
                  "In Scotland in 2019/20 78% of people with a mental health ",
                  "problem agreed that people took account of the things that ",
                  "mattered to them, compared to 80% of people with a mental ",
                  "health problem in 2017/18")),
            br(),
            p("Further information can be found in the ",
              a(href="https://www.gov.scot/collections/health-and-care-experience-survey/",
                "Health and Care Experience Survey"),
              ".")
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