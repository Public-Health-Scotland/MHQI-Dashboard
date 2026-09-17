# Beginning of EF4 tab ---- 

tagList(
  
  # Title for EF4 section ----
  fluidRow(width = 12,
           h1("EF4 - Total mental health spend as a percentage (%) of total spend"),
           h3("Last Updated: October 2026")
           ),
  
  linebreaks(1),
          
  ## Section 1 Subheading ----
  fluidRow(width = 12,
           tagList( # not sure if this needs to be in a tagList? - AB
             h2("EF4 - Section 1: Time Trend")
           )),
  

   
  ##Text Above Graph ----
  fluidRow(width = 12,
           p("Below is a graph showing the percentage (%) of your selected 
             NHS health board's total spend that is attributable to total mental 
             health spend and/or CAMHS expenditure for each financial year."), 
           p("Use the drop down menus to select which health board and 
             measure(s) you wish to look at.")
           ),

 ## Drop down menus ---- 
  fluidRow(
    column(6,
           box(width = NULL,
               uiOutput("EF4_trendPlot_hbName_output"))
           ),
    column(6,
           box(width = NULL,
               uiOutput("EF4_trendPlot_measure_output"))
           ),
        ),
 
 ## Graph 1 output ----
 fluidRow(
   tabBox(width = NULL,
          type = "pills",
          # Graph
          tabPanel("Plot",
                   tagList(
                     linebreaks(1),
                     altTextUI("EF4_trendPlot_modal"),
                     title = uiOutput("EF4_trendPlot_title"), # Title is reactive and defined in server.R
                     phs_spinner("EF4_trendPlot"))), # shows spinning circle while graph is loading
          # Data table
          tabPanel("Data",
                   tagList(
                     linebreaks(1),
                     title = "Below is a table showing the data used to create the corresponding graph. 
                      It can be downloaded using the 'Download as .csv' button underneath this section.",
                     dataTableOutput("EF4_table")))
   )
 ),
 ## Download button for table 1 ----
 fluidRow(
   column(4,
          downloadButton(outputId = "EF4_table_download", 
                         label = "Download as .csv", 
                         class = "tableDownloadButton")
   )),
 
linebreaks(1), # page break
          
  # Data source information  ----        
  fluidRow(width = 12,
           h2("Data source information and notes:"),
            
           # p("There will be no update until October 2026 due to the introduction of a new costing system. 
           #   Further information can be found",
           # a(href="https://publichealthscotland.scot/healthcare-system/system-monitoring-accountability-and-quality-of-care/finance-within-the-nhs/costs-book/costs-book-publication/",
           #   target = "_blank",
           #   "here.")),
           
           p("Mental Health expenditure is expenditure by services in 
                    NHS Scotland where the primary purpose of the service is the 
                    care and/or treatment of individuals with mental health 
                    conditions. This expenditure includes services aimed at children, 
                    adolescents, and older adults. Services may be delivered in the 
                    community or in hospital by a team of mental health professionals 
                    which include Psychiatrists, Mental Health Nurses, Psychologists, 
                    other Allied Health Professions as well as Social Workers and 
                    Mental Health Officers. Please note that learning disability 
                    and clinical psychology specialties are not included in the 
                    expenditure data shown here."),
           p("EF4 values are sourced from data collected annually by Public 
                    Health Scotland (PHS) on expenditure within NHS Scotland. They 
                    are released in an ",
             a(href="https://publichealthscotland.scot/media/39948/nhsscotland-mental-health-expenditure_24-25.xlsx",
               target = "_blank",
               "excel workbook"),
             " which also includes data for organisations providing these 
                      services (14 territorial NHS Boards and the State Hospital 
                      at Carstairs Lanarkshire), as part of the ",
             a(href="https://publichealthscotland.scot/publications/scottish-health-service-costs/scottish-health-service-costs-summary-for-financial-year-2024-to-2025/",
               target = "_blank",
               "annual release of National Statistics covering expenditure 
                        in the financial year 2024/25."), 
             " Data quality issues or inconsistencies are covered in the 
                      data found here."),
           p("Next update: April 2027")
           ),

  # Insert go to top button
  go_2_top_bttn
)
        