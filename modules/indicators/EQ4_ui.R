tabItem(tabName = "EQ4_tab",
        fluidPage(
          ## Title section ----
          h1(paste0(
            "EQ4 - Under 18 year old psychiatric admissions admitted outwith NHS specialist Child and Adolescent Mental Health (CAMH) wards")),
          h3("Last Updated: July 2026"),
          
          hr(),       # page break
          
          h2("EQ4 - Section 1: Number of Admissions"),
          
          ## Text above Graph ---- 
          fluidRow(
            column(
              12,
              box(
                width = NULL,
                # Use HTML to insert <br> for a new line
                HTML(
                  paste0(
                    "The graph below shows the number of psychiatric admissions
                    for people aged under 18 years admitted outwith CAMH wards
                    compared with the total number of psychiatric admissions in 
                    this age group.<br>",
                    "This data is only shown for NHS Scotland overall."
                  )
                )
              )
            )
          ),
          
          
          
          ## Graph 1 output ---- 
          fluidRow(
            box(width = 12,
                title = "Under 18 psychiatric admissions admitted outwith CAMH 
                wards and total admissions, by financial quarter, in NHS Scotland:",
                phs_spinner("EQ4_plot1"))
          ),
          
          # hr(), # page break
          
          ## Table 1 below graph ----
          fluidRow(
            box(
              width = 12,  # Full width
              title = "Below is a table showing the data used to create the above graph.
              It can be downloaded using the 'Download as .csv' button underneath this section.",
              
              # Table output
              DT::dataTableOutput("EQ4_table1")
            )
          ),
          
          # Download button
          fluidRow(
            column(
              width = 12,
              downloadButton(
                outputId = "download_EQ4_table1", 
                label = "Download as .csv", 
                class = "tableDownloadButton"
              )
            )
          ),
          
          
          hr(), # page break
          
          ## Page separator ----
          h2("EQ4 - Section 2: Percentage of Admissions"),
          
          ## Text above Graph ---- 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("The graph below shows the percentage of under 18 year old psychiatric admissions 
                         admitted outwith CAMH wards across different NHS health boards.")))
          ),
          
          
          ## Graph selectors ---- 
          
          fluidRow(
            # Health Board selector
            column(6,
                   box(width = NULL,
                       uiOutput("EQ4_trendPlot_hbName_output"))
            ),
            
          ),
          
          ## Graph 2 output ---- 
          fluidRow(
            box(width = 12,
                title = paste0("Percentage of psychiatric admissions admitted outwith CAMH wards, ", 
                               "by financial quarter, in selected NHS health board(s):"),  
                phs_spinner("EQ4_plot2"))   # spinner shows spinning circle while graph loads
          ),
          
          
          ## Graph 2 data table ----
          fluidRow(
            box(title = HTML(paste("Below is a table showing the data used to create the 
                                     above graph. It can be downloaded using the 'Download as .csv' 
                                     button underneath this section.", 
                                   sep = "<br/>")),
                width = 12, 
                solidHeader = TRUE, 
                collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("EQ4_table2"))
          ),            
          
          
          ## Download button for table 1 ----
          fluidRow(
            column(4,
                   downloadButton(outputId = "download_EQ4_table2", 
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
              authorities and health and social care partnerships. Discovery dashboards are updated monthly and figures may change depending on when the data is downloaded. Discovery is not open to members of the public, the press, academia, or researchers. 
              At time of data extraction data completeness was below 90% for NHS Fife and NHS Highland. Data completeness 
                  for Scotland overall at the time of data extraction was 96%, well above the NHS Scotland 90% threshold for 
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
                p("Next update: October 2026")   
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

