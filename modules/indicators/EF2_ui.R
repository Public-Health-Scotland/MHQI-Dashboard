# Beginning of EF2 tab ----

tabItem(tabName = "EF2_tab",
        fluidPage(
          tags$head( 
            tags$style(
              type = "text/css",
              
              # Prevent error messages from popping up on the interface.
              ".shiny-output-error { visibility: hidden; }", 
              ".shiny-output-error:before { visibility: hidden; }"
              
            ),
          ),
          
          # Title for EF2 tab ----
          
          h1("EF2 - Mental health emergency readmissions to hospital within 28 days of discharge"),
          h3("Last Updated: November 2025"),
          
          hr(),       # page break
          
          # Graph 1 ----
          
          ## Page separator ----
          h2("EF2 - Section 1: Time Trend"),
          ## Text Above Graph ---- 
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the percentage of mental ",
                         "health readmissions to hospital within 28 days of discharge by calendar ", 
                         "year quarter from January 2022."),
                       p("Use the drop down menu to select which health board(s) ", 
                         "you wish to look at."), 
                      # em("Please note that NHS Orkney and NHS Shetland incident data is included in NHS Grampian figures."))
            )
          ), # end of fluidRow
          
          ## Graph 1 - drop down menu ---- 
          fluidRow(
            column(6,
                   box(width = NULL,
                       uiOutput("EF2_trendPlot_hbName_output"))
            )),
          
          ## Graph 1 output ---- 
          fluidRow(
            box(width = 12,
                title = paste0(
                  "Mental health readmissions to hospital within 28 days of discharge, ", 
                  "by calendar quarter, in selected NHS health board(s)"),
                phs_spinner("EF2_trendPlot"))
          )), 
          
          # Graph 2 ---- 
          
          ## Page separator ----
          h2("EF2 - Section 2: Single Year Comparison"),
          
          ## Text Above Graph ----
          fluidRow(
            column(12,
                   box(width = NULL,
                       p("Below is a graph showing the percentage of readmissions to hospital ",
                         "within 28 days of discharge in each health board for your chosen ", 
                         "calendar year quarter."), 
                       p("Use the drop down menu to select which calendar quarter ", 
                         "you wish to look at."),
                       em("Please note that NHS Orkney and NHS Shetland patient data is ...."))
                   
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
          )))
          



