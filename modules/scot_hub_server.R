### [Scot hub server] ----------------------------------------------------

# S1 pull latest year figure ---- 
latest_data <- reactive({
  S1_data %>%
    filter(year_month == max(year_month, na.rm = TRUE)) %>%
    select(year_month, suicide_rate)
})

# Dynamic title
output$s1_title <- renderUI({
  data <- latest_data()
  if (nrow(data) == 0) return(NULL)
  latest_year <- data$year_month[1]
  tagList(
    icon("chart-line"),
    paste0(
      "S1 - Suicide rate per 100,000 population (",
      latest_year, "):"
    )
  )
})

# Dynamic value
output$s1_value <- renderUI({
  data <- latest_data()
  if (nrow(data) == 0) return(NULL)
  strong(round(data$suicide_rate[1], 1))
})
 

# S2 pull highest to lowest value latest quarter figures ---- 
latest_data_s2 <- reactive({
  req(S2_data)
  
  latest_period <- levels(S2_data$year_months)[
    max(as.numeric(S2_data$year_months), na.rm = TRUE)
  ]
  
  S2_data %>%
    filter(year_months == latest_period) %>%
    summarise(
      min_val = min(percentage_followed_up, na.rm = TRUE),
      max_val = max(percentage_followed_up, na.rm = TRUE),
      latest_quarter = first(year_months)
    )
})

# Dynamic title
output$s2_title <- renderUI({
  data <- latest_data_s2()
  if (nrow(data) == 0) return(NULL)
  
  tagList(
    icon("brain"),
    paste0(
      "S2 - % of all discharged psychiatric inpatients ",
      "followed-up by community mental health services ",
      "within 7 calendar days (", data$latest_quarter, "):"
    )
  )
})

# Dynamic value 
output$s2_value <- renderUI({
  data <- latest_data_s2()
  if (nrow(data) == 0) return(NULL)
  
  min_val <- round(data$min_val, 1)
  max_val <- round(data$max_val, 1)
  
  strong(
    paste0(min_val, "% to ", max_val, "% across health boards")
  )
})

# S5 pull highest to lowest latest quarter figures ---- 
latest_data_s5 <- reactive({
  req(S5_data)
  
  latest_period <- levels(S5_data$year_months)[
    max(as.numeric(S5_data$year_months), na.rm = TRUE)
  ]
  
  S5_data %>%
    filter(year_months == latest_period) %>%
    summarise(
      min_val = min(incidents_per_1000_bed_days, na.rm = TRUE),
      max_val = max(incidents_per_1000_bed_days, na.rm = TRUE),
      latest_quarter = first(year_months)
    )
})


# Title output
output$s5_title <- renderUI({
  data <- latest_data_s5()
  if (nrow(data) == 0) return(NULL)
  
  tagList(
    icon("hand-fist"),
    paste0(
      "S5 - Incidents of physical violence per ",
      "1,000 occupied psychiatric bed days (", data$latest_quarter, "):"
    )
  )
})

# Dynamic value 
output$s5_value <- renderUI({
  data <- latest_data_s5()
  if (nrow(data) == 0) return(NULL)
  
  min_val <- round(data$min_val, 1)
  max_val <- round(data$max_val, 1)
  
  strong(
    paste0(min_val, " to ", max_val, " across health boards")
  )
})

# E1 pull latest year figure for Scotland ---- 
latest_data_e1 <- reactive({
   E1_data %>%
    filter(area_name == "Scotland", 
           as.character(fyear) == max(as.character(fyear))) |> 
    select(fyear, rate_per_1000_population)
})

# Dynamic title
output$e1_title <- renderUI({
  data <- latest_data_e1()
  if (nrow(data) == 0) return(NULL)
  latest_fyear <- data$fyear[1]
  tagList(
    icon("hospital"),
    paste0("E1 - Days in hospital when clinically 
       ready to discharge, per 1,000 population (In financial year ",
      latest_fyear, "):"
    )
  )
})

# Dynamic value
output$e1_value <- renderUI({
  data <- latest_data_e1()
  if (nrow(data) == 0) return(NULL)
  strong(round(data$rate_per_1000_population[1], 1))
})

# EF1 pull latest quarter figure for Scotland ---- 
latest_data_ef1 <- reactive({
  EF1_data %>%
    filter(hb_name == "NHS Scotland",
           as.integer(year_months) == max(as.integer(year_months))) |> 
    select(year_months, bedday_rate)
})

# Dynamic title
output$ef1_title <- renderUI({
  data <- latest_data_ef1()
  if (nrow(data) == 0) return(NULL)
  latest_quarter <- data$year_months[1]
  tagList(
    icon("bed-pulse"),
    paste0("EF1 - Rate of emergency bed days for adults per 100,000 population (",
            latest_quarter, "):"
    )
  )
})

# Dynamic value
output$ef1_value <- renderUI({
  data <- latest_data_ef1()
  if (nrow(data) == 0) return(NULL)
  
  # add comma and round to 1dp
  formatted_value <- comma(round(data$bedday_rate[1], 1))
  
  strong(formatted_value)
})


# EF2 pull latest quarter figure for Scotland ---- 
latest_data_ef2 <- reactive({
  EF2_data %>%
    filter(Board == "NHS Scotland",
           as.integer(year_months) == max(as.integer(year_months))) |> 
    select(year_months, x28_days_readmission_rate_percentage_quarter)
})

# Dynamic title
output$ef2_title <- renderUI({
  data <- latest_data_ef2()
  if (nrow(data) == 0) return(NULL)
  latest_quarter <- data$year_months[1]
  tagList(
    icon("arrows-rotate"),
    paste0("EF2 - % of readmissions to hospital within 28 days of discharge (",
            latest_quarter, "):"
    )
  )
})

# Dynamic value
output$ef2_value <- renderUI({
  data <- latest_data_ef2()
  if (nrow(data) == 0) return(NULL)
  
  strong(paste0(round(data$x28_days_readmission_rate_percentage_quarter[1], 1), "%"))
})

# EF4 pull latest year figure for Scotland ---- 
latest_data_ef4 <- reactive({
  EF4_data %>%
    filter(hb_name == "NHS Scotland", 
           measure == "Mental Health Expenditure",
           as.character(fyear) == max(as.character(fyear))) |> 
    select(fyear, value)
})

# Dynamic title
output$ef4_title <- renderUI({
  data <- latest_data_ef4()
  if (nrow(data) == 0) return(NULL)
  latest_fyear <- data$fyear[1]
  tagList(
    icon("sterling-sign"),
    paste0("EF4 - Total mental health spend as a % of total NHS spend (In financial year ", 
           latest_fyear, "):"
    )
  )
})

# Dynamic value
output$ef4_value <- renderUI({
  data <- latest_data_ef4()
  if (nrow(data) == 0) return(NULL)
  
  strong(paste0(round(data$value[1], 2), "%"))
})

# EF5 pull highest to lowest latest quarter figures ---- 
latest_data_ef5 <- reactive({
  req(EF5_data) # Replace with your actual dataset variable

  EF5_data %>%
    filter(measure == "Percentage 'Did Not Attend' appointments",
           as.integer(year_months) == max(as.integer(year_months))) |> 
    summarise(
      min_val = min(value, na.rm = TRUE),
      max_val = max(value, na.rm = TRUE),
      latest_quarter = first(year_months))
})

# Title output
output$ef5_title <- renderUI({
  data <- latest_data_s5()
  if (nrow(data) == 0) return(NULL)
  
  tagList(
    icon("circle-xmark"),
    paste0(
      "EF5 - % of 'did not attend appointments' for ",
      "community based services (Mental Health ", data$latest_quarter, "):"
    )
  )
})

# Dynamic value
output$ef5_value <- renderUI({
  data <- latest_data_ef5()
  if (nrow(data) == 0) return(NULL)
  
  min_val <- round(data$min_val, 1)
  max_val <- round(data$max_val, 1)
  
  strong(
    paste0(min_val, "% to ", max_val, "% across health boards")
  )
})

#EQ1 pull latest year figure ---- 
latest_data_eq1 <- reactive({
  EQ1_data %>%
    filter(area_name == "NHS Scotland") |> 
    mutate(Year = as.numeric(as.character(Year))) |> 
    filter(Year == max(Year, na.rm = TRUE)) |> 
    select(Year, risk_ratio)
})

# Dynamic title
output$eq1_title <- renderUI({
  data <- latest_data_eq1()
  if (nrow(data) == 0) return(NULL)
  latest_year <- data$Year[1]
  tagList(
    icon("chart-column"),
    paste0(
      "EQ1 - Premature mortality rate for persons ",
      "in contact with mental health services (In calendar year ",
      latest_year, "):"
    )
  )
})

# Dynamic value
output$eq1_value <- renderUI({
  data <- latest_data_eq1()
  if (nrow(data) == 0) return(NULL)
  strong(round(data$risk_ratio[1], 2), "times higher than the general population")
})

#EQ4 pull latest year figure ----
latest_data_eq4 <- reactive({
    EQ4_data %>%
    filter(board == "NHS Scotland") %>%
    filter(as.integer(year_month) == max(as.integer(year_month))) %>%
    select(year_month, perc)
})

# Dynamic title
output$eq4_title <- renderUI({
  data <- latest_data_eq4()
  if (nrow(data) == 0) return(NULL)
  latest_quarter <- data$year_month[1]
  tagList(
    icon("hands-holding-child"),
    paste0("EQ4 - % of under 18 psychiatric admissions ",
           "admitted outwith specialist CAMH wards (",
           latest_quarter, "):"
    )
  )
})


# Dynamic value
output$eq4_value <- renderUI({
  data <- latest_data_eq4()
  if (nrow(data) == 0) return(NULL)
  
  strong(paste0(round(data$perc[1], 1), "%"))
})