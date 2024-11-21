tabItem(tabName = "T3_tab",
        fluidPage(
          h1("T3 - % of people who wait less than three weeks from referral ",
              "received to appropriate drug or alcohol treatment that supports ",
              "their recovery"),
          h3("Last Updated: September 2024"),
          fluidRow(
            box(width = 9,
            img(src='infographics/T3.png',
                class = "infographic",
                alt = paste0(T3_infographic_alt_text))
            )
            ),
          fluidRow(
            box(width = 9,
                p(paste0(
              "Data from City of Edinburgh Alcohol and Drug Partnership (ADP) ",
              "have been excluded from this release as the ADP was unable to ",
              "confirm that their data were accurate and up-to-date within the ",
              "specified timescale. Amongst the remaining ADPs, 13 services out ",
              "of 181 were excluded due to the absence of complete data.")),
            )
          ),
            br(),
            p("Further information can be found in the ",
              a(href="https://beta.isdscotland.org/find-publications-and-data/lifestyle-and-behaviours/substance-use/national-drug-and-alcohol-treatment-waiting-times/",
                "National Drug and Alcohol Treatment Waiting Times publication"),
              "."),
            fluidRow(
              column(4, actionButton(inputId = "T3_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T2_prevButton", 
                                     label = "Previous Page: T2", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S1_nextButton", 
                                     label = "Next Page: S1", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
