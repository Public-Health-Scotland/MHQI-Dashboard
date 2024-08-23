tabItem(tabName = "EF2_tab",
        fluidPage(
          h1("EF2 - Readmissions to hospital within 28 days of discharge"),
          fluidRow(
                   box(width = NULL,
                     img(src='infographics/EF2.png',
                         class = c("infographic", "box"),
                         alt = paste0(
                           "The percentage of emergency readmissions within 28 days in ",
                           "Scotland was 7.3% for the year-long period ending 31 March ",
                           "2023. This compares with 7.8% for the year ending 31 March ",
                           "2022 and 9.3% for the year ending 31 March 2021."))


          ),

                 box(width = NULL,
                   p("The data for EF1 is sourced from ",
                     a(href="https://www.nssdiscovery.scot.nhs.uk/",
                       "Discovery"),
                     " using SMR04 data.",
                     a(href="https://publichealthscotland.scot/services/data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/completeness/",
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