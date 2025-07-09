tabItem(tabName = "EQ4_tab",
        fluidPage(
          h1("EQ4 - % of under 18 year old psychiatric admissions admitted out with NHS specialist Child and Adolescent Mental Health (CAMH) wards"),
          h3("Last Updated: June 2024"),
          fluidRow(
            box(width = 9,
            img(src='infographics/EQ4.png',
                class = "infographic",
                alt = EQ4_infographic_alt_text)
            )
          ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
            p("The data for EQ4 is sourced from  ",
              a(href="https://www.publichealthscotland.scot/services/discovery/#section-1-1",
                target = "_blank",
                "Discovery"),
              " using SMR04 (Scottish Morbidity Records) data ", 
              a("(see Glossary for more information on SMR04).",
                href = "#shiny-tab-glossary", 
                "data-toggle" = "tab"),
              " NHS Board level data is available from the Discovery 
              online management information system to health and social care 
              staff from organisation across Scotland including: Scottish 
              Government, territorial and special health boards, local 
              authorities and health and social care partnerships. Discovery is 
              not open to members of the public, the press, academia, or 
              researchers. Financial year ",
              a(href = "https://publichealthscotland.scot/resources-and-tools/health-intelligence-and-data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/completeness/",
                target = "_blank",
                "data completeness"),
              " for SMR04 was around 94% or more for most Boards when the data 
              was accessed. Published monthly, estimates of completeness of 
              SMR records in recent years can be found ", 
              a(href = "https://www.opendata.nhs.scot/dataset/scottish-morbidity-record-completeness", 
                target = "_blank",
                "here.")),
            # CHECK THIS
            # p("Specialist CAMHS wards are defined as admissions to specialty G2, 
            #   Child and Adolescent psychiatry at either Royal Hospital for Children 
            #   (NHS Greater Glasgow & Clyde), Skye House (NHS Greater Glasgow & Clyde), 
            #   Dudhope House (NHS Tayside) or, until March 2021, Royal Edinburgh 
            #   Hospital (NHS Lothian)."),
            # p("Between January 2021 and March 2021 child and adolescent psychiatry 
            # activity transferred from a facility in the Royal Edinburgh hospital to 
            # a facility in the Royal Hospital for Children and Young People in Edinburgh. 
            # From January 2021 those admitted to the Royal Hospital for Children and 
            # Young People in Edinburgh child and adolescent psychiatry, child psychiatry 
            # or adolescent psychiatry and treated in an adolescent unit are defined as 
            # admissions to a specialist CAMHS ward. This change in definition has been 
            # applied retrospectively in this publication. The data for this indicator 
            # in the April 2022 and September 2021 publications did not take into account 
            # this change."), 
            # p("From January 2018, Skye House changed their hospital code to the same 
            # as Stobhill Hospital so in order to determine if an admission is to Skye 
            # House, those admitted from 1 January 2018 with the Stobhill hospital code 
            # to child and adolescent psychiatry, child psychiatry or adolescent 
            # psychiatry were assumed to be in Skye House."),
            p("Next update: July 2026")
          )
        ),  
            
            fluidRow(
              column(4, actionButton(inputId = "EQ2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EQ4_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        )
        