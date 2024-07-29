## Data preparation script
# N.B. do not use any direct filepaths, ony relational ones

## [Indicators] ----
# E1 ----
E1_data <- read.csv("data/E1.csv") %>% 
  rename(dd_bed_days = delayed_discharge_bed_days,
         fyear = financial_year)

unique_area_types <- E1_data %>% 
  distinct(area_type) %>% pull(area_type)

# For E1 plot 2:
unique_fyear <- E1_data %>% 
   distinct(fyear) %>% 
   pull(fyear)

# EQ1 ----
EQ1_data <- read.csv("data/EQ1.csv") 

unique_area_types <- EQ1_data %>% 
  distinct(area_type) %>% pull(area_type)

