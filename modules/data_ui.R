tabItem(tabName = "data_tab",
        fluidPage(
          h1("Data Downloads"),

          fluidRow(
            # Box containing data file download links [Not working yet]
            box(width = 9,
                # Body text
                p(
                  downloadLink(outputId = "E1_data_download", label = "E1 - Delayed Discharge Data.csv"), icon("database")),
                )),
          fluidRow(
            # Box containing data file download links [Not working yet]
            box(width = 9,
                # Body text
                p(
                  downloadLink(outputId = "EF4_data_download", label = "EF4 - Mental Health Spend Data.csv"), icon("database")),
            )),
          fluidRow(
            # Box containing data file download links [Not working yet]
            box(width = 9,
                # Body text
                p(
                  downloadLink(outputId = "EQ1_data_download", label = "EQ1 - Premature Mortality Data.csv"), icon("database")),
            )),
          
          fluidRow(
            column(4, actionButton(inputId = "data_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "T1_nextButton", 
                                   label = "Next Page - T1", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          )
          
        ) # End of fluidPage
) # End of tab
