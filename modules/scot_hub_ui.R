 tabItem(tabName = "scot_hub",

         h1("Scotland Hub"),

### [Timely] ---------------------------

h2("Timely"),
fluidRow(
  box(## T1 ----
      # Header Text
      title = tagList(icon("hospital-user"),
                      # N.B. using paste0 for all text blocks rather than writing out the text
                      # in one go so that there isn't a new line tag inserted when converting R
                      # to HTML, which screenreaders would read out
                      paste0(
                        "T1 - % of people who commence psychological ",
                        "therapy based treatment within 18 weeks of referral ",
                        "(April-June 2025)", ":")),
      width = 4,  solidHeader = TRUE,
      # Body text
      paste0("78.3%"),
      # Navigation button
      actionButton(inputId = "T1_button",
                   label = "T1 - Find out more",
                   class = "navpageButton pull-right")
      # N.B. pull-right class keeps the actionButton aligned right but within the box boundaries
  ),

  box(## T2 ----
      # Header Text
      title = tagList(icon("children"),
                      paste0(
                        "T2 - % of young people who commence treatment by ",
                        "specialist Child and Adolescent Mental Health ",
                        "Services within 18 weeks of referral ",
                        "(April-June 2025)",":")),
      width = 4, solidHeader = TRUE,
      # Body text
      paste0("91.8%"),
      # Navigation button
      actionButton(inputId = "T2_button",
                   label = "T2 - Find out more",
                   class = "navpageButton pull-right")
  ),

  box(## T3 ----
      # Header Text
      title = tagList(icon("wine-bottle"),
                      paste0(
                        "T3 - % of people who wait less than three weeks ",
                        "from referral received to appropriate drug or ",
                        "alcohol treatment that supports their recovery ",
                        "(April-June 2025)",":")),
      width = 4, solidHeader = TRUE,
      # Body text
      paste0("94.3%"),
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
      title = uiOutput("s1_title"),  # dynamic title
      width = 4, solidHeader = TRUE,
      uiOutput("s1_value"),          # dynamic value
      actionButton(
        inputId = "S1_button",
        label = "S1 - Find out more",
        class = "navpageButton pull-right"
      )),

      box(## S2 ----
        title = uiOutput("s2_title"),  # dynamic title
        width = 4, solidHeader = TRUE,
        uiOutput("s2_value"),          # dynamic value
        actionButton(
          inputId = "S2_button",
          label = "S2 - Find out more",
          class = "navpageButton pull-right"
        )),
    
    box(## S5 ----
      title = uiOutput("s5_title"),  # dynamic title
      width = 4, solidHeader = TRUE,
      uiOutput("s5_value"),          # dynamic value
      actionButton(
        inputId = "S5_button",
        label = "S5 - Find out more",
        class = "navpageButton pull-right"
      ))),
    
    br(),
    
    ### [Person Centred] ---------------------------
    
    h2("Person Centred"),
    fluidRow(
      
      box(## P1 ----
          # Header Text
          title = tagList(icon("hand-holding-hand"),
                          paste0(
                            "P1 - % of carers with a mental health condition that felt ",
                            "supported to continue in their caring role ",
                            "(In financial year 2025/26)",":")),
          
          width = 4, solidHeader = TRUE,
          # Body text
          paste0("26%"),
          # Navigation button
          actionButton(inputId = "P1_button", 
                       label = "P1 - Find out more", 
                       class = "navpageButton pull-right")
      ),
      
      box(## P2 ----
          # Header Text
          title = tagList(
            icon("house-medical-circle-check"),
            paste0(
              "P2 - % of adults with MH problems supported at home who agree ",
              "their support had an impact on improving or maintaining their ",
              "quality of life ", "(In financial year 2025/26)",":")),
          width = 4, solidHeader = TRUE,
          # Body text
          paste0("55%"),
          # Navigation button
          actionButton(inputId = "P2_button", 
                       label = "P2 - Find out more", 
                       class = "navpageButton pull-right")
      ),
      
      box(## P3 ----
          # Header Text
          title = tagList(
            icon("hand-holding-heart"),
            paste0(
              'P3 - % of people with a MH problem that agree ',
              'with the statement "people took account of the things ',
              'that mattered to me" ', "(In financial year 2025/26)",":")),
          width = 4, solidHeader = TRUE,
          # Body text
          paste0("56%"),
          # Navigation button
          actionButton(inputId = "P3_button", 
                       label = "P3 - Find out more", 
                       class = "navpageButton pull-right")
      ),
      
      box(## P4 ----
          # Header Text
          title = tagList(
            icon("clipboard-user"),
            paste0("P4 - Number of people with advance statements ",
                   "registered with the Mental Welfare Commission for Scotland ", 
                   "(In financial year 2024/25)",":")),
          width = 4, solidHeader = TRUE,
          # Body text
          paste0("175"),
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
    title = uiOutput("e1_title"),  # dynamic title
    width = 4, solidHeader = TRUE,
    uiOutput("e1_value"),          # dynamic value
    actionButton(
      inputId = "E1_button",
      label = "E1 - Find out more",
      class = "navpageButton pull-right"
    ))),

    br(),

### [Efficient] ---------------------------

    h2("Efficient"),
    fluidRow(
    box(## EF1 ----
    title = uiOutput("ef1_title"),  # dynamic title
    width = 4, solidHeader = TRUE,
    uiOutput("ef1_value"),          # dynamic value
    actionButton(
      inputId = "EF1_button",
      label = "EF1 - Find out more",
      class = "navpageButton pull-right"
    )),
    
    box(## EF2 ----
      title = uiOutput("ef2_title"),  # dynamic title
      width = 4, solidHeader = TRUE,
      uiOutput("ef2_value"),          # dynamic value
      actionButton(
        inputId = "EF2_button",
        label = "EF2 - Find out more",
        class = "navpageButton pull-right"
      )),
    
    box(## EF3 ----
      # Header Text
      title = tagList(
        icon("bed"),
        paste0("EF3 - Total psychiatric inpatient beds per 100,000 population ", 
               "(In financial year 2024/25)", ":")
      ),
      width = 4, solidHeader = TRUE,
      # Body text
      paste0("Total beds: 3,527"),
      # Navigation button
      actionButton(inputId = "EF3_button", 
                   label = "EF3 - Find out more", 
                   class = "navpageButton pull-right")
    ),
    
    box(## EF4 ----
      title = uiOutput("ef4_title"),  # dynamic title
      width = 4, solidHeader = TRUE,
      uiOutput("ef4_value"),          # dynamic value
      actionButton(
        inputId = "EF4_button",
        label = "EF4 - Find out more",
        class = "navpageButton pull-right"
      )), 
    
    box(## EF5 ----
      title = uiOutput("ef5_title"),  # dynamic title
      width = 4, solidHeader = TRUE,
      uiOutput("ef5_value"),          # dynamic value
      actionButton(
        inputId = "EF5_button",
        label = "EF5 - Find out more",
        class = "navpageButton pull-right"
      ))),

    br(),

### [Equitable] ---------------------------
    h2("Equitable"),
    fluidRow(
      box(## EQ1 ----
        title = uiOutput("eq1_title"),  # dynamic title
        width = 4, solidHeader = TRUE,
        uiOutput("eq1_value"),          # dynamic value
        actionButton(
          inputId = "EQ1_button",
          label = "EQ1 - Find out more",
          class = "navpageButton pull-right"
        )),
      
      box(## EQ2 ----
          # Header Text
          title = tagList(icon("scroll"),
                          paste0("EQ2 - Number of emergency detention certificates ",
                                 "per 100,000 population ", "(In financial year 2024/2025)", ":")),
          width = 4, solidHeader = TRUE,
          # Body text
          paste0("69.8"),
          # Navigation button
          actionButton(inputId = "EQ2_button", 
                       label = "EQ2 - Find out more", 
                       class = "navpageButton pull-right")
      ),
      
      box(## EQ4 ----
          title = uiOutput("eq4_title"),  # dynamic title
          width = 4, solidHeader = TRUE,
          uiOutput("eq4_value"),          # dynamic value
          actionButton(
            inputId = "EQ4_button",
            label = "EQ4 - Find out more",
            class = "navpageButton pull-right"
          ))))
    
    