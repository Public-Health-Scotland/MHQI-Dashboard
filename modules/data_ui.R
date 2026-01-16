tabItem(tabName = "data_tab",
        fluidPage(
          h1("Data Downloads"),

          # Indicators - in sidebar order ---- 
          
          ## S2 ----
          fluidRow(
             # Box containing data file download links 
             box(width = 9,
                 # Body text
                 p(downloadLink(outputId = "S2_data_download", 
                                label = "S2 - Community Follow-up.csv"), 
                   icon("database")),
             )),
          
          ## S5 ----
          fluidRow(
             # Box containing data file download links 
             box(width = 9,
                 # Body text
                 p(downloadLink(outputId = "S5_data_download", 
                                label = "S5 - Physical Violence.csv"), 
                   icon("database")),
             )),
          
          ## E1 ----
          fluidRow(
            # Box containing data file download links 
            box(width = 9,
                # Body text
                p(downloadLink(outputId = "E1_data_download", 
                               label = "E1 - Delayed Discharge Data.csv"), 
                  icon("database")),
                )),
          
          ## EF1 ----
          fluidRow(
            # Box containing data file download links
            box(width = 9,
                # Body text
                p(downloadLink(outputId = "EF1_data_download", 
                               label = "EF1 - Emergency Bed Days.csv"), 
                  icon("database")),
            )),

          ## EF2 ----
          fluidRow(
            # Box containing data file download links
            box(width = 9,
                # Body text
                p(downloadLink(outputId = "EF2_data_download", 
                               label = "EF2 - Percentage of Readmissions.csv"), 
                  icon("database")),
            )),

          ## EF4 ----
          fluidRow(
            # Box containing data file download links 
            box(width = 9,
                # Body text
                p(downloadLink(outputId = "EF4_data_download", 
                               label = "EF4 - Mental Health Spend Data.csv"), 
                  icon("database")),
            )),
          
          ## EF5 ----
          fluidRow(
             # Box containing data file download links 
             box(width = 9,
                 # Body text
                 p(downloadLink(outputId = "EF5_data_download", 
                                label = "EF5 - Community DNA.csv"), 
                   icon("database")),
             )),
          
          ## EQ1 ----
          fluidRow(
            # Box containing data file download links 
            box(width = 9,
                # Body text
                p(downloadLink(outputId = "EQ1_data_download", 
                               label = "EQ1 - Premature Mortality Data.csv"), 
                  icon("database")),
            )),
          
          ## EQ4 ----
          fluidRow(
            # Box containing data file download links
            box(width = 9,
                # Body text
                p(downloadLink(outputId = "EQ4_data_download", 
                               label = "EQ4 - Admissions out with CAMH Wards.csv"), 
                  icon("database")),
            )),
          
       # Navigation Buttons ----    
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
