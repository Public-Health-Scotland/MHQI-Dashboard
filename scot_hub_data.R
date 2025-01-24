# Text and values for using as in the Scotland Hub. 
# Data file read into data_preparation.R

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



# S2 ----
# % of all discharged psychiatric inpatients followed-up by community mental health services 
# within 7 calendar days

S2_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "S2_ScotlandHub_dateText") %>% 
   pull(value)
   
S2_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "S2_ScotlandHub_value") %>% 
   pull(value)
   

# S5 ----
# Incidents of physical violence per 1,000 occupied psychiatric bed days

S5_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "S5_ScotlandHub_dateText") %>% 
   pull(value)

S5_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "S5_ScotlandHub_value") %>% 
   pull(value)


# P1 ----
# % of carers with a mental health condition that felt supported to continue in their caring role

P1_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "P1_ScotlandHub_dateText") %>% 
   pull(value)

P1_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "P1_ScotlandHub_value") %>% 
   pull(value)


# P2 ---- 
#  % of adults with mental health problems supported at home who agree that their services and 
# support had an impact in improving or maintaining their quality of life 

P2_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "P2_ScotlandHub_dateText") %>% 
   pull(value)

P2_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "P2_ScotlandHub_value") %>% 
   pull(value)

# P3 ----
#  % of replies for people with a mental health problem that agree with the statement 
# "people took account of the things that mattered to me" 

P3_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "P3_ScotlandHub_dateText") %>% 
   pull(value)

P3_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "P3_ScotlandHub_value") %>% 
   pull(value)


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


# EF3 ---- 
# Total psychiatric inpatient beds per 100,000 population (NRAC adjusted)

EF3_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "EF3_ScotlandHub_dateText") %>% 
   pull(value)

EF3_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "EF3_ScotlandHub_value") %>% 
   pull(value)


# EF4 ---- 
# Total mental health spend as a % of total spend

EF4_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "EF4_ScotlandHub_dateText") %>% 
   pull(value)


EF4_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "EF4_ScotlandHub_value") %>% 
   pull(value)


# EF5 ----
# % of did not attend appointments for community based services of people with mental 
# health problems

EF5_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "EF5_ScotlandHub_dateText") %>% 
   pull(value)


EF5_ScotlandHub_value_low <- alt_text_csv %>% 
   filter(alt_text == "EF5_ScotlandHub_value_low") %>% 
   pull(value)

EF5_ScotlandHub_value_high <- alt_text_csv %>% 
   filter(alt_text == "EF5_ScotlandHub_value_high") %>% 
   pull(value)


# EQ1 - to work out value ----
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


# EQ3 - new indicator - not publishing this year ----
# % of people with Severe and Enduring Mental Illness and/or Learning Disability who have 
# had an annual health check within previous 12 months

#EQ3_ScotlandHub_dateText <- "(...)"

#EQ3_ScotlandHub_value <- "..."


# EQ4 ----
# % of under 18 year old psychiatric admissions admitted out with NHS specialist Child and 
# Adolescent Mental Health (CAMH) wards

EQ4_ScotlandHub_dateText <- alt_text_csv %>% 
   filter(alt_text == "EQ4_ScotlandHub_dateText") %>% 
   pull(value) 

EQ4_ScotlandHub_value <- alt_text_csv %>% 
   filter(alt_text == "EQ4_ScotlandHub_value") %>% 
   pull(value) 


