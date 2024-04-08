tabItem(tabName = scot_hub,
        # fluidPage(
        #   mainPanel(
        
        # 'Timely' Indicators ----
        h1("Timely"),
        fluidRow(
          box(
            # Header Text
            title = tagList(icon("hourglass-end"),
                            "T1 - % of people who commence psychological 
                                  therapy based treatment within 18 weeks of referral:"),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(E1,"%"),
            # Navigation button
            actionButton(inputId = "T1_button", 
                         label = "T1 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          box(
            # Header Text
            title = tagList(icon("hourglass-end"),
                            "% of young people who commence treatment 
                                  by specialist Child and Adolescent Mental 
                                  Health services within 18 weeks of referral:"),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(E1,"%"),
            # Navigation button
            actionButton(inputId = "T2_button", 
                         label = "T2 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          box(
            # Header Text
            title = tagList(icon("hourglass-end"),
                            "T1 - % of people who commence psychological 
                                  therapy based treatment within 18 weeks of referral:"),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(E1,"%"),
            # Navigation button
            actionButton(inputId = "T1_button", 
                         label = "T1 - Find out more", 
                         class = "navpageButton pull-right")
          )
        ),
        br(),
        
        # 'Effective' Indicators ----
        h1("Effective"),
        fluidRow(
          box(# Link in title instead of button
            title = actionLink("E1_button",
                               "E2 - Days in hospital when clinically 
                                     ready to discharge, per 1,000 population:",
                               icon = icon("refresh")),
            width = 4, solidHeader = TRUE,
            paste0(E1)
          )
        ),
        br(),
        
        # 'Efficient' Indicators ----
        h1("Efficient"),
        
        
        box(width = 4, solidHeader = TRUE,
            title = tagList(icon("hourglass-end"),
                            "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:"),
            paste0(E1),
            footer = 
              actionButton(inputId = "button3",
                           label = "E1 - Find out more", 
                           class = "navpageButton pull-right")
        ),
        box(width = 4, solidHeader = TRUE,
            title = tagList(icon("hourglass-end"),
                            "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:"),
            paste0(E1),
            actionButton(inputId = "button4",
                         label = "E1 - Find out more", 
                         class = "navpageButton pull-right")
        ),
        box(width = 4, solidHeader = TRUE,
            title = tagList(icon("hourglass-end"),
                            "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:"),
            paste0(E1),
            actionButton(inputId = "button5",
                         label = "E1 - Find out more", 
                         class = "navpageButton pull-right")
        ),
        box(width = 4, solidHeader = TRUE,
            title = tagList(icon("hourglass-end"),
                            "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:"),
            paste0(E1),
            actionButton(inputId = "button6",
                         label = "E1 - Find out more", 
                         class = "navpageButton pull-right")
        )
        
        # Closing brackets ----
        
        # ) # End of Main Panel
        # ) # End of fluidPage
)