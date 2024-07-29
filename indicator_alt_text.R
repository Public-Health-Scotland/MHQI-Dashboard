max_year <- 2024

EF1 <- read_csv('data/EF1.csv')

EF1_rate <- EF1$rate %>% 
  filter(fyear = max_year)
  
EF1_lag_rate <- EF1$rate %>% 
  filter(fyear = (max_year-1))