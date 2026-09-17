tagList(
  
  # Title for P1 tab ----
  fluidRow(width = 12,
           h1("T3 - % of people who wait less than three weeks from referral 
             received to appropriate drug or alcohol treatment that supports 
             their recovery"),
           h3("Last Updated: November 2025")
  ),
  
  linebreaks(1),
  
  fluidRow(
    tabBox(width = NULL,
           type = "pills",
           # Graph
           tabPanel("Infographic",
                    tagList(
                      linebreaks(1),
                      altTextUI("T3_infographic_modal"),
                      img(src='infographics/T3.png',
                          class = "infographic",
                          alt = "Of the 7,041 referrals to community-based specialist 
                          drug and alcohol treatment services starting treatment in the 
                          quarter ending 30 June 2025, 94.3% involved a wait of three 
                          weeks of less. The percentage of treatment within three weeks 
                          for drug treatment was 96.2% and 92.8% for alcohol treatment.")
                    )
           ), 
           # Data table
           tabPanel("Data Source",
                    tagList(
                      linebreaks(1),
                      title = "Data source information and notes:",
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
           )
    )
  ),
  
  # Insert go to top button
  go_2_top_bttn
)