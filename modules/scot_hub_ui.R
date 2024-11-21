tabItem(tabName = "scot_hub",
        
        h1("Scotland Hub"),

        ### [Timely] ---------------------------
        
        h2("Timely"),
        fluidRow(
          box(## T1 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            # N.B. using paste0 for all text blocks rather than writing out the text 
                            # in one go so that there isn't a new line tag inserted when converting R 
                            # to HTML, which screenreaders would read out
                            paste0( 
                              "T1 - % of people who commence psychological ",
                              "therapy based treatment within 18 weeks of referral ",
                              T1_ScotlandHub_dateText, ":")),  
            width = 4,  solidHeader = TRUE,
            # Body text
             paste0(T1_ScotlandHub_value,"%"),             
            # Navigation button
            actionButton(inputId = "T1_button", 
                         label = "T1 - Find out more", 
                         class = "navpageButton pull-right") 
            # N.B. pull-right class keeps the actionButton aligned right but within the box boundaries
          ),
          
          box(## T2 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "T2 - % of young people who commence treatment by ",
                              "specialist Child and Adolescent Mental Health ",
                              "Services within 18 weeks of referral ",
                              T2_ScotlandHub_dateText,":")),   
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(T2_ScotlandHub_value,"%"),     
            # Navigation button 
            actionButton(inputId = "T2_button", 
                         label = "T2 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(## T3 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "T3 - % of people who wait less than three weeks ",
                              "from referral received to appropriate drug or ",
                              "alcohol treatment that supports their recovery ",
                               T3_ScotlandHub_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
              paste0(T3_ScotlandHub_value,"%"),
            # Navigation button
            actionButton(inputId = "T3_button", 
                         label = "T3 - Find out more", 
                         class = "navpageButton pull-right")
          )
        ),
        
        br(),
        
        ### [Safe] ---------------------------
        
        h2("Safe"),
        fluidRow(
          
          box(## S1 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "S1 - Suicide rates per 100,000 population ",
                           S1_ScotlandHub_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(S1_ScotlandHub_value), 
            # Navigation button
            actionButton(inputId = "S1_button", 
                         label = "S1 - Find out more", 
                         class = "navpageButton pull-right")
            ),
          
          box(## S2 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0("S2 - % of all discharged psychiatric inpatients ",
                                   "followed-up by Community Mental Health Services ",
                                   "within 7 Calendar Days ", S2_ScotlandHub_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(S2_ScotlandHub_value),
            # Navigation button
            actionButton(inputId = "S2_button", 
                         label = "S2 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(## S5 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "S5 - incidents of physical violence per ",
                              "1,000 occupied psychiatric bed days ",
                              S5_ScotlandHub_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(S5_ScotlandHub_value),
            # Navigation button
            actionButton(inputId = "S5_button", 
                         label = "S5 - Find out more", 
                         class = "navpageButton pull-right")
          )
        ),
        
        br(),
        
        ### [Person Centred] ---------------------------
        
        h2("Person Centred"),
        fluidRow(
          
          box(## P1 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0(
                              "P1 - % of carers with a mental health condition that felt ",
                              "supported to continue in their caring role ",
                            P1_ScotlandHub_dateText,":")),
           
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(P1_ScotlandHub_value),
            # Navigation button
            actionButton(inputId = "P1_button", 
                         label = "P1 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(## P2 ----
            # Header Text
            title = tagList(
              icon("hourglass-end"),
              paste0(
                "P2 - % of adults with MH problems supported at home who agree ",
                "their support had an impact on improving or maintaining their ",
                "quality of life ", P2_ScotlandHub_dateText,":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(P2_ScotlandHub_value),
            # Navigation button
            actionButton(inputId = "P2_button", 
                         label = "P2 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(## P3 ----
              # Header Text
              title = tagList(
                icon("hourglass-end"),
                paste0(
                  'P3 - % of people with a MH problem that agree ',
                  'with the statement "people took account of the things ',
                  'that mattered to me" ', P3_ScotlandHub_dateText,":")),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0(P3_ScotlandHub_value),
              # Navigation button
              actionButton(inputId = "P3_button", 
                           label = "P3 - Find out more", 
                           class = "navpageButton pull-right")
          ),
          
          box(## P4 ----
              # Header Text
              title = tagList(
                icon("clipboard"),
                paste0("P4 - Number of people with advance statements ",
                       "registered with the Mental Welfare Commission for Scotland ", 
                       P4_ScotlandHub_dateText,":")),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0(P4_ScotlandHub_value),
              # Navigation button
              actionButton(inputId = "P4_button", 
                           label = "P4 - Find out more", 
                           class = "navpageButton pull-right")
              
          )),
        
        br(),
        
        ### [Effective] ---------------------------
        
        h2("Effective"),
        fluidRow(
          
          box(## E1 ----
              title = tagList(
                icon("hourglass-end"),
                paste0("E1 - Days in hospital when clinically 
                       ready to discharge, per 1,000 population ", 
                       E1_ScotlandHub_dateText, ":")),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0(E1_ScotlandHub_value),
              # Navigation button
              actionButton(inputId = "E1_button", 
                           label = "E1 - Find out more", 
                           class = "navpageButton pull-right")
          
          )),
        
        br(),
        
        ### [Efficient] ---------------------------
        
        h2("Efficient"),
        fluidRow(
          
          box(## EF1 ----
              # Header Text
              title = tagList(
                icon("bed"),
                "EF1 - Rate of emergency bed days for adults per 100,000 population ", 
                EF1_ScotlandHub_dateText, ":"),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0(EF1_ScotlandHub_value),
              # Navigation button
              actionButton(inputId = "EF1_button", 
                           label = "EF1 - Find out more", 
                           class = "navpageButton pull-right")
          ),
          
          box(## EF2 ----
              # Header Text
              title = tagList(
                icon("refresh"),
                paste0("EF2 - % of readmissions to hospital within 28 Days of discharge ", 
                       EF2_ScotlandHub_dateText, ":")
              ),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0(EF2_ScotlandHub_value, "%"),
              # Navigation button
              actionButton(inputId = "EF2_button", 
                           label = "EF2 - Find out more", 
                           class = "navpageButton pull-right")
          ),
          
          # EF3 ----
          box(
            # Header Text
            title = tagList(
              icon("bed"),
              paste0("EF3 - Total psychiatric inpatient beds per 100,000 population ", 
                     EF3_ScotlandHub_dateText, ":")
            ),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(EF3_ScotlandHub_value),
            # Navigation button
            actionButton(inputId = "EF3_button", 
                         label = "EF3 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(# EF4 ----
            # Header Text
            title = tagList(
              icon("sterling-sign"),
              paste0("EF4 - Total mental health spend as a % of total NHS spend ", 
                     EF4_ScotlandHub_dateText, ":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(EF4_ScotlandHub_value, "%"),
            # Navigation button
            actionButton(inputId = "EF4_button", 
                         label = "EF4 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          box(# EF5 ----
              # Header Text
              title = tagList(icon("hourglass-end"),
                              paste0("EF5 - % of 'did not attend appointments' for ",
                                     "community based services (Mental Health ", 
                                     EF5_ScotlandHub_dateText, "):")
              ),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0("Ranges from: ", EF5_ScotlandHub_value_low,"% - ",
                     EF5_ScotlandHub_value_high, "%"),
              # Navigation button
              actionButton(inputId = "EF5_button", 
                           label = "EF5 - Find out more", 
                           class = "navpageButton pull-right")
          )
          
        ),
        
        br(),
        
        ### [Equitable] ---------------------------
        
        h2("Equitable"),
        fluidRow(
          
          box(## EQ1 ----
            # Header Text
            title = tagList(icon("hourglass-end"),
                            paste0("EQ1 - Premature mortality rate for persons ",
                                   "in contact with mental health services ", 
                                   EQ1_ScotlandHub_dateText, ":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(EQ1_ScotlandHub_value, " times higher than the general population"),
            # Navigation button
            actionButton(inputId = "EQ1_button", 
                         label = "EQ1 - Find out more", 
                         class = "navpageButton pull-right")
          ),
          
          
          box(## EQ2 ----
            # Header Text
            title = tagList(icon("clipboard"),
                            paste0("EQ2 - Number of emergency detention certificates ",
                                   "per 100,000 population ", EQ2_ScotlandHub_dateText, ":")),
            width = 4, solidHeader = TRUE,
            # Body text
            paste0(EQ2_ScotlandHub_value),
            # Navigation button
            actionButton(inputId = "EQ2_button", 
                         label = "EQ2 - Find out more", 
                         class = "navpageButton pull-right")
          ),
# EQ3 is a new indicator and not being published this year          
          # box(## EQ3 ----
          #     # Header Text
          #     title = tagList(icon("hourglass-end"),
          #                     paste0("EQ3 - % of people with Severe and Enduring ",
          #                            "Mental Illness and/or Learning Disability ",
          #                            "who have had an annual health check within ",
          #                            "previous 12 months ", 
          #                            EQ3_ScotlandHub_dateText, ":")),
          #     width = 4, solidHeader = TRUE,
          #     # Body text
          #     paste0("Two NHS Boards advised: ", EQ3_ScotlandHub_value, "%"),
          #     # Navigation button
          #     actionButton(inputId = "EQ3_button", 
          #                  label = "EQ3 - Find out more", 
          #                  class = "navpageButton pull-right")
          # ),
          
          
          box(## EQ4 ----
              # Header Text
              title = tagList(icon("child"),
                              paste0(
                                "EQ4 - % of under 18 psychiatric admissions ",
                                "admitted outwith specialist CAMH wards ", 
                                EQ4_ScotlandHub_dateText, ":")),
              width = 4, solidHeader = TRUE,
              # Body text
              paste0(EQ4_ScotlandHub_value, "%"),
              # Navigation button
              actionButton(inputId = "EQ4_button", 
                           label = "EQ4 - Find out more", 
                           class = "navpageButton pull-right")
          )
        )
) # End of tabItem