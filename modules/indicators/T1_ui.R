tabItem(tabName = "T1_tab",
        fluidPage(
          ## Title section ----
          h1(paste0(
            "T1 - % of people who commence psychological therapy based treatment")),
          h3("Last Updated: October 2026"),
          
          hr(),       # page break
          
          
          ### [ T1 Health Board Trends ] ----
          
          ## Page separator ----
          h2("T1 - Section 1: Time Trend"),
          
          ## Text above Graph ---- 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                         "Below is an interactive graph which can be used to visualise ",
                         "the percentage of people who started treatment across four distinct time bands (weeks 0-18, 19-35, 36-52, and over 52) ", 
                         "in 3 month periods.")),
                       p(paste0("Use the drop down menu to select a specific NHS Health Board ")))
            )), # end of fluidRow
          
          
          
          ## Graph selectors ---- 
          
          fluidRow(
            column(
              width = 6,
              box(
                width = NULL,
                uiOutput("T1_trendPlot_hbName_output")
              )
            )
          ),
          
          
          ## Graph output ---- 
          fluidRow(
            box(width = 12,
                title = paste0(
                  "Percentage of people who started treatment by wait time band,", 
                  "by financial quarter, in selected NHS health board"), 
                phs_spinner("T1_trendPlot"))   # spinner shows spinning circle while graph loads
          )))
          
          
#           ## Graph 1 data table ----
#           fluidRow(
#             box(title = HTML(paste("Below is a table showing the data used to create the 
#                                      above graph. It can be downloaded using the 'Download as .csv' 
#                                      button underneath this section.", 
#                                    sep = "<br/>")),
#                 width = 12, 
#                 solidHeader = TRUE, 
#                 collapsible = TRUE, collapsed = FALSE,
#                 dataTableOutput("T1_1_table"))
#           ),            
#           
#           
#           ## Download button for table 1 ----
#           fluidRow(
#             column(4,
#                    downloadButton(outputId = "T1_1_table_download", 
#                                   label = "Download as .csv", 
#                                   class = "tableDownloadButton"))
#           ),
#           
#           
#           
#           hr(), # page break            
#           
#           
#           ## Data source information  ----  
#           
#           fluidRow(
#             box(width = 9,
#                 h2("Data source information and notes:"),
#                 p("Further information can be found in the ",
#                   a(href="https://publichealthscotland.scot/publications/psychological-therapies-waiting-times/",
#                     target = "_blank",
#                     "Psychological Therapies Waiting Times publication."), 
#                   " The publication also provides ", 
#                   a(href = "https://www.opendata.nhs.scot/dataset/psychological-therapies-waiting-times",
#                     target = "_blank",
#                     "NHS Board level open data.")), 
#                 p("Next update: October 2027")
#             )
#           ),
#           
#           fluidRow(
#             column(4, actionButton(inputId = "T1_scot_hub_button", 
#                                    label = "Scotland Hub", icon = icon("home"),
#                                    class = "navpageButton")),
#             column(4, actionButton(inputId = "data_prevButton", 
#                                    label = "Data Tab", icon = icon("arrow-left"),
#                                    class = "navpageButton")),
#             column(4, actionButton(inputId = "T2_nextButton", 
#                                    label = "Next Page - T2", icon = icon("arrow-right"),
#                                    class = "navpageButton"))
#           )
#           
#         ) # End of fluidPage
# ) # End of tab