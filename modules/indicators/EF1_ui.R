tabItem(tabName = "EF1_tab",
        fluidPage(
          h1("EF1 - Rate of emergency bed days for adults"),
          h3("Last Updated: June 2024"),
          fluidRow(
            box(width = 9,
            img(src='infographics/EF1.png',
                class = "infographic",
                alt = EF1_infographic_alt_text)
            )
          ),
          fluidRow(
            box(width = 9,
            p("The data for EF1 is sourced from ",
              a(href="https://www.nssdiscovery.scot.nhs.uk/",
                "Discovery"),
              " using SMR04 data.",
              a(href="https://publichealthscotland.scot/services/data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/completeness/",
                "Data completeness"),
              " for SMR04 was around 90% or better when the data was accessed."),
            )
          ),
          
          fluidRow(
              column(4, actionButton(inputId = "EF1_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "E1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF2_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
          )
        ) # End of fluidPage
        )
