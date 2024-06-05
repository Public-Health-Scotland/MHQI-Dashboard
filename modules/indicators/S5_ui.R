tabItem(tabName = "S5_tab",
        fluidPage(
          titlePanel(
            paste0(
              "S5 - Incidents of physical violence per 1,000 occupied ",
              "psychiatric bed days")),
          mainPanel(
            img(src='infographics/S5.png',
                class = "infographic",
                alt = paste0(
                  "The number of incidents of physical violence per 1,000 ",
                  "occupied psychiatric bed days in Scotland ranged from zero ",
                  "to 40.3 for the quarter ending 31 December 2021.")),
            br(),
            p(paste0(
              "The data for S5 is sourced from board returns, which may be incomplete.")),
            br(),
            p(paste0(
              "Board returns were received from NHS Ayrshire & Arran, NHS Borders, ",
              "NHS Fife, NHS Forth Valley, NHS Grampian, NHS Greater Glasgow ",
              "& Clyde, NHS Highland, NHS Lanarkshire, NHS Lothian, NHS Tayside, ",
              "and NHS Western Isles."))
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