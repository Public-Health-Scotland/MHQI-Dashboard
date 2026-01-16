tabItem(tabName = "P4_tab",
        fluidPage(
          
          
          h1("P4 - Number of people with advance statements registered per year 
             with the Mental Welfare Commission for Scotland"),
          h3("Last Updated: January 2026"),
          fluidRow(
            box(width = 9,
                img(src='infographics/P4.png',
                    class = "infographic",
                    alt = P4_infographic_alt_text)
                )
            
          ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
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
          ),  
            
            
          # Navigation buttons
          fluidRow(
              column(4, actionButton(inputId = "P4_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P3_prevButton", 
                                     label = "Previous Page - P3", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "E1_nextButton", 
                                     label = "Next Page - E1", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
