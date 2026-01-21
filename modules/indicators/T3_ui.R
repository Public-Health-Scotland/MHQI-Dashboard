tabItem(tabName = "T3_tab",
        fluidPage(
          h1("T3 - % of people who wait less than three weeks from referral 
             received to appropriate drug or alcohol treatment that supports 
             their recovery"),
          h3("Last Updated: November 2025"),
          fluidRow(
            box(width = 9,
            img(src='infographics/T3.png',
                class = "infographic",
                alt = paste0(T3_infographic_alt_text))
            )
            ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("Data from individual Alcohol and Drug Partnerships (ADPs) may 
                be excluded from this release as they were unable to confirm that 
                their data were accurate and up-to-date within the specified 
                timescale or were excluded due to incomplete data. Further information 
                can be found in the ",
                  a(href="https://publichealthscotland.scot/publications/show-all-releases?id=20553",
                  target = "_blank",
                  "National Drug and Alcohol Treatment Waiting Times publication.")),
                p(" The publication also provides ", 
                  a(href = "https://www.opendata.nhs.scot/dataset/drug-and-alcohol-treatment-waiting-times",
                  target = "_blank", 
                  "open data"),
                  "with breakdowns by NHS Board and Alcohol and Drug partnership, 
                  service type (community-based or prison-based) and the substance(s) 
                  people sought help for."), 
                p("These data were extracted from the ", 
                a(href = "https://publichealthscotland.scot/population-health/improving-scotlands-health/drugs/data-and-intelligence/drug-and-alcohol-information-system-daisy/about-daisy/#section-1", 
                  target = "_blank", 
                  "Drug and Alcohol Information System (DAISy)"), 
                " and its predecessor the ", 
                a(href = "https://webarchive.nrscotland.gov.uk/20231129155349/https://www.isdscotland.org/Health-Topics/Waiting-Times/Drugs-and-Alcohol/",
                  target = "_blank", 
                  "Drug and Alcohol Treatment Waiting Times (DATWT) database."), 
                " DAISy has been available in all NHS boards from April 2021 and 
                replaced two previous systems: the DATWT database and the ", 
                a(href = "https://publichealthscotland.scot/population-health/improving-scotlands-health/drugs/data-and-intelligence/scottish-drug-misuse-database-sdmd/",
                  target = "_blank", 
                  "Scottish Drug Misuse Database "), 
                  "(SDMD)."),
                p("Next update: October 2026")
                )
            ),
          
            fluidRow(
              column(4, actionButton(inputId = "T3_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T2_prevButton", 
                                     label = "Previous Page - T2", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S1_nextButton", 
                                     label = "Next Page - S1", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
