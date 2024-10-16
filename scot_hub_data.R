# NEW CODE (OLD BELOW) ----

# Load alt text csv ----

alt_text_csv <- read.csv("//PHI_conf/MentalHealth1/Quality Indicators/QI Publication/2024_November/Dashboard Data/Indicator text/WIP_alt_text_for_indicators.csv")


# T1 ----
# % of people who commence Psychological therapy-based treatment within 18 weeks of referral
T1_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "T1_ScotlandHub_dateText") %>% 
   pull(value) 

T1_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "T1_ScotlandHub_value") %>% 
   pull(value) 


# T2 ---- 
# % of young people who commence treatment by specialist Child and Adolescent Mental Health 
# services within 18 weeks of referral

T2_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "T2_ScotlandHub_dateText") %>% 
   pull(value)

T2_ScotlandHub_value  <- alt_text_csv %>% 
   filter(alt_text == "T2_ScotlandHub_value") %>% 
   pull(value)


# T3 ----
# % of people who wait less than three weeks from referral received to appropriate drug or 
# alcohol treatment that supports their recovery

T3_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "T3_ScotlandHub_dateText") %>% 
   pull(value)


T3_ScotlandHub_value  <- alt_text_csv %>% 
   filter(alt_text == "T3_ScotlandHub_value") %>% 
   pull(value)


# S1 ---- 
# Suicide rates per 100,000 population

S1_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "S1_ScotlandHub_dateText") %>% 
   pull(value)

S1_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "S1_ScotlandHub_value") %>% 
   pull(value)



# S2 - currently no data in folder ----
#  % of all discharged psychiatric inpatients followed-up by community mental health services 
# within 7 calendar days
S2_ScotlandHub_dateText <- "(Oct-Dec 2021)"
   
S2_ScotlandHub_value_low <- 17.6
   
S2_ScotlandHub_value_high <- 88.1


# S5 - currently no data in folder ----
# Incidents of physical violence per 1,000 occupied psychiatric bed days

S5_ScotlandHub_dateText <- "(Oct-Dec 2021)"
S5_ScotlandHub_value_low <- "Zero"
S2_ScotlandHub_value_high <- 40.3


# P1 - update manually ----
# % of carers with a mental health condition that felt supported to continue in their caring role

P1_ScotlandHub_dateText <- "(In financial year 2023/24)"

P1_ScotlandHub_value <- "27%"


# P2 - update manually ---- 
#  % of adults with mental health problems supported at home who agree that their services and 
# support had an impact in improving or maintaining their quality of life 

P2_ScotlandHub_dateText <- "(In financial year 2023/24)"

P2_ScotlandHub_value <- "55%"

# P3 - update manually ----
#  % of replies for people with a mental health problem that agree with the statement 
# "people took account of the things that mattered to me" 

P3_ScotlandHub_dateText <- "(In financial year 2023/24)"

P3_ScotlandHub_value <- "56%"


# P4 ---- 
# Number of people with advance statements registered per year with the 
# Mental Welfare Commission for Scotland

P4_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "P4_ScotlandHub_dateText") %>% 
   pull(value)

P4_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "P4_ScotlandHub_value") %>% 
   pull(value)


# E1 ----
# Number of days people spend in hospital when they are clinically ready to 
# be discharged per 1,000 population 

E1_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "E1_ScotlandHub_dateText") %>% 
   pull(value)

E1_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "E1_ScotlandHub_value") %>% 
   pull(value)


# EF1 ----
# Rate of emergency bed days for adults (per 100,000 population)

EF1_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "EF1_ScotlandHub_dateText") %>% 
   pull(value)

EF1_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "EF1_ScotlandHub_value") %>% 
   pull(value)


# EF2 ----
# % Readmissions to hospital within 28 days of discharge

EF2_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "EF2_ScotlandHub_dateText") %>% 
   pull(value)

EF2_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "EF2_ScotlandHub_value") %>% 
   pull(value)


# EF3 - working on, have half the data ---- 
# Total psychiatric inpatient beds per 100,000 population (NRAC adjusted)

EF3_ScotlandHub_dateText <- "(in EXAMPLE DATE)"


EF3_ScotlandHub_value <- 64.9


# EF4 ---- 
# Total mental health spend as a % of total spend

EF4_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "EF4_ScotlandHub_dateText") %>% 
   pull(value)


EF4_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "EF4_ScotlandHub_value") %>% 
   pull(value)


# EF5 - currently no data in folder ----
# % of did not attend appointments for community based services of people with mental 
# health problems

EF5_ScotlandHub_dateText <- "(EXAMPLE DATE)"

EF5_ScotlandHub_value_low <- 8.2
EF5_ScotlandHub_value_high <- 20.5


# EQ1 ----
# Premature mortality rate = Standardised mortality rate for persons in contact with 
# mental health services

EQ1_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "EQ1_ScotlandHub_dateText") %>% 
   pull(value)

EQ1_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "EQ1_ScotlandHub_value") %>% 
   pull(value) 


# EQ2 ----
# Number of emergency detention certificates (EDCs) per 100,000 population

EQ2_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "EQ2_ScotlandHub_dateText") %>% 
   pull(value)  

EQ2_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "EQ2_ScotlandHub_value") %>% 
   pull(value)  


# EQ3 - new indicator - need to find data ----
# % of people with Severe and Enduring Mental Illness and/or Learning Disability who have 
# had an annual health check within previous 12 months

EQ3_ScotlandHub_dateText <- "(EXAMPLE DATE)"

EQ3_ScotlandHub_value <- 6


# EQ4 ----
# % of under 18 year old psychiatric admissions admitted out with NHS specialist Child and 
# Adolescent Mental Health (CAMH) wards

EQ4_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "EQ4_ScotlandHub_dateText") %>% 
   pull(value) 

EQ4_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "EQ4_ScotlandHub_value") %>% 
   pull(value) 



# OLD CODE copied out ----

# Constants ----------------------------------------------------

# Data for Scot Hub (from previous publication):
# T1_dateText <- "(Oct-Dec 2021)"
# T1 <- 84.4

# T2_dateText <- "(Oct-Dec 2021)"
# T2 <- 70.3
# 
# T3_dateText <- "(Oct-Dec 2021)"
# T3 <- 93
# 
# 
# S1_dateText <- "(2016-2020)"
# S1 <- 13.7
# 
# S2_dateText <- "(Oct-Dec 2021)"
# S2_low <- 17.6
# S2_high <- 88.1
# 
# S5_dateText <- "(Oct-Dec 2021)"
# S5_low <- "Zero"
# S5_high <- 40.3
# 
# P1_dateText <- "(2019/20)"
# P1 <- 27
# 
# P2_dateText <- "(2019/20)"
# P2 <- 74
# 
# P3_dateText <- "(2019/20)"
# P3 <- 78
# 
# P4_dateText <- "2020/21"
# P4 <- 78
#   
# E1_orig <- 13829462 # [remember to add code to include 000 separarators]
# E1 <- format(E1_orig, big.mark = ",")
# 
# EF1 <- "18,844"
# EF2 <- 8.4
# EF3 <- 64.9
# 
# EF4 <- 8.8
# EF4_text <- "(2020/21)"
# 
# EF5_low <- 8.2
# EF5_high <- 20.5
# 
# EQ1 <- 2.62
# 
# EQ2 <- 60
# 
# EQ3 <- 6
#   
# EQ4 <- 51.3