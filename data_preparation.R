### Data preparation script
# N.B. do not use any direct filepaths, ony relational ones


# Function for calendar months ---- 
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
                                    "Jul-Sep 2025", "Oct-Dec 2025",
                                    "Jan-Mar 2026" # "Apr-Jun 2026",
                                  #  "Jul-Sep 2026", "Oct-Dec 2026"))
      ))
}

months_function_EF <- function(dat, var) {
  dat %>%
    mutate({{var}} := fct_relevel({{var}},
                                  "Apr-Jun 2022",
                                  "Jul-Sep 2022", "Oct-Dec 2022",
                                  "Jan-Mar 2023", "Apr-Jun 2023",
                                  "Jul-Sep 2023", "Oct-Dec 2023",
                                  "Jan-Mar 2024", "Apr-Jun 2024",
                                  "Jul-Sep 2024", "Oct-Dec 2024",
                                  "Jan-Mar 2025", "Apr-Jun 2025",
                                  "Jul-Sep 2025", "Oct-Dec 2025",
                                  "Jan-Mar 2026" # "Apr-Jun 2026",
                                  #  "Jul-Sep 2026", "Oct-Dec 2026"))
    ))
}




# Function for rearranging HB names in dropdown menus---
# Puts 'NHS Scotland' at the bottom of dropdown lists but all others in A-Z
# order above
sort_hb_names <- function(board_names) {
  
  board_vector_name <<- paste0(deparse(substitute(board_names)))
  
  temp_board_table <<- data.frame(board = board_names, status = rep("a", length(board_names)))
  
  temp_board_table <<- temp_board_table %>% 
    mutate(status = if_else(board == "NHS Scotland", "national", "local")) %>% 
    arrange(status, board) %>% 
    select(board) %>% 
    pull()
  
  assign(board_vector_name, temp_board_table, envir = .GlobalEnv)
  
  rm(temp_board_table, envir = .GlobalEnv)
  rm(board_vector_name, envir = .GlobalEnv)
  
}


# [Indicators] ----

## S1 ----
S1_data <- read.csv("data/S1.csv") %>% 
    filter(year != "Total") %>% 
    mutate(area_type = "Health board",
           area_name = "NHS Scotland")

# Years need to be factored so they appear on graph even if there's no data 
# This will update automatically but the graph ranges may need to be added to
S1_distinct_years <- S1_data %>%
    distinct(year) %>%
    pull()

S1_data <- S1_data %>% 
    mutate(year = factor(year, levels = S1_distinct_years))

S1_unique_area_types <- S1_data %>% 
    distinct(area_type) %>%
    pull(area_type)

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


## E1 ----
E1_data <- read.csv("data/E1.csv") %>% 
  rename(dd_bed_days = delayed_discharge_bed_days,
         fyear = financial_year) %>%
  mutate(status = if_else(area_name %in% c("Scotland", "NHS Scotland"), "national", "local"))%>%
   # Have fyears as a factor in case there are any NAs in the data - the axis will
   # skip the year if there is no data
   mutate(fyear = factor(fyear, levels = 
                            c("2016/17", "2017/18", "2018/19", 
                              "2019/20", "2020/21", "2021/22", 
                              "2022/23", "2023/24", "2024/25", "2025/26"))) %>% 
   arrange(fyear, area_type, status, area_name) %>% 
  select(-status)

E1_area_types <- E1_data %>% 
  distinct(area_type) %>% pull(area_type)

# For E1 plot 2:
E1_fyear <- E1_data %>% 
   distinct(fyear) %>% 
   pull(fyear)


## EF1 ----
# Using excel as a base file
EF1_data <- readxl::read_xlsx("data/EF1_Excel.xlsx") %>% 
  # Select and rename necessary columns
  select(Board, 'Month of Discharge', 'Bed day rate') %>% 
  rename(hb_name = Board,
         bedday_rate = "Bed day rate") %>% 
  # Fill in missing health board names
  fill(hb_name, .direction = "down") %>%
  # Produce quarters
  #year and month column
  separate(`Month of Discharge`, into = c("year", "month"), sep = "-", remove = FALSE) |> 
  mutate(months = case_when(
    month %in% c("04", "05", "06") ~ "Apr-Jun",
    month %in% c("07", "08", "09") ~ "Jul-Sep",
    month %in% c("10", "11", "12") ~ "Oct-Dec",
    month %in% c("01", "02", "03") ~ "Jan-Mar")) |> 
  #unite year and month column for analysis
  unite(year_months, c (months, year), sep = " ", remove = FALSE) |> 
  mutate(hb_name = if_else(hb_name == "Scotland", 
                           "NHS Scotland", hb_name)) %>%
  # Using months in order function to factor relevel the year_months variable
  months_function_EF(., year_months) %>% 
  # Aggregate to produce quarterly rates
  group_by(hb_name, year_months) %>% 
  summarise(bedday_rate = sum(bedday_rate)) %>% 
  # Round bed day rate to two decimal places
  mutate(bedday_rate = round(bedday_rate, digits = 2)) %>%
  ungroup()

EF1_hb_names <- EF1_data %>% 
  distinct(hb_name) %>% pull(hb_name)

sort_hb_names(EF1_hb_names)


## EF2 ----
EF2_data <- readxl::read_xlsx("data/EF2.xlsx") |>  
  # Produce quarters
  #year and month column
  separate(`Month of Discharge (original CIS)`, into = c("year", "month"), sep = "-", remove = FALSE) |> 
  mutate(months = case_when(
    month %in% c("04", "05", "06") ~ "Apr-Jun",
    month %in% c("07", "08", "09") ~ "Jul-Sep",
    month %in% c("10", "11", "12") ~ "Oct-Dec",
    month %in% c("01", "02", "03") ~ "Jan-Mar")) |> 
  #unite year and month column for analysis
  unite(year_months, c (months, year), sep = " ", remove = FALSE) |> 
  mutate(Board = if_else(Board == "Scotland", 
                            "NHS Scotland", Board)) %>%
  # Using months in order function to factor relevel the year_months variable
  months_function_EF(., year_months) %>% 
  # quarters calculation
  group_by(Board, year_months) %>%
  mutate(total_readmissions_quarter = sum(`Number of Readmissions`), 
         total_admissions_quarter = sum(`Number Of Admissions`)) %>% 
  ungroup() %>% 
  mutate(x28_days_readmission_rate_percentage_quarter = round((total_readmissions_quarter / total_admissions_quarter) * 100, 1)) |> 
  #select columns needed
  select(Board, year_months, x28_days_readmission_rate_percentage_quarter) |> 
  #one observation per quarter
    group_by(Board) |>
    distinct(year_months, .keep_all = TRUE) |> 
    arrange(Board, year_months)  |> 
# change NAs to 0s as per advice from Craig Scott in Discovery 
  mutate(across(
    where(is.numeric),                # only numeric columns
    ~ replace(., is.na(.), 0)          # replace NA/NaN with 0
  ))
#mutate_all(~replace(., is.na(.), 0))

EF2_hb_names <- EF2_data %>%
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

sort_hb_names(EF4_hb_names)

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


## EQ1 ----
EQ1_data <- read.csv("data/EQ1.csv") |> 
  select("Year",
         "area_name",
         "area_type",
         "risk_ratio",
         "SMR04_Pop_Mortality_Rate",
         "General_Pop_Mortality_Rate")

EQ1_data <- EQ1_data %>% 
  mutate(area_type = if_else(area_type == "Health Board", 
                           "Health board", area_type)) %>% 
  mutate(area_type = if_else(area_type == "Council Area", 
                           "Council area", area_type))

EQ1_data <- EQ1_data %>%
  mutate(status = if_else(area_name %in% c("Scotland", "NHS Scotland"), "national", "local"))%>%
  arrange(Year, area_type, status, area_name) %>% 
  select(-status)
# Years need to be factored so they appear on graph even if there's no data 
# This will update automatically but the graph ranges may need to be added to
EQ1_distinct_years <- EQ1_data %>% distinct(Year) %>% pull

EQ1_data <- EQ1_data %>% 
  mutate(Year = factor(Year, levels = EQ1_distinct_years))


EQ1_unique_area_types <- EQ1_data %>% 
  distinct(area_type) %>% pull(area_type)

# For EQ1 plot 2:
EQ1_reformatted_data <- read.csv("data/EQ1_Reformatted.csv") %>% 
  mutate(area_type = if_else(area_type == "Health Board", 
                             "Health board", area_type)) %>% 
  mutate(area_type = if_else(area_type == "Council Area", 
                             "Council area", area_type)) %>% 
  arrange(Year) %>%
  mutate(Rate = round(Rate)) %>%   # because values are e.g. "3158.23942548425913"
  mutate(Year = factor(Year, levels = EQ1_distinct_years))


# Create data for EQ1 bar plot (need one column for each bar trace)
EQ1_plot2_data <- EQ1_reformatted_data %>% 
  pivot_wider(names_from = Rate_Type,
              values_from = Rate) %>% 
  rename(mh_rate = SMR04_Pop_Mortality_Rate,
         genpop_rate = General_Pop_Mortality_Rate)


## EQ4 ----
EQ4_data <- read_excel("data/EQ4.xlsx") %>%
  janitor::clean_names() %>%
  mutate(board = recode(board, 
                        "Scotland" = "NHS Scotland")) %>%
  transmute(
    board,
    financial_year = phsmethods::extract_fin_year(month_of_discharge),
    quarter_num = lubridate::quarter(month_of_discharge, fiscal_start = 4),
    non_camhs_admissions,
    camhs_admissions
  ) %>%
  group_by(board, financial_year, quarter_num) %>%
  summarise(
    total_non_camhs = sum(non_camhs_admissions),
    total_u18 = sum(non_camhs_admissions + camhs_admissions),
    perc = round(total_non_camhs/total_u18 * 100, digits = 1),
    #convert NaN to 0 (occurs when 0/0)
    perc = ifelse(is.nan(perc), 0, perc),
    .groups = "drop"
  ) %>%
  arrange(financial_year, quarter_num) %>%
  mutate(
    quarter_fy = paste0("Q", quarter_num, " ", financial_year),
    quarter_fy = factor(
      quarter_fy,
      levels = unique(quarter_fy),
      ordered = T
    )
  ) %>%
  select(board, quarter_fy, total_non_camhs, total_u18, perc)

EQ4_hb_names <- EQ4_data %>% 
  distinct(board) %>% pull(board)
