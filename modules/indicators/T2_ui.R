tabItem(tabName = "T2_tab",
        fluidPage(
          ## Title section ----
          h1(paste0(
            "T2 - Percentage (%) of children and young people seen 0 to 18 weeks after referral to start treatment with Child and Adolescent Mental Health Services (CAMHS)")),
          h3("Last Updated: October 2026"),
          
          hr(),       # page break
          
          
          ### [ T1 Health Board Trends ] ----
          
          ## Page separator ----
          h2("T2 - Section 1: Time Trend"),
          
          ## Text above Graph ---- 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p(paste0(
                         "Below is an interactive graph showing the percentage of children and young people seen per quarter
                         who started treatment in CAMHS within 18 weeks of referral.")),
                       p(paste0("Use the drop down menu to select a specific NHS Health Board ")))
            )), # end of fluidRow
          
          ## Graph selectors ---- 
          
          fluidRow(
            column(
              width = 6,
              box(
                width = NULL,
                uiOutput("T2_trendPlot_hbName_output")
              )
            )
          ),
          
          
          ## Graph output ---- 
          fluidRow(
            box(width = 12,
                title = paste0(
                  "Percentage (%) of children and young people seen 0 to 18 weeks after referral to CAMHS
                  by quarter, in selected NHS health board"), 
                phs_spinner("T2_trendPlot"))   # spinner shows spinning circle while graph loads
          ),
          
          
          #            ## Graph 1 data table ----
          fluidRow(
            box(title = HTML(paste("Below is a table showing the data used to create the 
                                     above graph. It can be downloaded using the 'Download as .csv' 
                                     button underneath this section.", 
                                   sep = "<br/>")),
                width = 12, 
                solidHeader = TRUE, 
                collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("T2_1_table"))
          ),            
          
          
          ## Download button for table 1 ----
          fluidRow(
            column(4,
                   downloadButton(outputId = "T2_1_table_download", 
                                  label = "Download as .csv", 
                                  class = "tableDownloadButton"))
          ),
          
          
          hr(), # page break
          
          fluidRow(
            box(width = 9,
                h2("Data source information and notes:"),
                p("Further information can be found in the ",
                  a(href="https://publichealthscotland.scot/publications/child-and-adolescent-mental-health-services-camhs-waiting-times/",
                    target = "_blank",
                    "Child and Adolescent Mental Health Services in Scotland: Waiting Times publication."), 
                  " The publication also provides ", 
                  a(href = "https://www.opendata.nhs.scot/dataset/child-and-adolescent-mental-health-waiting-times", 
                    target = "_blank",
                    "NHS Board level open data.")), 
                p("Next update: October 2026")
                )
            ),
        
          fluidRow(
              column(4, actionButton(inputId = "T2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T1_prevButton", 
                                     label = "Previous Page - T1", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "T3_nextButton", 
                                     label = "Next Page - T3", icon = icon("arrow-right"),
                                     class = "navpageButton"))
              )
          ) # End of fluidPage
        ) 
