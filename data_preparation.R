### Data preparation script
# N.B. do not use any direct filepaths, ony relational ones


### Function for calendar months ---- 
# To be used in S2, S5 and EF5 where months are appearing as alphabetical 

months_function <- function(dat, var) { 
   dat %>% 
      mutate({{var}} := fct_relevel({{var}}, 
                                    "Jan-Mar 2022", "Apr-Jun 2022", 
                                    "Jul-Sep 2022", "Oct-Dec 2022", 
                                    "Jan-Mar 2023", "Apr-Jun 2023", 
                                    "Jul-Sep 2023", "Oct-Dec 2023",
                                    "Jan-Mar 2024", "Apr-Jun 2024", 
                                    "Jul-Sep 2024", "Oct-Dec 2024",
                                    "Jan-Mar 2025", "Apr-Jun 2025", 
                                    "Jul-Sep 2025", #"Oct-Dec 2025",
                                  #  "Jan-Mar 2026", "Apr-Jun 2026", 
                                  #  "Jul-Sep 2026", "Oct-Dec 2026"))
      ))
   }


### [Indicators] ----
## E1 ----
E1_data <- read.csv("data/E1.csv") %>% 
  rename(dd_bed_days = delayed_discharge_bed_days,
         fyear = financial_year) %>% 
   # Have fyears as a factor in case there are any NAs in the data - the axis will
   # skip the year if there is no data
   mutate(fyear = factor(fyear, levels = 
                            c("2016/17", "2017/18", "2018/19", 
                              "2019/20", "2020/21", "2021/22", 
                              "2022/23", "2023/24", "2024/25"))) %>% 
                              # , "2025/26")))
   arrange(fyear)

E1_area_types <- E1_data %>% 
  distinct(area_type) %>% pull(area_type)

# For E1 plot 2:
E1_fyear <- E1_data %>% 
   distinct(fyear) %>% 
   pull(fyear)



## EQ1 ----
EQ1_data <- read.csv("data/EQ1.csv") 

# Years need to be factored so they appear on graph even if there's no data 
# This will update automatically but the graph ranges may need to be added to
EQ1_distinct_years <- EQ1_data %>% distinct(Year) %>% pull

EQ1_data <- EQ1_data %>% 
   mutate(Year = factor(Year, levels = EQ1_distinct_years))
                         

EQ1_unique_area_types <- EQ1_data %>% 
  distinct(area_type) %>% pull(area_type)

# For EQ1 plot 2:
EQ1_reformatted_data <- read.csv("data/EQ1_Reformatted.csv")%>% 
   mutate(Rate = round(Rate)) %>%   # because values are e.g. "3158.23942548425913"
   mutate(Year = factor(Year, levels = EQ1_distinct_years))


# Create data for EQ1 bar plot (need one column for each bar trace)
EQ1_plot2_data <- EQ1_reformatted_data %>% 
  pivot_wider(names_from = Rate_Type,
              values_from = Rate) %>% 
  rename(mh_rate = "Mental Health Population Rate",
         genpop_rate = "General Population Rate")

## EF2 ----
# EF2_data <- read.csv("data/EF2.csv") %>% 
#   # Below line is not needed, but keeping in as it shows the variable names clearly
#  select(Board, quarter_fy, x28_days_readmission_rate_percentage_quarter)

EF2 <- read_excel(
  paste0("data/EF2.xlsx")) |> 
  #replace NAs with 0 (double checked this with Craig from Discovery)
  mutate(across(everything(), ~ replace_na(., 0))) |> 
  #year and month column
  separate(`Month of Discharge (original CIS)`, into = c("year", "month"), sep = "-", remove = FALSE) |> 
  mutate(months = case_when(
    month %in% c("04", "05", "06") ~ "Apr-Jun",
    month %in% c("07", "08", "09") ~ "Jul-Sep",
    month %in% 10:12 ~ "Oct-Dec",
    month %in% c("01", "02", "03") ~ "Jan-Mar")) |> 
  #unite year and month column for analysis
unite(year_months, c (months, year), sep = " ", remove = FALSE) |> 
  # quarters calculation
  group_by(Board, year_months) %>%
  mutate(total_readmissions_quarter = sum(`Number of Readmissions`), 
         total_admissions_quarter = sum(`Number Of Admissions`)) %>% 
  ungroup() %>% 
  mutate(x28_days_readmission_rate_percentage_quarter = round((total_readmissions_quarter / total_admissions_quarter) * 100, 1)) 
 


EF2_data <- EF2 |>
  ## Below line is not needed, but keeping in as it shows the variable names clearly
  select(Board, year_months, x28_days_readmission_rate_percentage_quarter) |>
  #one observation per quarter
  group_by(Board) |>
  distinct(year_months, .keep_all = TRUE)  |> 
  # unite(year_months, c (months, year), sep = " ", remove = FALSE) |> 
  mutate(year_months = factor(year_months, levels =
                                c( "Apr-Jun 2022",
                                   "Jul-Sep 2022", "Oct-Dec 2022",
                                   "Jan-Mar 2023", "Apr-Jun 2023",
                                   "Jul-Sep 2023", "Oct-Dec 2023",
                                   "Jan-Mar 2024", "Apr-Jun 2024",
                                   "Jul-Sep 2024", "Oct-Dec 2024",
                                   "Jan-Mar 2025", "Apr-Jun 2025",
                                   "Jul-Sep 2025")))

EF2_hb_names <- EF2 %>%
  distinct(Board) %>% pull(Board)


## EF4 ----
EF4_data <- read.csv("data/EF4.csv") %>% 
  select(fyear, hb_name, measure, value) %>% 
  # filter out State Hospital and Golden Jubilee
  filter(hb_name != "National Waiting Times Centre (Golden Jubilee)" &
           hb_name != "State Hospital") %>% 
   # Remove the (%) from variable names used in graph 
   mutate(measure = if_else(measure == "Mental Health Expenditure (%)", 
                            "Mental Health Expenditure", measure)) %>% 
   mutate(measure = if_else(measure == "CAMHS Expenditure (%)", 
                            "CAMHS Expenditure", measure)) %>% 
   # Years need to be factored so they appear on graph even if there's no data - add each update
   mutate(fyear = factor(fyear, levels = 
                            c("2012/13", "2013/14", "2014/15", 
                              "2015/16", "2016/17", "2017/18", 
                              "2018/19", "2019/20", "2020/21", 
                              "2021/22", "2022/23", "2023/24"))) %>% 
                              # , "2024/25")))
   arrange(hb_name, fyear, measure)

EF4_fyear <- EF4_data %>% 
  distinct(fyear) %>% pull(fyear)

EF4_hb_names <- EF4_data %>% 
  distinct(hb_name) %>% pull(hb_name)

EF4_trend_measures <- c('Mental Health Expenditure', 'CAMHS Expenditure')



## EF5 ----
EF5_data <- read.csv("data/EF5.csv") %>% 
  # Below line is not needed, but keeping in as it shows the variable names clearly
  select(hb_name, year_months, measure, value) %>% 
   # Using months in order function to factor relevel the year_months variable
   months_function(., year_months)   

# Isolating necessary values for selectors
EF5_quarter <- EF5_data %>% 
  distinct(year_months) %>% pull(year_months)

EF5_hb_names <- EF5_data %>% 
  distinct(hb_name) %>% pull(hb_name)

EF5_trend_measures <- EF5_data %>% 
  distinct(measure) %>%  pull(measure)


# Create data for EF5 (need one column for each bar trace)
EF5_measure_data <- EF5_data %>% 
  pivot_wider(names_from = measure,
              values_from = value) %>% 
  rename(DNA_appointments = "Number of 'Did Not Attend' appointments",
         total_appointments = "Total number of appointments")

    
# Isolate measure data for measurePlot line element overlay
EF5_percentage_measure <- EF5_data %>% 
  subset(measure == "Percentage 'Did Not Attend' appointments") %>% 
  select(!measure) %>% rename(percentage = value)



## S2 ---- 


S2_data <- read.csv("data/S2.csv") %>% 
   # Using months in order function to factor relevel the year_months variable
   months_function(., year_months)   

# For graph 3:
S2_pivoted_data <- read.csv("data/S2_Reformated.csv") %>% 
   mutate(number = as.double(number)) %>% 
  # Trying to stop legend ordering alphabetically, but this isn't working yet:
   mutate(total_or_followed_up = fct_relevel(total_or_followed_up, 
                                             "Total number of discharged inpatients", 
                                             "Number of patients followed up")) %>% 
   # Using months in order function to factor relevel the year_months variable
   months_function(., year_months)   



## S5 ---- 

S5_data <- read.csv("data/S5.csv") %>% 
   # Using months in order function to factor relevel the year_months variable
   months_function(., year_months)   

# Pulling HB names:
S5_hb_names <- S5_data %>% 
   distinct(nhs_health_board) %>% 
   pull(nhs_health_board)

