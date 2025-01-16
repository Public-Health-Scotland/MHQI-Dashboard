tabItem(tabName = "S5_tab",
        fluidPage(
          
          h1("S5 - Incidents of physical violence per 1,000 occupied psychiatric bed days"),
          h3("Last Updated: August 2024"),
          
          hr(),       # page break
          
          ## Text Above Graph ---- 
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("Below is a graph showing the number of incidents of physical ", 
                           "violence per 1,000 occupied psychiatric bed days per quarter."),
                        p("Use the drop down menu to select which Health Board ", 
                           "you wish to look at.")
                    )
             )), # end of fluidRow
          
          ## Drop down menus ---- 
          fluidRow(
             column(6,
                    box(width = NULL,
                        uiOutput("S5_trendPlot_hbName_output"))
             )),          
          
          ## Graph output ---- 
          fluidRow(
             box(width = 12,
                 plotlyOutput("S5_trendPlot",
                              # height = "50vh",
                              width = "100%"))
          ),
          
          hr(), # page break        
          
          fluidRow(
             box(title = "Below is a table showing the data used to create the above graph. 
                It can be downloaded using the 'Download as .csv' button underneath this section",
                width = 12, solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                dataTableOutput("S5_table"))
          ),            
          
          fluidRow(
             column(4,
                    downloadButton(outputId = "S5_table_download", 
                                   label = "Download as .csv", 
                                   class = "S5_table_downloadbutton"),
                    tags$head(
                       tags$style(".S5_table_downloadbutton { background-color: 
                                    #3F3685; } 
                                    .S5_table_downloadbutton { color: #FFFFFF; }")
                    ))
          ),
          
          hr(), # page break
          
          # Data source information  ----        
          fluidRow(
             column(12,
                    box(width = NULL,
                        p("The data for S5 is sourced from Health Board returns which are submitted quarterly and may be incomplete."), 
                        br(),
                        p("Board returns were received from NHS Ayrshire & Arran, NHS Borders, ",
                           "NHS Fife, NHS Forth Valley, NHS Grampian, NHS Greater Glasgow ",
                           "& Clyde, NHS Highland, NHS Lanarkshire, NHS Lothian, NHS Tayside, ",
                           "and NHS Western Isles."))
             )
          ),
          
          br(),           
          
          # Navigation Buttons ----  
          fluidRow(
             column(4, actionButton(inputId = "S5_scot_hub_button", 
                                    label = "Scotland Hub", icon = icon("home"),
                                    class = "navpageButton")),
             column(4, actionButton(inputId = "S2_prevButton", 
                                    label = "Previous Page", icon = icon("arrow-left"),
                                    class = "navpageButton")),
             column(4, actionButton(inputId = "P1_nextButton", 
                                    label = "Next Page", icon = icon("arrow-right"),
                                    class = "navpageButton"))
          ),
          
          # Insert go to top button
          go_2_top_bttn,
          
          br(),           
          
          
          
          ### Infographic code ----          
          
          fluidRow(
            box(width = 9,
                img(src='infographics/S5.png',
                    class = "infographic",
                    alt = S5_infographic_alt_text)
                )
            
          ),
          
          fluidRow(
            box(width = 9,
                p("The data for S5 is sourced from Health Board returns, which may be incomplete."),
                br(),
                p(paste0(
                  "Board returns were received from NHS Ayrshire & Arran, NHS Borders, ",
                  "NHS Fife, NHS Forth Valley, NHS Grampian, NHS Greater Glasgow ",
                  "& Clyde, NHS Highland, NHS Lanarkshire, NHS Lothian, NHS Tayside, ",
                  "and NHS Western Isles."))
            )
          ), 
          
          fluidRow(
              column(4, actionButton(inputId = "S5_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "S2_prevButton", 
                                     label = "Previous Page", icon = icon("arrow-left"),
                                     class = "navpageButton")),
              column(4, actionButton(inputId = "P1_nextButton", 
                                     label = "Next Page", icon = icon("arrow-right"),
                                     class = "navpageButton"))
            )
          ) # End of fluidPage
        ) 
