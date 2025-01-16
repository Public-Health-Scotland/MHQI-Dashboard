tabItem(tabName = "S2_tab",
        fluidPage(
          
          h1("S2 - % of all discharged psychiatric inpatients followed-up by community mental health services within 7 calendar days"),
          h3("Last Updated: August 2024"),
          
          hr(),       # page break
          
          ## Text Above Graph ---- 
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("Below is a graph showing the percentage (%) of psychiatric ",
                          "inpatients who were followed-up by community mental health ", 
                          "services within 7 calendar days of being discharged. "), 
                        p("Use the drop down menu to select which Health Board ", 
                           "you wish to look at."))
                    )
             ), # end of fluidRow
          
          ## Drop down menu ---- 
          fluidRow(
             column(6,
                    box(width = NULL,
                        uiOutput("S2_trendPlot_hbName_output"))
             )),
          
          ## Graph output ---- 
          fluidRow(
             box(width = 12,
                 plotlyOutput("S2_trendPlot",
                              # height = "50vh",
                              width = "100%"))
          ),
          
          hr(), # page break            
          
          fluidRow(
             box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("S2_table"))
          ),  
          
          fluidRow(
             column(4,
                    downloadButton(outputId = "S2_table_download", 
                                   label = "Download as .csv", 
                                   class = "S2_table_downloadbutton"),
                    tags$head(
                       tags$style(".S2_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .S2_table_downloadbutton { color: #FFFFFF; }")
                    ))
          ),
          
          hr(), # page break         
          
          # Data source information  ----  
          
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("The data for S2 is sourced from Health Board returns, which are submitted quarterly and may be incomplete."),
                        br(),
                        p(paste0("Board returns were received from NHS Ayrshire & Arran, NHS Borders, ",
                                 "NHS Fife, NHS Forth Valley, NHS Grampian, NHS Greater Glasgow ",
                                 "& Clyde, NHS Highland, NHS Lothian, NHS Tayside, and NHS Western Isles.")))
                    )), 
             
             br(), 
          
          # Navigation Buttons ----  
          fluidRow(
             column(4, actionButton(inputId = "S2_scot_hub_button", 
                                    label = "Scotland Hub", icon = icon("home"),
                                    class = "navpageButton")),
             column(4, actionButton(inputId = "S1_prevButton", 
                                    label = "Previous Page", icon = icon("arrow-left"),
                                    class = "navpageButton")),
             column(4, actionButton(inputId = "S5_nextButton", 
                                    label = "Next Page", icon = icon("arrow-right"),
                                    class = "navpageButton"))
             ),
          
          # Insert go to top button
          go_2_top_bttn,
          
          br(), 
          
          ### Infographic code ----           
          
          
          
          fluidRow(
            box(width = 9,
                img(src='infographics/S2.png',
                    class = "infographic",
                    alt = S2_infographic_alt_text)
                )
            
          ),
          
          fluidRow(
            box(width = 9,
                p("The data for S2 is sourced from Health Board returns, which may be incomplete."),
                br(),
                p(paste0(
                  "Board returns were received from NHS Ayrshire & Arran, NHS Borders, ",
                  "NHS Fife, NHS Forth Valley, NHS Grampian, NHS Greater Glasgow ",
                  "& Clyde, NHS Highland, NHS Lothian, NHS Tayside, and NHS Western Isles.")))
            ), 
          
          
          fluidRow(
              column(4, actionButton(inputId = "S2_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S1_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S5_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
              )
          ) # End of fluidPage
        ) 
