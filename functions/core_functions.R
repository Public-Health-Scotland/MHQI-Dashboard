### This script contains functions and repeated chunks of code used throughout 
### the app in order to reduce the app size.


### [ Repeated Code Chunks ] ----

# Go to top button ----
go_2_top_bttn <- gotop::use_gotop(
  src = "fas fa-chevron-circle-up", # css class from Font Awesome
  color = phs_colors('phs-blue'), # color
  opacity = 0.8, # transparency
  width = 50, # size
  appear = 80 # number of pixels before appearance
)


### [ Functions ] ----

# Load data from shiny_app/data ----
load_csv_file <- function(csv){
  # Given a .csv file name in shiny_app/data
  # this function loads it as a variable with the same name as the
  # file apart from the extension
  assign(gsub(".csv", "", csv), read.csv(paste0("data/", csv)), envir = .GlobalEnv)
}
