tabItem(tabName = "P3_tab",
        fluidPage(
          
          h1("P3 - % of replies for people with mental health problem that agree with statement 'people took account of the things that mattered to me'"),
          h3("Last Updated: June 2026"),
          fluidRow(
            box(width = 9,
                img(src='infographics/P3.png',
                    class = "infographic",
                    alt = P3_infographic_alt_text))
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
          
  
          # Navigation buttons
          fluidRow(
              column(4, actionButton(inputId = "P3_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P2_prevButton", 
                                     label = "Previous Page - P2", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P4_nextButton", 
                                     label = "Next Page - P4", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
