tabItem(tabName = "EF2_tab",
        fluidPage(
          h1("EF2 - Readmissions to hospital within 28 days of discharge"),
          h3("Last Updated: June 2024"),
          fluidRow(
                   box(width = 9,
                     img(src='infographics/EF2.png',
                         class = c("infographic", "box"),
                         alt = EF2_infographic_alt_text)
                   )
          ),
          fluidRow(
            box(width = 9,
                   p("The data for EF2 is sourced from ",
                     a(href="https://www.nssdiscovery.scot.nhs.uk/",
                       target = "_blank",
                       "Discovery"),
                     " using ", 
                     a(href="https://publichealthscotland.scot/resources-and-tools/health-intelligence-and-data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/what-are-the-smr-datasets/",
                       target = "_blank",
                       "SMR04"),
                     " data. ",
                     a(href="https://publichealthscotland.scot/services/data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/completeness/",
                       target = "_blank",
                       "Data completeness"),
                     " for SMR04 was around 90% or better when the data was accessed.")
                 )
          ),
          
          fluidRow(
              column(4, actionButton(inputId = "EF2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF3_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
          ) # End of fluidRow
        ) # End of fluidPage
) # End of tabItem