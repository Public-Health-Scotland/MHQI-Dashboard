tagList(
  
  # Title for P1 tab ----
  fluidRow(width = 12,
           h1("P2 - % of adults with mental health problems supported at home who 
              agree that their services and support had an impact in improving or 
              maintaining their quality of life"),
           h3("Last Updated: July 2026")
  ),
  
  linebreaks(1),
  
  fluidRow(
    tabBox(width = NULL,
           type = "pills",
           # Graph
           tabPanel("Infographic",
                    tagList(
                      linebreaks(1),
                      altTextUI("P2_infographic_modal"),
                      img(src='infographics/P2.png',
                          class = "infographic",
                          alt = "In Scotland in 2025/26 55%  (confidence interval: 53%; 57%) 
                          of adults with a mental health condition supported at home agree 
                          that their services and support had an impact in improving or 
                          maintaining their quality of life. There was no change from the 
                          last available figure (55%) in 2023/24.")
                    )
           ),
           # Data table
           tabPanel("Data Source",
                    tagList(
                      linebreaks(1),
                      title = "Data source information and notes:",
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
           )
    )
  ),
  
  # Insert go to top button
  go_2_top_bttn
)