tagList(
  
  # Title for P1 tab ----
  fluidRow(width = 12,
           h1("EQ2 - Number of emergency detention certificates (EDCs) per 100,000 population"),
           h3("Last Updated: January 2026")
  ),
  
  linebreaks(1),
  
  fluidRow(
    tabBox(width = NULL,
           type = "pills",
           # Graph
           tabPanel("Infographic",
                    tagList(
                      linebreaks(1),
                      altTextUI("EQ2_infographic_modal"),
                      img(src='infographics/EQ2.png',
                          class = "infographic",
                          alt = "In Scotland in 2024/25, the number of emergency 
                          detention certificates per 100,000 population was 69.8. 
                          This is a slight increase from 66.8 in 2023/24.")
                    )
           ), 
           # Data table
           tabPanel("Data Source",
                    tagList(
                      linebreaks(1),
                      title = "Data source information and notes:",
                      p("This data is sourced from the  ",
                        a(href = "https://www.mwcscot.org.uk/publications?type=44&leg=54",
                          target = "_blank",
                          "Mental Welfare Commission"), 
                        " (MWC) and is calculated using the number of EDC notifications 
                        received by the MWC and Scottish mid-year population estimates."),
                      p("Emergency detention certificates (EDCs) are a type of compulsory 
                        treatment under the Mental Health (Care and Treatment) Scotland 
                        Act 2003. Emergency detention certificates (EDCs) are designed to 
                        be used only in crisis situations to detain a person who requires 
                        urgent care or treatment for mental ill health. An EDC can be issued 
                        by any doctor, with the input of a mental health officer (MHO), 
                        which allows someone to be kept in hospital for up to 72 hours. 
                        For further information on this data and compulsory treatment under 
                        the Mental Health act, see from page 10 of the ", 
                        a(href = "https://www.mwcscot.org.uk/sites/default/files/2025-11/MHA-MonitoringReport_2024-25_0.pdf", 
                          target = "_blank", 
                          "Mental Welfare Commission for Scotland Mental Health Act monitoring report 2024-25.")),
                      p("Next update: January 2027")
                    )
           )
    )
  ),
  
  # Insert go to top button
  go_2_top_bttn
)