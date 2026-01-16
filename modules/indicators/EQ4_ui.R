tabItem(tabName = "EQ4_tab",
        fluidPage(
          ## Title section ----
          h1(paste0(
            "EQ4 - % of under 18 year old psychiatric admissions admitted out with NHS specialist Child and Adolescent Mental Health (CAMH) wards")),
          h3("Last Updated: January 2026"),
          
          hr(),       # page break
          
          
          ### [ EF5 Health Board Trends ] ----
          
          ## Page separator ----
          h2("EQ4 - Section 1: Time Trend"),
          
          ## Text above Graph ---- 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                         "Below is an interactive graph which can be used to visualise ",
                         "the percentage of under 18 year old psychiatric admissions ", 
                         "admitted out with Child and Adolescent Mental Health (CAMH) wards ",
                         "across different NHS health boards by financial quarter.")),
                       p(paste0("Use the drop down menu to select which health board(s) ", 
                                "and measure you wish to look at."))
                   )
            )
          ), # end of fluidRow
          
          ## Graph selectors ---- 
          
          fluidRow(
            # Health Board selector
            column(6,
                   box(width = NULL,
                       uiOutput("EQ4_trendPlot_hbName_output"))
            ),
            
          ),
          
          ## Graph output ---- 
          fluidRow(
            box(width = 12,
                title = uiOutput("EQ4_trendPlot_selected_measure"), # Since the title is reactive it is defined in the server
                phs_spinner("EQ4_trendPlot"))   # spinner shows spinning circle while graph loads
          ),
          
          
          ## Graph 1 data table ----
          fluidRow(
            box(title = HTML(paste("Below is a table showing the data used to create the 
                                     above graph. It can be downloaded using the 'Download as .csv' 
                                     button underneath this section.", 
                                   sep = "<br/>")),
                width = 12, 
                solidHeader = TRUE, 
                collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("EQ4_1_table"))
          ),            
          
          
          ## Download button for table 1 ----
          fluidRow(
            column(4,
                   downloadButton(outputId = "EQ4_1_table_download", 
                                  label = "Download as .csv", 
                                  class = "tableDownloadButton"))
          ),
          
          
          hr(), # bigger page break between graphs          
          hr(), 
        
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("Please note that large variance in percentages for admissions to wards are due to population differences in each health board."),
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
              researchers. 
              At time of data extraction data completeness was unavailable for State Hospital (due to issues with their system)
                  and was below 90% for NHS Grampian and NHS Highland. Data completeness 
                  for Scotland overall at the time of data extraction was 97%, well above the NHS Scotland 90% threshold for 
                  publications. Estimates of completeness of 
                  SMR records in recent years can be found ", 
                  a(href = "https://publichealthscotland.scot/resources-and-tools/health-intelligence-and-data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/completeness/", 
                    target = "_blank",
                    "on the Public Health Scotland SMR Completeness open data web page.")),
                # CHECK THIS - it was added to the Nov 2024 pdf publication:
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
                p("Next update: April 2026")   
            )
          ),  
          
          fluidRow(
            column(4, actionButton(inputId = "EQ2_prevButton", 
                                   label = "Previous Page - EQ2", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EQ4_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton"))
          )
        ) # End of fluidPage
)
          