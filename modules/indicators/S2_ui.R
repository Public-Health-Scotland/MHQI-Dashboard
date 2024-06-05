tabItem(tabName = "S2_tab",
        fluidPage(
          titlePanel(paste0("S2 - % of all discharged psychiatric inpatients ",
                            "followed-up by community mental health services ",
                            "within 7 calendar days")),
          mainPanel(
            img(src='infographics/S2.png',
                class = "infographic",
                alt = paste0(
                  "For the quarter ending 31 December 2021, the percentage of ",
                  "discharged psychiatric inpatients followed-up by community ",
                  "mental health services within 7 calendar days ranged from ",
                  "17.6% to 88.1%")),
            br(),
            p(paste0(
              "The data for S2 is sourced from board returns, which may be incomplete.")),
            br(),
            p(paste0(
              "Board returns were received from NHS Ayrshire & Arran, NHS Borders, ",
              "NHS Fife, NHS Forth Valley, NHS Grampian, NHS Greater Glasgow ",
              "& Clyde, NHS Highland, NHS Lothian, NHS Tayside, and NHS Western Isles."))
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
) # End of tabItem