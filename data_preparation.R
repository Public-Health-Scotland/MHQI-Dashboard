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

## EF4 ----
# Import data and rename variables
EF4_data <- read.csv("data/EF4_Relevant variables.csv") %>% 
  rename(fyear = financial_year,
         "Total Net NHS Expenditure (£ millions)" = total_net_nhs_expenditure,
         "Total Mental Health Expenditure (£ millions)" = total_mental_health_expenditure,
         "Mental Health Expenditure (%)" = mental_health_expenditure_as_a_percent_of_total_nhs_expenditure,
         "CAMHS Expenditure (%)" = camhs_as_percent_of_total_nhs_expenditure) %>% 
  tidyr::pivot_longer(cols = -(fyear:hb),
                      names_to = 'measure',
                      values_to = 'value')

EF4_fyear <- EF4_data %>% 
  distinct(fyear) %>% pull(fyear)

EF4_hb_names <- EF4_data %>% 
  distinct(hb_name) %>% pull(hb_name)

EF4_trend_measures <- c('percent_mh', 'percent_camhs')

# EF4_trend_measures <- EF4_data %>% 
#   distinct(measure) %>% pull(measure) %>% 
#   filter(measure = )
