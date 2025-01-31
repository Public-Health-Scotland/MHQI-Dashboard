### This script extracts the text and values needed for infographic's alt text
### and Scotland Hub values. 

### [Alt Text File] ----
# For Scotland Hub and for the Infographic alt text

# Load the csv containing all the values
alt_text_csv <- read.csv("data/Indicator text/alt_text_for_indicators.csv")

# T1 ----
# % of people who commence Psychological therapy-based treatment within 18 weeks of referral

T1_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "T1_infographic_text") %>% 
   pull(value)

# T2 ---- 
# % of young people who commence treatment by specialist Child and Adolescent Mental Health 
# services within 18 weeks of referral

T2_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "T2_infographic_text") %>% 
   pull(value)


# T3 ----
# % of people who wait less than three weeks from referral received to appropriate drug or 
# alcohol treatment that supports their recovery

T3_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "T3_infographic_text") %>% 
   pull(value)


# S1 ---- 
# Suicide rates per 100,000 population

S1_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "S1_infographic_text") %>% 
   pull(value)


# S2 ----
#  % of all discharged psychiatric inpatients followed-up by community mental health services 
# within 7 calendar days

S2_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "S2_infographic_text") %>% 
   pull(value)


# S5 ----
# Incidents of physical violence per 1,000 occupied psychiatric bed days

S5_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "S5_infographic_text") %>% 
   pull(value)



# P1 ----
# % of carers with a mental health condition that felt supported to continue in their caring role

P1_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "P1_infographic_text") %>% 
   pull(value)



# P2 ---- 
#  % of adults with mental health problems supported at home who agree that their services and 
# support had an impact in improving or maintaining their quality of life 

P2_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "P2_infographic_text") %>% 
   pull(value)



# P3 - only alt text ----
#  % of replies for people with a mental health problem that agree with the statement 
# "people took account of the things that mattered to me" 

P3_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "P3_infographic_text") %>% 
   pull(value)



# P4 ---- 
# Number of people with advance statements registered per year with the 
# Mental Welfare Commission for Scotland

P4_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "P4_infographic_text") %>% 
   pull(value)


# E1 ----
#  Number of days people spend in hospital when they are clinically ready to 
# be discharged per 1,000 population 

E1_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "E1_infographic_text") %>% 
   pull(value)


# EF1 ----
# Rate of emergency bed days for adults

EF1_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "EF1_infographic_text") %>% 
   pull(value)


# EF2 ----
# % Readmissions to hospital within 28 days of discharge

EF2_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "EF2_infographic_text") %>% 
   pull(value)


# EF3 ---- 
EF3_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "EF3_infographic_text") %>% 
   pull(value)


# EF4 ---- 
# Total mental health spend as a % of total spend

EF4_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "EF4_infographic_text") %>% 
   pull(value)


# EF5 ----
# % of did not attend appointments for community based services of people with mental health problems

EF5_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "EF5_infographic_text") %>% 
   pull(value)


# EQ1 ----
#  Premature mortality rate = Standardised mortality rate for persons in contact with mental health services

EQ1_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "EQ1_infographic_text") %>% 
   pull(value)


# EQ2 ----
#  Number of emergency detention certificates (EDCs) per 100,000 population

EQ2_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "EQ2_infographic_text") %>% 
   pull(value)


# EQ4 ----
# % of under 18 year old psychiatric admissions admitted out with NHS specialist Child and 
# Adolescent Mental Health (CAMH) wards

EQ4_infographic_alt_text <- alt_text_csv %>% 
   filter(alt_text == "EQ4_infographic_text") %>% 
   pull(value)
