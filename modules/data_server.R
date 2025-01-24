### Create download function that allows users to download tables in .csv format.
# E1
output$E1_data_download <- downloadHandler(
  filename = 'E1 - Delayed Discharge Data.csv',
  content = function(file) {
    write.table(E1_data,
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Financial year",
                              "Area name",
                              "Area code",
                              "Area type",
                              "Delayed discharge bed days",
                              "Population estimate for 18+",
                              "Rate per 1000 population"),
                sep = ",")
  }
)

# EF4
output$EF4_data_download <- downloadHandler(
  filename = 'EF4 - Mental Health Spend Data.csv',
  content = function(file) {
    write.table(EF4_data,
                file,
                #Remove row numbers as the .csv file already has row numbers.
                row.names = FALSE,
                col.names = c("Financial year",
                              "Area name",
                              "Measure Name",
                              "Value"),
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
                col.names = c("Financial year",
                              "SMR04 population rate",
                              "General population rate",
                              "Risk ratio",
                              "Area name",
                              "Area type"),
                sep = ",")
  }
)