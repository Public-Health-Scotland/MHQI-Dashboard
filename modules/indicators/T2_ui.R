tabItem(tabName = "T2_tab",
        fluidPage(
          h1("T2 - % of young people who commence treatment by 
                               specialist Child and Adolescent Mental Health services 
                               within 18 weeks of referral"),
          h2("Last Updated: September 2024"),
          fluidRow(
            box(width = 9,
            img(src='infographics/T2.png',
                class = "infographic",
                alt = paste0(
                  "Over seven out of ten (70.3%) children and young people ",
                  "started treatment within 18 weeeks of referral in the quarter ",
                  "ending 31 December 2021. This is a decrease from 78.6% in the ",
                  "previous quarter, and 73.1% in the quarter ending 31 December 2020. ",
                  "Half of children and young people started treatment within seven ",
                  "weeks in the quarter ending 31 December 2021")),
            )
          ),
          fluidRow(
            box(width = 9,
            p("Further information can be found in the ",
              a(href="https://publichealthscotland.scot/publications/child-and-adolescent-mental-health-services-camhs-waiting-times/",
                "Child and Adolescent Mental Health Services in Scotland: Waiting Times publication"),
              "."),
            )
          ),
          fluidRow(
              column(4, actionButton(inputId = "T2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T1_prevButton", 
                                     label = "Previous Page: T1", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T3_nextButton", 
                                     label = "Next Page: T3", icon = icon("arrow-right"),
                                     class = "navpageButton"))
              )
          ) # End of fluidPage
        ) 
