tagList(
  
  # Title for P1 tab ----
  fluidRow(width = 12,
           h1("P4 - Number of people with advance statements registered  
             with the Mental Welfare Commission for Scotland"),
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
                      altTextUI("P4_infographic_modal"),
                      img(src='infographics/P4.png',
                          class = "infographic",
                          alt = "In Scotland in 2024/25, there were 175 new advance 
                          statements registered with MWC, this compares with 153 
                          new statements in 2023/24, 162 new statements in 2022/23 
                          and 117 in 2021/22.")
                    )
           ), 
           # Data table
           tabPanel("Data Source",
                    tagList(
                      linebreaks(1),
                      title = "Data source information and notes:",
                      p("This data is sourced from the ", 
                        a(href = "https://www.mwcscot.org.uk/publications?type=44&leg=54",
                          target = "_blank",
                          "Mental Welfare Commission (MWC).")),
                      p("The advance statement register has been in operation since 2017. 
                Advance statements are written statements made by a person when 
                they are well, setting out the care and treatment they would prefer 
                or would dislike should they become mentally unwell in the future. 
                Since 2017, each time someone either writes a statement or withdraws 
                  a statement, health boards should notify the Mental Welfare 
                  Commission for Scotland. More information about advance statements 
                  can be found in pages 31 and 32 of the ", 
                        a(href = "https://www.mwcscot.org.uk/sites/default/files/2025-11/MHA-MonitoringReport_2024-25_0.pdf",
                          target = "_blank", 
                          "Mental Welfare Commission for Scotland Mental Health Act 
                    monitoring report 2024-25.")),
                      p("It is assumed that the drop in individuals who had a first 
                  engagement with the advance statement register in 2020/21 
                  indicates a significant impact of the pandemic on service's 
                  ability to engage with individuals on matters to do with advance 
                  care planning."),
                      p("Next update: January 2027")
                    )
           )
    )
  ),
  
  # Insert go to top button
  go_2_top_bttn
)