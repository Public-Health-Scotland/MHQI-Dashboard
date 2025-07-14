tabItem(tabName = "T2_tab",
        fluidPage(
          h1("T2 - % of young people who commence treatment by 
                               specialist Child and Adolescent Mental Health Services 
                               within 18 weeks of referral"),
          h3("Last Updated: September 2024"),
          fluidRow(
            box(width = 9,
            img(src='infographics/T2.png',
                class = "infographic",
                alt = T2_infographic_alt_text)
            )
          ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("Further information can be found in the ",
                  a(href="https://publichealthscotland.scot/publications/child-and-adolescent-mental-health-services-camhs-waiting-times/",
                    target = "_blank",
                    "Child and Adolescent Mental Health Services in Scotland: Waiting Times publication."), 
                  " The publication also provides ", 
                  a(href = "https://www.opendata.nhs.scot/dataset/child-and-adolescent-mental-health-waiting-times", 
                    target = "_blank",
                    "NHS Board level open data.")), 
                p("Next update: October 2025")
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
