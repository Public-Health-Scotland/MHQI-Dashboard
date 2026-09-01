tabItem(tabName = "EF3_tab",
        fluidPage(
          ## Title section ----
          h1(paste0(
            "EF3 - Total psychiatric inpatient beds per 100,000 population (NRAC adjusted)")),
          h3("Last Updated: October 2026"),
          
          hr(),       # page break
          
          
          ### [ EF5 Health Board Trends ] ----
          
          ## Page separator ----
          h2("EF3 - Section 1: Time Trend"),
          
          ## Text above Graph ---- 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                         "Below is an interactive graph which can be used to visualise ",
                         "the rate of psychiatric beds per 100,000 population  ", 
                         "by financial year from 2010/11.")),
                       p(paste0("Use the drop down menu to select which health board(s) ", 
                                "you wish to look at.")))
            )), # end of fluidRow
          
          
          
          ## Graph selectors ---- 
          
          fluidRow(
            # Health Board selector
            column(6,
                   box(width = NULL,
                       uiOutput("EF3_trendPlot_hbName_output"))
            ),
            
          ),
          
          
          ## Graph output ---- 
          fluidRow(
            box(width = 12,
                title = paste0(
                  "Rate of psychiatric beds per 100,000 population, ", 
                  "by financial year, in selected NHS health board(s)"), 
                phs_spinner("EF3_trendPlot"))   # spinner shows spinning circle while graph loads
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
                dataTableOutput("EF3_1_table"))
          ),            
          
          
          ## Download button for table 1 ----
          fluidRow(
            column(4,
                   downloadButton(outputId = "EF3_1_table_download", 
                                  label = "Download as .csv", 
                                  class = "tableDownloadButton"))
          ),
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("This indicator provides information on the average number of 
                available staffed beds per day for mental health and learning 
                disability specialities for adults and children per 100,000 
                population (National Resource Allocation Committee (NRAC) adjusted). 
                NRAC provides a formula for dividing resources for hospital and 
                community health services and GP prescribing between the 14 
                territorial Health Boards. Mental health and learning specialties 
                include the following specialties:- G1: General Psychiatry, G21: 
                Child Psychiatry, G22: Adolescent Psychiatry, G3: Forensic Psychiatry, 
                G4:Psychiatry of Old Age, G5: Learning Disabilities."), 
                p("The numerator for EF3 is sourced from the ",
                  a(href = "https://publichealthscotland.scot/publications/show-all-releases?id=20521",
                    target = "_blank",
                    "Acute hospital activity and NHS beds information annual 
                    release publication,"),
                  " and the denominator is sourced from the ",
                  a(href = "https://www.publichealthscotland.scot/publications/show-all-releases?id=20539",
                    target = "_blank",
                    "National Resource Allocation (NRAC) publication.")), 
                p("From the November 2023 MHQI publication onwards, the methodology 
                and data used to calculate this indicator has been revised to ensure 
                that it better reflects the ",
                  a(href = "https://www.gov.scot/publications/mental-health-quality-indicators-background-secondary-definitions/pages/8/", 
                    target = "_blank", 
                    "original indicator definition."), 
                  " The methodology in previous publications (September 2021, 
                  April 2022, October 2002, and April 2023) used only average 
                  available staffed beds per day for mental health specialties 
                  Acute hospital activity and NHS beds information annual release 
                  publication as the numerator and the relevant mid-year population 
                  estimates for Scotland as the denominator, which had not been 
                  NRAC adjusted. Due to the changes in methodology, figures from 
                  the November 2023 publication onwards cannot be directly compared 
                  to those previously published."), 
                p("NHS Board level data is available from the ",
                  a(href = "https://www.publichealthscotland.scot/resources-and-tools/medical-practice-and-pharmaceuticals/discovery/overview/what-is-discovery/", 
                    target = "_blank", 
                    "Discovery online management information system"), 
                  " to health and social care staff from organisation across Scotland including: Scottish 
                  Government, territorial and special health boards, local authorities 
                  and health and social care partnerships. Discovery is not open 
                  to members of the public, the press, academia, or researchers."),
                p("Next update: October 2027")
            )
          ),  
          
          fluidRow(
            column(4, actionButton(inputId = "EF3_scot_hub_button", 
                                   label = "Scotland Hub", icon = icon("home"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EF2_prevButton", 
                                   label = "Previous Page - EF2", icon = icon("arrow-left"),
                                   class = "navpageButton")),
            column(4, actionButton(inputId = "EF4_nextButton", 
                                   label = "Next Page - EF4", icon = icon("arrow-right"),
                                   class = "navpageButton"))
          )
        ) # End of fluidPage
) 
        
        