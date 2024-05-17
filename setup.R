### Loading required packages ----

### Load functions ----
source("functions/core_functions.R")
source("functions/plot_functions.R")

### Load in data ----

# Load in data to app_data
# Find all rds files in shiny_app/data
csv_files <- list.files(path="data/", pattern="*.csv")
for (csv in csv_files){
  load_csv_file(csv)
}


### Repeated plotting code ----

# Buttons to remove from plotly plots
bttn_remove <-  list(
  'select2d',
  'lasso2d',
  'zoomIn2d',
  'zoomOut2d',
  'autoScale2d',
  'toggleSpikelines',
  'hoverCompareCartesian',
  'hoverClosestCartesian'
)

# Go to top button
gotop::use_gotop(
  src = "fas fa-chevron-circle-up", # css class from Font Awesome
  color = navy, # color
  opacity = 0.8, # transparency
  width = 50, # size
  appear = 80 # number of pixels before appearance
)