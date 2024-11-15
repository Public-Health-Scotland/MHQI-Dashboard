tabItem(tabName = "S5_tab",
        fluidPage(
          
          h1("S5 - Incidents of physical violence per 1,000 occupied psychiatric bed days"),
          h2("Last Updated: August 2024"),
          fluidRow(
            box(width = 9,
                img(src='infographics/S5.png',
                    class = "infographic",
                    alt = S5_infographic_alt_text)
                )
            
          ),
          
          fluidRow(
            box(width = 9,
                p(paste0(
                  "The data for S2 is sourced from board returns, which may be incomplete.")),
                br(),
                p(paste0(
                  "Board returns were received from NHS Ayrshire & Arran, NHS Borders, ",
                  "NHS Fife, NHS Forth Valley, NHS Grampian, NHS Greater Glasgow ",
                  "& Clyde, NHS Highland, NHS Lanarkshire, NHS Lothian, NHS Tayside, ",
                  "and NHS Western Isles.")),
            ),
          ), 
          
          fluidRow(
              column(4, actionButton(inputId = "S5_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P1_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
