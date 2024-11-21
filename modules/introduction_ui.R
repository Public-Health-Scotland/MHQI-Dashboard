tabItem(tabName = "intro",
        fluidPage(
          mainPanel(
            # Page title
            h1("Welcome to the Mental Health Quality Indicators Dashboard"),
            
            # Overview section ----
            h2("Overview"),
            p(paste0(
              "This release by Public Health Scotland (PHS), presents information ",
              "on Mental Health Quality Indicators in support of the "),
              a(href = 'https://www.gov.scot/publications/mental-health-wellbeing-strategy/',
                "Mental Health and Wellbeing Strategy 2023"),
              "and ",
              a(href = 'https://www.gov.scot/publications/core-mental-health-standards/',
                "Core Mental Health Standards."),
              paste0(" Originally developed as a standard publication "),
              a(href = 'https://publichealthscotland.scot/publications/show-all-releases?id=20495',
                "(previous versions available here),"),
              paste0(" the dashboard has been developed to provide enhanced visualisation, ",
              "sub-national data analysis (where available), and improved interaction for users.")
              ),
            
            p(paste0(
              "The MHQI publication was created to provide an overview of mental ",
              "health services across Scotland, by combining previously published ",
              "and new information into a single profile, supporting Action 38 of ",
              "the "),
              a("Mental Health Strategy 2017-2027.", 
                href = 'https://www.gov.scot/publications/mental-health-strategy-2017-2027/',
                target = "_blank") # forces link to open in a new tab
              ),
            
            p(paste0(
              "The dashboard will be regularly updated when new data is available, ",
              "when further indicators have been developed, and when new indicators ",
              "are identified which fall under its remit.")
              ),
            
            # Scotland Hub section ----
            h2("Scotland Hub"),
            p("The ",
              # Link to Scot Hub tab using built in routing
              a("Scotland Hub", href = "#shiny-tab-scot_hub", "data-toggle" = "tab"),
              paste0(" collates headline, national figures ",
              "for all indicators, providing links to individual indicators of interest.")
              ),
            
            # Data section ----
            h2("Data"),
            p("The ",
              # Link to Data tab using built in routing
              a("Data Tab", href = "#shiny-tab-data_tab", "data-toggle" = "tab"),
              paste0(" provides a single location for all data used within ",
              "the dashboard’s outputs. Individual indicator tabs also contain ",
              "data extracts for that specific indicator.")
              ),
              
            # Indicator tabs overview ----
            h2("Individual Indicator tabs"),
            p(paste0(
              "The dashboard currently contains interactive visualisation and ",
              "sub-national breakdowns for the indicators listed below, while ",
              "others currently provide infographic information in the style of ",
              "previous MHQI publications. The dashboard is being continuously ",
              "updated to provide visualisation and breakdowns for further ",
              "indicators, and these developments, when ready, will be highlighted ",
              "next to the relevant indicators in the navigation column to the ",
              "left of this screen."
            )),
            
            # Current visualisations ----
            h3("Indicators presented as interactive graphs:"),
            p(paste0(
              "Premature mortality rate for persons in contact with mental health services (EQ1)")),
            p(paste0(
              "Days spent in hospital when ready for discharge (per 1,000 population) (E1)")),
            p(paste0(
              "Total mental health spend as a % of total NHS spend (EF4)")),
            
            # Dashboard Dev/Github section ----
            h2("Dashboard Development"),
            p("You can find the code used to create this dashboard at the following ",
              # Link to github repo
              a("PHS github repository", 
                href = "https://github.com/Public-Health-Scotland/MHQI-Dashboard/"),
              "."),
            # Credit section - linking to github user profiles
            p("This dashboard was developed by ",
              a("Alex Bruce", 
                href = "https://github.com/alex-bruce"),
              ", ",
              a("Mahri Stewart", 
                href = "https://github.com/MahriScot"),
              " and ",
              a("Cormac Murray", 
                href = "https://github.com/Cormac-Murray"),
              ".")

            ) # End of mainPanel
        ) # End of fluidPage
) # End of Intro Tab