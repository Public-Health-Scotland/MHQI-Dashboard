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
                         "across different NHS health boards by financial year.")),
                       p(paste0("Use the drop down menus to select which health board(s) ", 
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
        )
)
          