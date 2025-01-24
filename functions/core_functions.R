# Load data from shiny_app/data ----
load_csv_file <- function(csv){
  # Given a .csv file name in shiny_app/data
  # this function loads it as a variable with the same name as the
  # file apart from the extension
  assign(gsub(".csv", "", csv), read.csv(paste0("data/", csv)), envir = .GlobalEnv)
}
