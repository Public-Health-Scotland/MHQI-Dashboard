tagList(
  
  # Title for P1 tab ----
  fluidRow(width = 12,
           h1("T1 - % of people who commence psychological therapy based treatment 
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
                      altTextUI("T1_infographic_modal"),
                      img(src='infographics/T1.png',
                          class = "infographic",
                          alt = "Over three quarters (78.3%) of people started 
                          treatment within 18 weeks of referral in the quarter 
                          ending 30 June 2025, compared to 78.6% for the previous 
                          quarter, and 80.2% for the quarter ending 30 June 2024.")
                    )
           ), 
           # Data table
           tabPanel("Data Source",
                    tagList(
                      linebreaks(1),
                      title = "Data source information and notes:",
                      p("Further information can be found in the ",
                        a(href="https://publichealthscotland.scot/publications/psychological-therapies-waiting-times/",
                          target = "_blank",
                          "Psychological Therapies Waiting Times publication."), 
                        " The publication also provides ", 
                        a(href = "https://www.opendata.nhs.scot/dataset/psychological-therapies-waiting-times",
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