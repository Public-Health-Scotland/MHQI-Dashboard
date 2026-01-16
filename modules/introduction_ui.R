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
                "Mental Health and Wellbeing Strategy 2023",
                target = "_blank"),
              "and ",
              a(href = 'https://www.gov.scot/publications/core-mental-health-standards/',
                "Core Mental Health Standards.",
                target = "_blank"),
              paste0(" Originally developed as a standard publication "),
              a(href = 'https://publichealthscotland.scot/publications/show-all-releases?id=20495',
                "(previous versions available here),",
                target = "_blank"),
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
            
            hr(), # adds spacing between sections
            
            # Scotland Hub section ----
            h2("Scotland Hub"),
            p("The ",
              # Link to Scot Hub tab using built in routing
              a("Scotland Hub", href = "#shiny-tab-scot_hub", "data-toggle" = "tab"),
              paste0(" collates headline, national figures ",
              "for all indicators, providing links to individual indicators of interest.")
              ),
            
            hr(), 
            
            # Glossary section ---- 
            h2("Glossary"), 
            p("The ", 
              # Link to Glossary tab using built in routing - found in "tabName =" in glossary_ui.R
              a("Glossary", 
                href = "#shiny-tab-glossary", 
                "data-toggle" = "tab"), 
              " provides an alphabetical list of explanations of key terms used 
              throughout the dashboard."),
            
            hr(), 
            
            # Data section ----
            h2("Data"),
            p("The ",
              # Link to Data tab using built in routing
              a("Data Tab", href = "#shiny-tab-data_tab", "data-toggle" = "tab"),
              paste0(" provides a single location for all data used within ",
              "the dashboard’s outputs. Individual indicator tabs also contain ",
              "data extracts for that specific indicator.")
              ),
              
            hr(), 
            
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
            p("S2 - Percentage (%) of all discharged psychiatric inpatients followed up by community 
              mental health services within 7 calendar days."),
            p("S5 - Incidents of physical violence per 1,000 occupied psychiatric bed days."),
            p("E1 - Days spent in hospital within mental health specialties when ready for discharge."),
            p("EF1 - Rate of emergency bed days for adults in psychiatric hospital beds."),
            p("EF2 - Mental health emergency readmissions to hospital within 28 days of discharge."),
            p("EF4 - Total mental health spend as a percentage (%) of total NHS spend."),
            p("EF5 - Percentage (%) of 'Did Not Attend' appointments for community based 
              services of people with mental health conditions."),
            p("EQ1 - Premature mortality rate for persons in contact with mental health services."),
            p("EQ4 - % of under 18 year old psychiatric admissions admitted out with NHS specialist Child and Adolescent Mental Health (CAMH) wards."),
            
            hr(), 
            
            # Dashboard Dev/Github section ----
            h2("Dashboard Development"),
            p("You can find the code used to create this dashboard at the following ",
              # Link to github repo
              a("PHS github repository.", 
                href = "https://github.com/Public-Health-Scotland/MHQI-Dashboard/",
                target = "_blank")),
            # Credit section - linking to github user profiles
            p("This dashboard is currently maintained by ",
              a("Lauren Macarthur", 
                href = "https://github.com/laurenmacarthur",
                target = "_blank"),
              " and ",
              a("Cormac Murray.", 
                href = "https://github.com/Cormac-Murray",
                target = "_blank"),
              " and ",
              a("Alex Bruce.", 
                href = "https://github.com/alex-bruce",
                target = "_blank")),
            # Credit section - linking to github user profiles
            p("It was developed by ",
              a("Alex Bruce", 
                href = "https://github.com/alex-bruce",
                target = "_blank"),
              ", ",
              a("Mahri Stewart", 
                href = "https://github.com/MahriScot",
                target = "_blank"),
              " and ",
              a("Cormac Murray.", 
                href = "https://github.com/Cormac-Murray",
                target = "_blank"))

            ) # End of mainPanel
        ) # End of fluidPage
) # End of Intro Tab