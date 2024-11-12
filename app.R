### Mental Health Quality Indicators Dashboard
## Main app.R file which sources modules for each tab along with any other
## compartmentalised sections of the app.

# Loading packages
library(phsstyles)
library(plotly)
library(ggplot2) # adding for testing using this before plotly
library(dplyr)
library(purrr) # for map function to load multiple files
library(stringr)
library(shiny)
library(shinydashboard)
library(fresh) # for customising shinydashboard look
library(shinyWidgets)
library(forcats) # added by mahri for fct_reorder() in graph 
library(gotop) # for return to top button
library(shinycssloaders) # for graph loading spinners
library(DT)
library(shinymanager) # password protection


# Data import section ----------------------------------------------------

# Source data
source("data_preparation.R")

# Source constants used throughout app
source("scot_hub_data.R")
source("setup.R")


# Source functions created for app (see functions folder) -------------------------------
list.files("functions") %>%
  map(~ source(paste0("functions/", .)))

#* Read in credentials for password-protecting the app ----
# credentials <- readRDS("admin/credentials.rds") # Un-comment if password protection needed


### [ UI section ] -------------------------------------------------------------

ui <- 
  # secure_app( # Un-comment if password protection is needed.
  dashboardPage(
  
  dashboardHeader(title = "MH Quality Indicators"),
  
  dashboardSidebar(source("modules/sidebar_ui.R", local = TRUE)$value),
  
  # Define how the various pages of the dashboard look
  dashboardBody(
    
    ## Source styling for shinydashboard elements 
    # - must be before stylesheet so that it doesn't override the css file
    source("www/dashboard_style.R", local = TRUE)$value,
    
    ## load css stylesheet that defines how things look 
    tags$head(includeCSS("www/stylesheet.css")),
    
    ## Tabs ----
    tabItems(
      # [Introduction Tab] ----
      source("modules/introduction_ui.R", local = TRUE)$value,
      
      # [Scotland Hub Tab] ----
      source("modules/scot_hub_ui.R", local = TRUE)$value,
      
      # [Data Downloads Tab] ----
      source("modules/data_ui.R", local = TRUE)$value,
      
      ## Sourcing ui sections for each indicator ----
      # [Timely] ----
      source("modules/indicators/T1_ui.R", local = TRUE)$value,
      source("modules/indicators/T2_ui.R", local = TRUE)$value,
      source("modules/indicators/T3_ui.R", local = TRUE)$value,
      
      # [Safe] ----
      source("modules/indicators/S1_ui.R", local = TRUE)$value,
      source("modules/indicators/S2_ui.R", local = TRUE)$value,
      source("modules/indicators/S5_ui.R", local = TRUE)$value,

      # [Person Centred] ----
      source("modules/indicators/P1_ui.R", local = TRUE)$value,
      source("modules/indicators/P2_ui.R", local = TRUE)$value,
      source("modules/indicators/P3_ui.R", local = TRUE)$value,
      source("modules/indicators/P4_ui.R", local = TRUE)$value,

      # [Effective] ----
      source("modules/indicators/E1_ui.R", local = TRUE)$value,

      # [Efficient] ----
      source("modules/indicators/EF1_ui.R", local = TRUE)$value,
      source("modules/indicators/EF2_ui.R", local = TRUE)$value,
      source("modules/indicators/EF3_ui.R", local = TRUE)$value,
      source("modules/indicators/EF4_ui.R", local = TRUE)$value,
      source("modules/indicators/EF5_ui.R", local = TRUE)$value,

      # [Equitable] ----
      source("modules/indicators/EQ1_ui.R", local = TRUE)$value,
      source("modules/indicators/EQ2_ui.R", local = TRUE)$value,
      source("modules/indicators/EQ4_ui.R", local = TRUE)$value,

      # [Appendix tab] ----
      source("modules/appendix_ui.R", local = TRUE)$value
    
   ) # End of tabItems
  ) # End of dashboardBody
) # End of dashboardPage
# ) # End of password-protection wrapper



### [ Server ] -----------------------------------------------------------------
server <- function(input, output, session) {
  
  ##* Shinymanager authorisation ----
  # Un-comment this section to password protect the app.
  # Re-comment out to remove password protection on launch day.
   # res_auth <- secure_server(
   # check_credentials = check_credentials(credentials)
   # )
   # 
   # output$auth_output <- renderPrint({
   # reactiveValuesToList(res_auth)
   # })
  
  # Navigation buttons ----
  source("modules/nav_buttons_server.R", local = TRUE)
  
  # Data downloads ----
  source("modules/data_server.R", local = TRUE)
  
  # Indicator servers
  source("modules/indicators/E1_server.R", local = TRUE)
  source("modules/indicators/EQ1_server.R", local = TRUE)
  source("modules/indicators/EF4_server.R", local = TRUE)
  
  
  # Keep dashboard active indefinitely to meet accessibility requirements
  # (Keep at the end of server)
  auto_invalidate <- reactiveTimer(10000)
  observe({
    auto_invalidate()
    cat(".")
  })
}

# Sets language right at the top of source (required this way for screen readers)
attr(ui, "lang") = "en"

shinyApp(ui, server)
