tabItem(tabName = "S2_tab",
        fluidPage(
          
          h1("S2 - % of all discharged psychiatric inpatients followed-up by community mental health services within 7 calendar days"),
          h2("Last Updated: August 2024"),
          fluidRow(
            box(width = 9,
                img(src='infographics/S2.png',
                    class = "infographic",
                    alt = S2_infographic_alt_text)
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
                  "& Clyde, NHS Highland, NHS Lothian, NHS Tayside, and NHS Western Isles.")),
            ),
          ), 
          
          
          fluidRow(
              column(4, actionButton(inputId = "S2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S5_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
              )
          ) # End of fluidPage
        ) 
