tabItem(tabName = "P2_tab",
        fluidPage(
          titlePanel(paste0(
            "P2 - % of adults with mental health problems supported at home ",
            "who agree that their services and support had an impact in ",
            "improving or maintaining their quality of life")),
          mainPanel(
            img(src='infographics/P2.png',
                class = "infographic",
                alt = paste0(
                  "In Scotland in 2019/20 27% of carers with a mental health ",
                  "condition agreed that they felt asupported to continue caring. ",
                  "This compares with 30% of carers with a mental health condition ",
                  "in 2017/18")),
            br(),
            p("Further information can be found in the ",
              a(href="https://www.gov.scot/collections/health-and-care-experience-survey/",
                "Health and Care Experience Survey"),
              "."),
          
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
          ) # End of mainPanel
        ) # End of fluidPage
        
)