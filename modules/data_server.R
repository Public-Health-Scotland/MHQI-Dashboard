### Create download function that allows users to download tables in .csv format
### from "Data Downloads" page

# Indicators - in sidebar order ---- 

## S1 ----
output$S1_data_download <- downloadHandler(
    filename = 'S1 - Suicide Rate per 100,000 Population Trends.csv',
    content = function(file) {
        write.table(
            S1_data %>% 
                select(year, area_type, area_name, suicide_rate),
            file,
            #Remove row numbers as the .csv file already has row numbers.
            row.names = FALSE,
            col.names = c("Calendar Year",
                          "Area Type",
                          "Area Name",
                          "Crude Suicide Rate (per 100,000)"),
            sep = ",")
    }
)


## S2 ----
output$S2_data_download <- downloadHandler(
   filename = 'S2 - Community Follow-Up.csv',
   content = function(file) {
      write.table(S2_data,
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("NHS Health Board",
                                "Year and Quarter",
                                "Year and Months",
                                "Calendar Year",
                                "Number of Patients Followed Up",
                                "Total Number of Discharged Patients",
                                "Percentage Followed Up"),
                  sep = ",")
   }
)


## S5 ----
output$S5_data_download <- downloadHandler(
   filename = 'S5 - Physical Violence.csv',
   content = function(file) {
      write.table(S5_data,
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("NHS Health Board",
                                "Year and Quarter",
                                "Year and Months",
                                "Calendar Year",
                                "Number of Incidents",
                                "Total Occupied Psychiatric Bed Days", 
                                "Incidents per 1000 Bed Days"),
                  sep = ",")
   }
)

## E1 ----
output$E1_data_download <- downloadHandler(
  filename = 'E1 - Delayed Discharge Data.csv',
  content = function(file) {
    write.table(E1_data,
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Financial Year",
                              "Area Name",
                              "Area Code",
                              "Area Type",
                              "Delayed Discharge Bed Days",
                              "Population Estimate for 18+",
                              "Rate per 1,000 Population"),
                sep = ",")
  }
)

## EF1 ----
output$EF1_data_download <- downloadHandler(
  filename = 'EF1 - Emergency Bed Days.csv',
  content = function(file) {
    write.table(EF1_data,
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Health Board",
                              "Calendar Quarter",
                              "Incidents per 1,000 Bed Days"),
                sep = ",")
  }
)

## EF2 ----
output$EF2_data_download <- downloadHandler(
  filename = 'EF2 - Percentage of Readmissions.csv',
  content = function(file) {
    write.table(EF2_data,
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Health Board",
                              "Calendar Quarter",
                              "Percentage of Readmissions within 28 Days"),
                sep = ",")
  }
)

## EF4 ----
output$EF4_data_download <- downloadHandler(
  filename = 'EF4 - Mental Health Spend Data.csv',
  content = function(file) {
    write.table(EF4_data%>% 
                   # Add in the % sign as previously taken out for graph 
                   mutate(measure = if_else(measure == "Mental Health Expenditure", 
                                            "Mental Health Expenditure (%)", measure)) %>% 
                   mutate(measure = if_else(measure == "CAMHS Expenditure", 
                                            "CAMHS Expenditure (%)", measure)),
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Financial Year",
                              "Area Name",
                              "Measure Name",
                              "Value"),
                sep = ",")
  }
)

## EF5 ----
output$EF5_data_download <- downloadHandler(
   filename = 'EF5 - Community DNA.csv',
   content = function(file) {
      write.table(EF5_measure_data,
                  file,
                  #Remove row numbers as the .csv file already has row numbers.
                  row.names = FALSE,
                  col.names = c("NHS Health Board",
                                "Calendar Quarter",
                                "Total 'Did Not Attend' Appointments",
                                "Total Appointments", 
                                "Percentage 'Did Not Attend' Appointments"),
                  sep = ",")
   }
)

## EQ1 ----
output$EQ1_data_download <- downloadHandler(
  filename = 'EQ1 - Premature Mortality Data.csv',
  content = function(file) {
    write.table(EQ1_data,
 file,
 #Remove row numbers as the .csv file already has row numbers.
 row.names = FALSE,
 col.names = c("Year" = "Calendar Year",
               "area_name" = "Area Name",
               "area_type" = "Area Type",
               "risk_ratio" = "Risk Ratio",
               "SMR04_Pop_Mortality_Rate" = "SMR04 Population Rate (per 100,000)",
               "General_Pop_Mortality_Rate" = "General Population Rate (per 100,000)"),
 sep = ",")
 }
)

## EQ4 ----
output$EQ4_data_download <- downloadHandler(
  filename = 'EQ4 - Admissions outwith CAMH Wards.csv',
  content = function(file) {
    write.table(EQ4_data,
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Health Board",
                              "Calendar Quarter",
                              "Percentage of Admissions outwith CAMH Wards"),
                sep = ",")
  }
)