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

