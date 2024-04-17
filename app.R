library(phsstyles)
library(dplyr)
library(purrr)
library(shiny)
library(shinydashboard)
library(fresh) # for customising shinydashboard look
library(shinyWidgets)


# Data import section ----------------------------------------------------

# Source constants used throughout app
source("constants.R")

# # 6. sourcing functions created for app (see functions folder) -------------------------------
# list.files("functions") %>% 
#   map(~ source(paste0("functions/", .)))

# Source the ui file ----

# ui <- source('ui.R', local = TRUE)$value

ui <- dashboardPage(
  
  dashboardHeader(title = "MH Quality Indicators"),
  
  dashboardSidebar(source("modules/sidebar_ui.R", local = TRUE)$value),
  
  # Define how the various pages of the dashboard look
  dashboardBody(
    ## Source styling for shinydashboard elements 
    # - must be before stylesheet so that it doesn't override the css file
    source("www/dashboard_style.R", local = TRUE)$value,
    
    ## Point shiny to the css stylesheet that defines how things look 
    tags$head(includeCSS("www/stylesheet.css")),
    
    
    tabItems(
      # [Introduction Tab] ----------------------------------------------------
      source("modules/introduction_ui.R", local = TRUE)$value,
      
      
      # [Scotland Hub Tab] ----------------------------------------------------
      source("modules/scot_hub_ui.R", local = TRUE)$value,
      
      ## Sourcing ui sections for each indicator -------------------------------
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
) # End of UI

# Server  ----------------------------------------------------
server <- function(input, output, session) {
  
  # Navigation buttons ----
  source("modules/nav_buttons_server.R", local = TRUE)
  
}

shinyApp(ui, server)
