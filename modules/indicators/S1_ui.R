tabItem(tabName = "S1_tab",
        fluidPage(
          
          h1("S1 - Suicide rates per 100,000 population"),
          h3("Last Updated: August 2024"),
          fluidRow(
            box(width = 9,
                img(src='infographics/S1.png',
                    class = "infographic",
                    alt = S1_infographic_alt_text)
            )
            
          ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("These ", 
                  a("European age-sex standardised rates", 
                    href = "#shiny-tab-glossary", 
                    "data-toggle" = "tab"),
                  " are taken from the tables of the downloadable data spreadsheet 
                  which provides information on probable suicides released by 
                  National Records of Scotland (NRS). This data release also includes 
                  data at NHS Board and Local Authority level. Further information 
                  is available from the ", 
                  a(href = "https://www.nrscotland.gov.uk/publications/probable-suicides-2023/#",
                  target = "_blank", 
                  "NRS probable suicide publication webpage.")),
                p("Next update: October 2025")
                )), 
          
          
          fluidRow(
            column(4, actionButton(inputId = "S1_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "T3_prevButton", 
                                   label = "Previous Page", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "S2_nextButton", 
                                   label = "Next Page", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          )
          ) # End of fluidPage
        ) 
