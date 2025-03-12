### Data preparation script
# N.B. do not use any direct filepaths, ony relational ones

### [Indicators] ----
## E1 ----
E1_data <- read.csv("data/E1.csv") %>% 
  rename(dd_bed_days = delayed_discharge_bed_days,
         fyear = financial_year)

E1_area_types <- E1_data %>% 
  distinct(area_type) %>% pull(area_type)

# For E1 plot 2:
E1_fyear <- E1_data %>% 
   distinct(fyear) %>% 
   pull(fyear)

## EQ1 ----
EQ1_data <- read.csv("data/EQ1.csv") 

unique_area_types <- EQ1_data %>% 
  distinct(area_type) %>% pull(area_type)

# For EQ1 plot 2:
EQ1_reformatted_data <- read.csv("data/EQ1_Reformatted.csv")%>% 
   mutate(Rate = round(Rate))        # because values are e.g. "3158.23942548425913"

unique_area_types_reformatted <- EQ1_reformatted_data %>% 
  distinct(area_type) %>% pull(area_type)


## EF4 ----
EF4_data <- read.csv("data/EF4.csv") %>% 
  select(fyear, hb_name, measure, value)

EF4_fyear <- EF4_data %>% 
  distinct(fyear) %>% pull(fyear)

EF4_hb_names <- EF4_data %>% 
  distinct(hb_name) %>% pull(hb_name)

EF4_trend_measures <- c('Mental Health Expenditure (%)', 'CAMHS Expenditure (%)')

# EF4_trend_measures <- EF4_data %>% 
#   distinct(measure) %>% pull(measure) %>% 
#   filter(measure = )


## EF5 ----
EF5_data <- read.csv("data/EF5.csv") %>% 
  # Below line is not needed, but keeping in as it shows the variable names clearly
  select(hb_name, year_months, measure, value) %>% 
  # So that months aren't alphabetical:
  mutate(year_months = fct_relevel(year_months, 
                                   "Jan-Mar 2022", "Apr-Jun 2022", 
                                   "Jul-Sep 2022", "Oct-Dec 2022", 
                                   "Jan-Mar 2023", "Apr-Jun 2023", 
                                   "Jul-Sep 2023", "Oct-Dec 2023",
                                   "Jan-Mar 2024", "Apr-Jun 2024", 
                                   "Jul-Sep 2024", "Oct-Dec 2024"#,
                                   #"Jan-Mar 2025", "Apr-Jun 2025", 
                                   #"Jul-Sep 2025", "Oct-Dec 2025"
  ))

# Isolating necessary values for selectors
EF5_quarter <- EF5_data %>% 
  distinct(year_months) %>% pull(year_months)

EF5_hb_names <- EF5_data %>% 
  distinct(hb_name) %>% pull(hb_name)

EF5_trend_measures <- EF5_data %>% 
  distinct(measure) %>%  pull(measure)

# Create data for measures bar chart
EF5_measure_data <- EF5_data %>% 
  filter(measure != "Percentage 'Did Not Attend' appointments")

# # Isolate measures for measurePlot bar elements
# EF5_number_measures <- EF5_data %>% 
#   subset(measure != "Percentage 'Did Not Attend' appointments") %>% 
#   distinct(measure) %>%  pull(measure)
    
# Isolate measure data for measurePlot line element overlay
EF5_percentage_measure <- EF5_data %>% 
  subset(measure == "Percentage 'Did Not Attend' appointments") %>% 
  select(!measure) %>% rename(percentage = value)


## S2 ---- 

S2_data <- read.csv("data/S2.csv") %>% 
   # So that months aren't alphabetical:
   mutate(year_months = fct_relevel(year_months, 
                                    "Jan-Mar 2022", "Apr-Jun 2022", 
                                    "Jul-Sep 2022", "Oct-Dec 2022", 
                                    "Jan-Mar 2023", "Apr-Jun 2023", 
                                    "Jul-Sep 2023", "Oct-Dec 2023",
                                    "Jan-Mar 2024", "Apr-Jun 2024", 
                                    "Jul-Sep 2024", "Oct-Dec 2024"#,
                                    #"Jan-Mar 2025", "Apr-Jun 2025", 
                                    #"Jul-Sep 2025", "Oct-Dec 2025"
                                    )
          )

S2_pivoted_data <- S2_data %>% 
   select(nhs_health_board, year_months, number_of_patients_followed_up,
          total_number_of_discharged_patients) %>%
   rename("Number of patients followed up" = "number_of_patients_followed_up", 
          "Total number of discharged inpatients" = "total_number_of_discharged_patients") %>% 
   tidyr::pivot_longer(cols = c("Number of patients followed up", "Total number of discharged inpatients"),
                       names_to = "total_or_followed_up",
                       values_to = "number",
                       values_drop_na = FALSE) %>%
   mutate(number = as.double(number)) %>% 
   mutate(total_or_followed_up = fct_relevel(total_or_followed_up, 
                                             "Total number of discharged inpatients", 
                                             "Number of patients followed up"))



## S5 ---- 

S5_data <- read.csv("data/S5.csv") %>% 
   # So that months aren't alphabetical:
   mutate(year_months = fct_relevel(year_months, 
                                    "Jan-Mar 2022", "Apr-Jun 2022", 
                                    "Jul-Sep 2022", "Oct-Dec 2022", 
                                    "Jan-Mar 2023", "Apr-Jun 2023", 
                                    "Jul-Sep 2023", "Oct-Dec 2023",
                                    "Jan-Mar 2024", "Apr-Jun 2024", 
                                    "Jul-Sep 2024", "Oct-Dec 2024"#,
                                    #"Jan-Mar 2025", "Apr-Jun 2025", 
                                    #"Jul-Sep 2025", "Oct-Dec 2025"
   ))



