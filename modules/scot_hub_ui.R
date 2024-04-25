tabItem(tabName = scot_hub,

        ### [Row 1] ---------------------------
        
        h1("Timely"),
        fluidRow(
          box(## T1 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "T1 - % of people who commence psychological ",
                              "therapy based treatment within 18 weeks of referral ",
                              T1_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(T1,"%"),
            # Navigation button
            actionButton(inputId = "T1_button", 
                         label = "T1 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(## T2 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "% of young people who commence treatment by ",
                              "specialist Child and Adolescent Mental Health ",
                              "services within 18 weeks of referral ",
                              T2_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(T2,"%"),
            # Navigation button
            actionButton(inputId = "T2_button", 
                         label = "T2 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(## T3 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "T3 - % of people who commence psychological therapy ",
                              "based treatment within 18 weeks of referral ",
                              T3_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(T3,"%"),
            # Navigation button
            actionButton(inputId = "T3_button", 
                         label = "T3 - Find out more", 
                         class = "navpageButton pull-right")
          )
        ),
        
        br(),
        
        ### [Row 2] ---------------------------
        
        h1("Safe"),
        fluidRow(
          
          box(## S1 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "S1 - Suicide rates per 100,000 population ",
                              S1_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(S1),
            # Navigation button
            actionButton(inputId = "S1_button", 
                         label = "S1 - Find out more", 
                         class = "navpageButton pull-right")
            ),
          
          box(## S2 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0("S2 - % of all Discharged Psychiatric Inpatients ",
                                   "followed-up by Community Mental Health Services ",
                                   "within 7 Calendar Days ", S2_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(S2_low,"% to ",S2_high,"%"),
            # Navigation button
            actionButton(inputId = "S2_button", 
                         label = "S2 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(## S5 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "S5 - incidents of Physical Violence per ",
                              "1,000 occupied Psychiatric Bed Days ",
                              S5_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(S5_low,"to",S5_high),
            # Navigation button
            actionButton(inputId = "S5_button", 
                         label = "S5 - Find out more", 
                         class = "navpageButton pull-right")
          )
        ),
        
        br(),
        
        ### [Row 3] ---------------------------
        
        h1("Person Centred"),
        fluidRow(
          
          box(## P1 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "P1 - Suicide rates per 100,000 population ",
                              P1_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(P1,"%"),
            # Navigation button
            actionButton(inputId = "P1_button", 
                         label = "P1 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(## P2 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "P2 - % of Adults with MH Problems supported at home ",
                              "who agree their support had an impact on improving ",
                              "or maintaining their quality of life ", 
                              P2_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(P2,"%"),
            # Navigation button
            actionButton(inputId = "P2_button", 
                         label = "P2 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(## P3 ----
              # Header Text
              title = tagList(icon("hourglass-end"),
                              paste0(
                                "P3 - % of people with a mental health problem ",
                                'that agree with the statement "people took account ',
                                'of the things that mattered to me" ',
                                P3_dateText,":")),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0(P3,"%"),
              # Navigation button
              actionButton(inputId = "P3_button", 
                           label = "P3 - Find out more", 
                           class = "navpageButton pull-right")
          )
        ),
        br(),
        
        ### [Row 4] ---------------------------
        
        fluidRow(
          column(4, h1(" "), # To space the boxes properly
                 box(## P4 ----
                     # Header Text
                     title = tagList(icon("hourglass-end"),
                                     paste0(
                                       "P4 - number of people with Advance Statements ",
                                       "registered in ", P4_dateText,":")),
                     width = "100%", solidHeader = TRUE,
                     # Body text
                     paste0(P4),
                     # Navigation button
                     actionButton(inputId = "P4_button", 
                                  label = "P4 - Find out more", 
                                  class = "navpageButton pull-right")
                 )
                 ),
          
          column(4, h1("Effective"),
                 box(## E1 ----
                   # Link in title instead of button
                   title = actionLink("E1_button",
                                      "E1 - Days in hospital when clinically 
                                     ready to discharge, per 1,000 population:",
                                     icon = icon("refresh")),
                   width = "100%", solidHeader = TRUE,
                   paste0(E1)
                 )),
          
          column(4, h1("Efficient"),
                 box(## EF1 ----
                   # Header Text
                   title = tagList(icon("hourglass-end"),
                                   "EF1 - Rate of Emergency Bed Days for Adults:"),
                   width = "100%", solidHeader = TRUE,
                   # Body text
                   paste0(E1,"%"),
                   # Navigation button
                   actionButton(inputId = "EF1_button", 
                                label = "EF1 - Find out more", 
                                class = "navpageButton pull-right")
                   )
                 
                 
                ) # End of column
          ),
        
        br(),
        
        ### [Row 5] ---------------------------
        
        fluidRow(
          box(## EF2 ----
              # Header Text
              title = tagList(icon("hourglass-end"),
                              paste0("EF2 - % of Readmissions to hospital ",
                                     "within 28 Days of Discharge:")
              ),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0(E1,"%"),
              # Navigation button
              actionButton(inputId = "EF2_button", 
                           label = "EF2 - Find out more", 
                           class = "navpageButton pull-right")
          ),
          
          # EF3 ----
          box(
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0("EF3 - Total Psychiatric Inpatient Beds ",
                                   "per 100,000 population:")
            ),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(EF3),
            # Navigation button
            actionButton(inputId = "EF3_button", 
                         label = "EF3 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          # EF4 ----
          box(
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0("EF4 - Total Mental Health Spend as a % ",
                                   "of Total Spend:")
            ),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(EF4,"% (2020/21)"),
            # Navigation button
            actionButton(inputId = "EF4_button", 
                         label = "EF4 - Find out more", 
                         class = "navpageButton pull-right")
          )
          
        ),
        
        br(),
        
        ### [Row 6] ---------------------------
        
        fluidRow(
          
          box(# EF5 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0("EF5 - % of Did Not Attend Appointments for ",
                                   "Community based services (Mental Health October - December 2021):")
            ),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(EF5_low,"% - ",EF5_high, "%"),
            # Navigation button
            actionButton(inputId = "EF5_button", 
                         label = "EF5 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(## EQ1 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0("EQ1 - Premature Mortality rate for Persons ",
                                   "in contact with Mental Health Services (2020/21):")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(EQ1,"times higher than general"),
            # Navigation button
            actionButton(inputId = "EQ1_button", 
                         label = "EQ1 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          
          box(## EQ2 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0("EQ2 - Number of Emergency Detention Certificates ",
                                   "per 100,000 population (2020/21):")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(EQ2),
            # Navigation button
            actionButton(inputId = "EQ2_button", 
                         label = "EQ2 - Find out more", 
                         class = "navpageButton pull-right")
          )
          
          
        ),
        
        br(),
        
        ### [Row 7] ---------------------------
        
        fluidRow(
          box(## EQ3 ----
              # Header Text
              title = tagList(icon("hourglass-end"),
                              paste0("EQ3 - % of people with Severe and Enduring ",
                                     "Mental Illness and/or Learning Disability ",
                                     "who have had an annual health check within ",
                                     "previous 12 months:")),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0("Two NHS Boards advised: ", EQ3,"%"),
              # Navigation button
              actionButton(inputId = "EQ3_button", 
                           label = "EQ3 - Find out more", 
                           class = "navpageButton pull-right")
          ),
          
          box(## EQ4 ----
              # Header Text
              title = tagList(icon("hourglass-end"),
                              paste0("EQ4 - Premature Mortality rate for Persons ",
                                     "in contact with Mental Health Services (2020/21):")),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0(EQ4,"times higher than general"),
              # Navigation button
              actionButton(inputId = "EQ4_button", 
                           label = "EQ4 - Find out more", 
                           class = "navpageButton pull-right")
          )
        )
) # End of tabItem