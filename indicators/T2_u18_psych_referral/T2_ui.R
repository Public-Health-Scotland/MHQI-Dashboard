tagList(
  
  # Title for P1 tab ----
  fluidRow(width = 12,
           h1("T2 - % of young people who commence treatment by 
              specialist Child and Adolescent Mental Health Services 
              within 18 weeks of referral"),
           h3("Last Updated: September 2025")
  ),
  
  linebreaks(1),
  
  fluidRow(
    tabBox(width = NULL,
           type = "pills",
           # Graph
           tabPanel("Infographic",
                    tagList(
                      linebreaks(1),
                      altTextUI("T2_infographic_modal"),
                      img(src='infographics/T2.png',
                          class = "infographic",
                          alt = "Over nine-tenths (91.8%) of children and young people 
                          started treatment within 18 weeks of referral in the quarter 
                          ending 30 June 2025. This is an increase from 91.6% in the 
                          previous quarter and 84.1% for the quarter ending 30 June 2024. 
                          Half of children and young people started treatment within 5 
                          weeks in the quarter ending 30 June 2025.")
                    )
           ), 
           # Data table
           tabPanel("Data Source",
                    tagList(
                      linebreaks(1),
                      title = "Data source information and notes:",
                      p("Further information can be found in the ",
                        a(href="https://publichealthscotland.scot/publications/child-and-adolescent-mental-health-services-camhs-waiting-times/",
                          target = "_blank",
                          "Child and Adolescent Mental Health Services in Scotland: Waiting Times publication."), 
                        " The publication also provides ", 
                        a(href = "https://www.opendata.nhs.scot/dataset/child-and-adolescent-mental-health-waiting-times", 
                          target = "_blank",
                          "NHS Board level open data.")), 
                      p("Next update: October 2026")
                    )
           )
    )
  ),
  
  # Insert go to top button
  go_2_top_bttn
)