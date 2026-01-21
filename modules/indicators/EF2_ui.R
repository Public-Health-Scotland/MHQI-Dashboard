tabItem(tabName = "EF2_tab",
        fluidPage(
          ## Title section ----
          h1(paste0(
            "EF2 - Mental health emergency readmissions")),
          h3("Last Updated: November 2025"),
          
          hr(),       # page break
          
          
          ### [ EF5 Health Board Trends ] ----
          
          ## Page separator ----
          h2("EF2 - Section 1: Time Trend"),
          
          ## Text above Graph ---- 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                         "Below is an interactive graph which can be used to visualise ",
                         "the percentage of mental health emergency readmissions ", 
                         "to hospital within 28 days of discharge ",
                         "across different NHS health boards and in 3 month periods.")),
                       p(paste0("Use the drop down menu to select which health board(s) ", 
                                "you wish to look at.")))
            )), # end of fluidRow
        

          
          ## Graph selectors ---- 
          
          fluidRow(
            # Health Board selector
            column(6,
                   box(width = NULL,
                       uiOutput("EF2_trendPlot_hbName_output"))
            ),
           
          ),
          
          
          ## Graph output ---- 
          fluidRow(
            box(width = 12,
                title = paste0(
                  "Percentage of mental health emergency readmissions,", 
                  "by calendar quarter, in selected NHS health board(s)"), 
                phs_spinner("EF2_trendPlot"))   # spinner shows spinning circle while graph loads
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
                dataTableOutput("EF2_1_table"))
          ),            
          
          
          ## Download button for table 1 ----
          fluidRow(
            column(4,
                   downloadButton(outputId = "EF2_1_table_download", 
                                  label = "Download as .csv", 
                                  class = "tableDownloadButton"))
          ),
          
          
          hr(), # bigger page break between graphs          
          hr(), 
          
          # Graph 2 ---- 
          
          ## Page separator ----
          h2("EF2 - Section 2: Single Quarter Comparison"),
          
          ## Text Above Graph ----
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the percentage of mental health emergency",
                         "readmissions to hosptial within 28 days of discharge in each health board for your chosen ", 
                         "calendar year quarter."), 
                       p("Use the drop down menu to select which calendar quarter ", 
                         "you wish to look at."))
                   
            )
          ), 
          
          
            ## Graph 2 - drop down menu ---- 
            fluidRow(
              column(6,
                     box(width = NULL,
                         uiOutput("EF2_plot2_quarter_output"))
              )
            ),   
            
            ## Graph 2 output ---- 
            fluidRow(
              box(width = 12,
                  title = uiOutput("EF2_plot2_title"),
                  phs_spinner("EF2_plot2"))
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
                  dataTableOutput("EF2_2_table"))
            ), 
            
            
            ## Graph 2 - table download button ---- 
            fluidRow(
              column(4,
                     downloadButton(outputId = "EF2_2_table_download", 
                                    label = "Download as .csv", 
                                    class = "tableDownloadButton"))
            ),
            
            hr(), # page break            
            
          
     ## Data source information  ----  
            
            fluidRow(
              box(width = 9,
                  h2("Data source information and notes:"),
                  p("The data for EF2 is sourced from ",
                    a(href = "https://www.nssdiscovery.scot.nhs.uk/",
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
                  authorities and health and social care partnerships. Discovery 
                  is not open to members of the public, the press, academia, or 
                  researchers. At time of data extraction data completeness was unavailable for State Hospital (due to issues with their system)
                  and was below 90% for NHS Grampian and NHS Highland. Data completeness 
                  for Scotland overall at the time of data extraction was 97%, well above the NHS Scotland 90% threshold for 
                  publications. Estimates of completeness of 
                  SMR records in recent years can be found ", 
                    a(href = "https://publichealthscotland.scot/resources-and-tools/health-intelligence-and-data-management/data-management-in-secondary-care-hospital-activity/scottish-morbidity-records-smr/completeness/", 
                      target = "_blank",
                      "on the Public Health Scotland SMR Completeness open data web page.",),
                  p("Next update: April 2026")
              )
            ),  
            
            fluidRow(
              column(4, actionButton(inputId = "EF2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF1_prevButton", 
                                     label = "Previous Page - EF1", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "EF3_nextButton", 
                                     label = "Next Page - EF3", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            ) # End of fluidRow
          ) # End of fluidPage
        )) # End of tabItem
