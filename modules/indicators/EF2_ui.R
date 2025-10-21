tabItem(tabName = "EF2_tab",
        fluidPage(
          h1("EF2 - Mental health emergency readmissions to hospital within 28 days of discharge"),
          h3("Last Updated: September 2025"),
          fluidRow(
                   box(width = 9,
                     img(src='infographics/EF2.png',
                         class = c("infographic", "box"),
                         alt = EF2_infographic_alt_text)
                   )
          ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("The data for EF2 is sourced from ",
                  a(href = "https://www.nssdiscovery.scot.nhs.uk/",
                    target = "_blank",
                    "Discovery"),
                  " using SMR04 (Scottish Morbidity Records) data ", 
                  a("(see Glossary for more information on SMR04).",
                    href = "#shiny-tab-glossary", 
                    "data-toggle" = "tab"),
                  " NHS Board level data is available from the Discovery 
                  online management information system to health and social care 
                  staff from organisation across Scotland including: Scottish 
                  Government, territorial and special health boards, local 
                  authorities and health and social care partnerships. Discovery 
                  is not open to members of the public, the press, academia, or 
                  researchers.
                  
                  At time of data extraction data completeness was unavailable for State Hospital (due to issues with their system)
                  and was below 90% for NHS Forth Valley and NHS Highland. Data completeness 
                  for Scotland overall at the time of data extraction was 96%, well above the NHS Scotland 90% threshold for 
                  publications. Estimates of completeness of 
                  SMR records in recent years can be found ", 
                  a(href = "https://publichealthscotland.scot/resources-and-tools/health-intelligence-and-data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/completeness/", 
                    target = "_blank",
                    "on the Public Health Scotland SMR Completeness open data web page.")),
                p("Next update: January 2026")
            )
          ),  
          
          fluidRow(
              column(4, actionButton(inputId = "EF2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF1_prevButton", 
                                     label = "Previous Page - EF1", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF3_nextButton", 
                                     label = "Next Page - EF3", icon = icon("arrow-right"),
                                     class = "navpageButton"))
          ) # End of fluidRow
        ) # End of fluidPage
) # End of tabItem