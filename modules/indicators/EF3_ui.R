tabItem(tabName = "EF3_tab",
        fluidPage(
          h1("EF3 - Total psychiatric inpatient beds per 100,000 population (NRAC adjusted)"),
          h2("Last Updated: September 2024"),
          fluidRow(
            box(width = 9,
            img(src='infographics/EF3.png',
                class = "infographic",
                alt = EF3_infographic_alt_text)
            )
          ),
          fluidRow(
            box(width = 9,
            p("The numerator for EF3 is sourced from ",
              a(href="https://publichealthscotland.scot/publications/acute-hospital-activity-and-nhs-beds-information-annual/",
                "the Acute hospital activity and NHS beds information annual release publication, "),
              "and the denominator is sourced from ",
              a(href="https://www.publichealthscotland.scot/publications/resource-allocation-formula-nrac/resource-allocation-formula-nrac-for-nhsscotland-results-for-financial-year-2024-to-2025/",
                "the National Resource Allocation publication.")),
            )
          ),
          
          fluidRow(
              column(4, actionButton(inputId = "EF3_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF4_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
        
