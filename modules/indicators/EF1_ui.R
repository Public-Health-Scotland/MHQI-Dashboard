tabItem(tabName = "EF1_tab",
        fluidPage(
          h1("EF1 - Rate of emergency bed days for adults in psychiatric hospital beds"),
          h3("Last Updated: June 2025"),
          fluidRow(
            box(width = 9,
            img(src='infographics/EF1.png',
                class = "infographic",
                alt = EF1_infographic_alt_text)
            )
          ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("The data for EF1 is sourced from ",
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
                  researchers. Financial year ",
                  a(href = "https://publichealthscotland.scot/resources-and-tools/health-intelligence-and-data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/completeness/",
                    target = "_blank",
                    "data completeness"),
                  " for SMR04 was around 94% or more for most Boards when the data 
                  was accessed. Published monthly, estimates of completeness of 
                  SMR records in recent years can be found ", 
                  a(href = "https://www.opendata.nhs.scot/dataset/scottish-morbidity-record-completeness", 
                    target = "_blank",
                    "here.")),
                p("Next update: July 2026")
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
