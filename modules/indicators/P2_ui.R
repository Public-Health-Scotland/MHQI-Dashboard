tabItem(tabName = "P2_tab",
        fluidPage(
          
          h1("P2 - % of adults with mental health problems supported at home who agree that their services and support had an impact in improving or maintaining their quality of life"),
          h3("Last Updated: July 2026"),
          fluidRow(
            box(width = 9,
                img(src='infographics/P2.png',
                    class = "infographic",
                    alt = P2_infographic_alt_text))
            ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("*The filter question used to identify individuals with a mental health
                  condition in the  Health and Care Experience (HACE) Survey changed between 2023/24 and 2025/26. In 2023/24, respondents were
                  asked if they had a condition lasting 12 months with 'mental health condition' being one of the options
                  to tick. In 2025/26, respondents were asked if they had any conditions lasting 12 months
                  or more. Only those that answered yes to this question were then asked about areas this affected
                  with 'mental health' being one of the options to tick. Further information can be found in the",
                  a(href="https://www.gov.scot/collections/health-and-care-experience-survey/",
                    target = "_blank",
                    "Health and Care Experience Survey.")), 
                p("The HACE survey is an online and postal survey sent to a random 
                    sample of people registered with a general practice in Scotland. 
                    As a successor to the GP and Local NHS Services Patient Experience 
                    Survey, it has been run every two years since 2009. The survey 
                    asks about people’s experiences of:"),
                p("- Accessing and using their general practice and out of hours 
                  services."), 
                p("- Aspects of care and support provided by local authorities 
                  and other organisations."), 
                p("- Caring responsibilities and related support."),
                p("Next update: July 2028")
            )
          ),
          
          fluidRow(
              column(4, actionButton(inputId = "P2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P1_prevButton", 
                                     label = "Previous Page - P1", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P3_nextButton", 
                                     label = "Next Page - P3", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
        
