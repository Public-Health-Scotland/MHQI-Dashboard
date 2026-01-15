tabItem(tabName = "EQ2_tab",
        fluidPage(
          h1("EQ2 - Number of emergency detention certificates (EDCs) per 100,000 population"),
          h3("Last Updated: January 2026"),
          fluidRow(
            box(width = 9,
            img(src='infographics/EQ2.png',
                class = "infographic",
                alt = EQ2_infographic_alt_text)
            )
          ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
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
          ),
            
            fluidRow(
              column(4, actionButton(inputId = "EQ2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ1_prevButton", 
                                     label = "Previous Page - EQ1", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ4_nextButton", 
                                     label = "Next Page - EQ4", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
        