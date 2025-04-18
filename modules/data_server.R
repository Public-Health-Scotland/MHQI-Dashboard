### Create download function that allows users to download tables in .csv format
### from "Data Downloads" page

# Indicators - in sidebar order ---- 

# S2
output$S2_data_download <- downloadHandler(
   filename = 'S2 - Community Follow-up.csv',
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


# S5
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

# E1
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
                              "Rate per 1000 Population"),
                sep = ",")
  }
)

# EF4
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

# EF5
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

# EQ1
output$EQ1_data_download <- downloadHandler(
  filename = 'EQ1 - Premature Mortality Data.csv',
  content = function(file) {
    write.table(EQ1_data,
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Calendar Year",
                              "SMR04 Population Rate",
                              "General Population Rate",
                              "Risk Ratio",
                              "Area Name",
                              "Area Type"),
                sep = ",")
  }
)