### Mental Health Quality Indicators Dashboard

## Main app.R file which sources modules for each tab along with any other
## compartmentalised sections of the app.

## Memory required to run the app: ~ 1 GB (update this value as required)

# Loading packages
library(phsstyles)
library(plotly)
library(ggplot2) # adding for testing using this before plotly
library(dplyr)
library(purrr) # for map function to load multiple files
library(stringr)
library(tidyr) # for pivot functions
library(shiny)
library(readr)
library(shinydashboard)
library(fresh) # for customising shinydashboard look
library(shinyWidgets)
library(forcats) # added by mahri for fct_reorder() in graph 
library(gotop) # for return to top button
library(shinycssloaders) # for graph loading spinners
library(DT)
library(shinymanager) # password protection
library(readxl)
library(lubridate)
library(scales) # for comma ef1

# Data import section ----------------------------------------------------

# Source data
source("data_preparation.R")

# Source functions created for app (see functions folder) -------------------------------
list.files("functions") %>%
  map(~ source(paste0("functions/", .)))

#* Read in credentials for password-protecting the app ----
# credentials <- readRDS("admin/release_credentials.rds") # Un-comment if password protection needed

# # Get packages
# source("setup.R")
# 
# # Getting UI for modules
# source(file.path("modules/summary_button/summary_button_ui.R"), local = TRUE)$value
source(file.path("modules/alt_text/alt_text_modals_ui.R"), local = TRUE)$value
# source(file.path("modules/definitions/definitions_ui.R"), local = TRUE)$value

# UI ----
ui <- fluidPage(
  tagList(
    # For go to top chevrons on scroll down
    use_gotop(),
    # Specify most recent fontawesome library - change version as needed
    navbarPage(
      id = "intabset", # id used for jumping between tabs
      position = "fixed-top",
      collapsible = "true",
      # Specify language for accessibility
      #lang = "en",
      #tags$html(lang="en"),
      title = div(
        tags$a(img(src = "white-logo.png", height = 40,
                   alt ="Go to Public Health Scotland (external site)"),
               href = "https://www.publichealthscotland.scot/",
               target = "_blank"), # PHS logo links to PHS website
        style = "position: relative; top: -10px;"),
      windowTitle = "Mental Health Quality Indicators - Public Health Scotland",# Title for browser tab
      header = source(file.path("header.R"), local=TRUE)$value,
      
      ##############################################.
      # Home Page ----
      ##############################################.
      tabPanel(title = "Home",
               icon = icon_no_warning_fn("circle-info"),
               value = "home",
               navlistPanel(widths = c(2,10), id = "safe_panel", #icon = icon_no_warning_fn("spa")
                            
                            tabPanel(title = "Intoduction",
                                     value = "introduction",
                                     column(12, source("modules/introduction_ui.R", local = TRUE)$value)),
                            
                            tabPanel(title = "Glossary",
                                     value = "glossary",
                                     column(12, source("modules/glossary_ui.R", local = TRUE)$value)),
                            
                            tabPanel(title = "Data Downloads",
                                     value = "data_downloads",
                                     column(12, source("modules/data_ui.R", local = TRUE)$value)),
                            
                            tabPanel(title = "Appendix",
                                     value = "appendix",
                                     column(12, source("modules/appendix_ui.R"), local = TRUE)$value))

      ), # tabpanel
      
      ##############################################.
      # Scot Hub ----
      ##############################################.
      tabPanel(title = "Scotland Hub",
               icon = icon_no_warning_fn("square-poll-vertical"),
               value = "scot_hub",

               source("modules/scot_hub_ui.R", local = TRUE)$value

      ), # tabpanel
      
      
      ##############################################.
      ## Safe ----
      ##############################################.
      tabPanel(title ="Safe",
               # Look at https://fontawesome.com/search?m=free for icons
               icon = icon_no_warning_fn("clipboard-check"),
               value = "safe",
               navlistPanel(widths = c(2,10), id = "safe_panel", #icon = icon_no_warning_fn("spa")
                            
                            tabPanel(title = "S1 - Suicide Rates",
                                     value = "S1_suicide_rates",
                                     column(12, source(file.path("indicators/S1_suicide_rates/S1_ui.R"), local = TRUE)$value)),
                            
                            tabPanel(title = "S5 - Physical Violence in Psychiatric Beds",
                                     value = "S5_psych_physical_violence",
                                     column(12, source(file.path("indicators/S5_psych_physical_violence/S5_ui.R"), local = TRUE)$value)),
                            
                            # tabPanel(title = "EQ1 - Premature Mortality",
                            #          value = "EQ1_premature_mortality",
                            #          column(12, source(file.path("indicators/EQ1_premature_mortality/EQ1_ui.R"), local = TRUE)$value)),
                            
                            tabPanel(title = "EQ4 - U18s Admitted Outwith CAMH Facilities",
                                     value = "EQ4_u18_outwith_camh",
                                     column(12, source(file.path("indicators/EQ4_u18_outwith_camh/EQ4_ui.R"), local = TRUE)$value))
               ) # navbarlistPanel
      ), # tabPanel
      
      
      ##############################################.
      ## Effective ----
      ##############################################.
      tabPanel(title ="Effective",
               # Look at https://fontawesome.com/search?m=free for icons
               icon = icon_no_warning_fn("clipboard-check"),
               value = "effective",
               navlistPanel(widths = c(2,10), id = "effective_panel", #icon = icon_no_warning_fn("spa")
                            
                            tabPanel(title = "EF1 - Emergency Bed Days",
                                     value = "EF1_emergency_bed_days",
                                     column(12, source(file.path("indicators/EF1_emergency_bed_days/EF1_ui.R"), local = TRUE)$value)),
                            
                            tabPanel(title = "EF2 - Readmissions",
                                     value = "EF2_readmissions",
                                     column(12, source(file.path("indicators/EF2_readmissions/EF2_ui.R"), local = TRUE)$value))
               ) # navbarlistPanel
      ), # tabPanel
      
      
      ##############################################.
      ## Timely ----
      ##############################################.
      tabPanel(title ="Timely",
               # Look at https://fontawesome.com/search?m=free for icons
               icon = icon_no_warning_fn("clipboard-check"),
               value = "timely",
               navlistPanel(widths = c(2,10), id = "timely_panel", #icon = icon_no_warning_fn("spa")
                            
                            tabPanel(title = "T1 - Adult Psychiatric Referral",
                                     value = "T1_adult_psych_referral",
                                     column(12, source(file.path("indicators/T1_adult_psych_referral/T1_ui.R"), local = TRUE)$value)),
               
                            tabPanel(title = "T2 - U18 Psychaitric Referral",
                                     value = "T2_u18_psych_referral",
                                     column(12, source(file.path("indicators/T2_u18_psych_referral/T2_ui.R"), local = TRUE)$value)),
                            
                            tabPanel(title = "T3 - Drugs & Alcohol Referral",
                                     value = "T3_drugs_alcohol_referral",
                                     column(12, source(file.path("indicators/T3_drugs_alcohol_referral/T3_ui.R"), local = TRUE)$value))
               ) # navbarlistPanel
      ), # tabPanel
      
      
      ##############################################.
      ## Efficient ----
      ##############################################.
      tabPanel(title ="Efficient",
               # Look at https://fontawesome.com/search?m=free for icons
               icon = icon_no_warning_fn("clipboard-check"),
               value = "efficient",
               navlistPanel(widths = c(2,10), id = "efficient_panel", #icon = icon_no_warning_fn("spa")
                            
                            tabPanel(title = "E1 - Delayed Discharge Days",
                                     value = "E1_delayed_discharge",
                                     column(12, source(file.path("indicators/E1_delayed_discharge/E1_ui.R"), local = TRUE)$value)),
                            
                            # tabPanel(title = "EF3 - Psychiatric Bed Days",
                            #          value = "EF3_psychiatric_beds",
                            #          column(12, source(file.path("indicators/EF3_psychiatric_beds/EF3_ui.R"), local = TRUE)$value)),
                            
                            tabPanel(title = "EF4 - Mental Health Spend",
                                     value = "EF4_mental_health_spend",
                                     column(12, source(file.path("indicators/EF4_mental_health_spend/EF4_ui.R"), local = TRUE)$value)),
                            
                            tabPanel(title = "EF5 - Community DNAs",
                                     value = "EF5_community_dna",
                                     column(12, source(file.path("indicators/EF5_community_dna/EF5_ui.R"), local = TRUE)$value)),
                            
                            tabPanel(title = "EQ2 - Emergency Detention",
                                     value = "EQ2_emergency_detention",
                                     column(12, source(file.path("indicators/EQ2_emergency_detention/EQ2_ui.R"), local = TRUE)$value))
               ) # navbarlistPanel
      ), # tabPanel
      
      
      ##############################################.
      ## Integrated ----
      ##############################################.
      tabPanel(title ="Integrated",
               # Look at https://fontawesome.com/search?m=free for icons
               icon = icon_no_warning_fn("clipboard-check"),
               value = "integrated",
               navlistPanel(widths = c(2,10), id = "integrated_panel", #icon = icon_no_warning_fn("spa")
                            
                            tabPanel(title = "S2 - Psychiatric Discharge Follow Up %",
                                     value = "S2_psych_community_followup",
                                     column(12, source(file.path("indicators/S2_psych_community_followup/S2_ui.R"), local = TRUE)$value))
               ) # navbarlistPanel
      ), # tabPanel
      
      
      ##############################################.
      ## Person Centred ----
      ##############################################.
      tabPanel(title ="Person Centred",
               # Look at https://fontawesome.com/search?m=free for icons
               icon = icon_no_warning_fn("clipboard-check"),
               value = "person_centred",
               navlistPanel(widths = c(2,10), id = "person_centred_panel", #icon = icon_no_warning_fn("spa")
                            
                            tabPanel(title = "E1 - Delayed Discharge Days",
                                     value = "E1_delayed_discharge",
                                     column(12, source(file.path("indicators/E1_delayed_discharge/E1_ui.R"), local = TRUE)$value)),

                            tabPanel(title = "EF4 - Mental Health Spend",
                                     value = "EF4_mental_health_spend",
                                     column(12, source(file.path("indicators/EF4_mental_health_spend/EF4_ui.R"), local = TRUE)$value)),
                            
                            tabPanel(title = "EF5 - Community 'Did Not Attend'",
                                     value = "EF5_community_dna",
                                     column(12, source(file.path("indicators/EF5_community_dna/EF5_ui.R"), local = TRUE)$value)),
                            
                            tabPanel(title = "EQ2 - Emergency Detention",
                                     value = "EQ2_emergency_detention",
                                     column(12, source(file.path("indicators/EQ2_emergency_detention/EQ2_ui.R"), local = TRUE)$value))
               ) # navbarlistPanel
      ), # tabPanel


      ##############################################.
      # METADATA ----
      ##############################################.
      tabPanel(title = "Metadata",
               # Look at https://fontawesome.com/search?m=free for icons
               icon = icon_no_warning_fn("file-pen"),
               value = "metadata",

               source(file.path("indicators/metadata/metadata_ui.R"), local = TRUE)$value

      ), # tabpanel
      ##############################################.
      # DATA DOWNLOAD ----
      ##############################################.
      tabPanel(title = "Open data",
               # Look at https://fontawesome.com/search?m=free for icons
               icon = icon_no_warning_fn("floppy-disk"),
               value = "download",

               source(file.path("indicators/download/download_ui.R"), local = TRUE)$value

      ), # tabpanel
    ) # navbar
  ) # taglist
) # ui fluidpage

# ----------------------------------------------
# Server

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
  
  # if(password_protect){
  #   test <-  FALSE # set this to TRUE to deploy test version of the app
  #   source(file.path("password_protect/password_protect_server.R"), local = TRUE)$value
  # }

  # Get modules
  source("modules/alt_text/alt_text_modals_server.R", local = TRUE)$value
  source(file.path("modules/summary_button/summary_button_server.R"), local = TRUE)$value


  # Get functions
  source(file.path("functions/core_functions.R"), local = TRUE)$value
  source(file.path("functions/plot_functions.R"), local = TRUE)$valuee
  # source(file.path("indicators/cases/cases_functions.R"), local = TRUE)$value
  # source(file.path("indicators/hospital_admissions/hospital_admissions_functions.R"), local = TRUE)$value
  # source(file.path("indicators/respiratory/respiratory_functions.R"), local = TRUE)$value
  # source(file.path("indicators/respiratory_mem/respiratory_mem_functions.R"), local = TRUE)$value
  # source(file.path("indicators/mortality/euromomo/euromomo_functions.R"), local = TRUE)$value
  # source(file.path("indicators/wastewater/wastewater_functions.R"), local = TRUE)$value

  # Get content for individual pages
  source(file.path("indicators/introduction/introduction_server.R"), local = TRUE)$value
  source(file.path("indicators/at_a_glance/at_a_glance_server.R"), local = TRUE)$value
  
  
  
  source(file.path("indicators/download/download_server.R"), local = TRUE)$value
  

  auto_invalidate <- reactiveTimer(10000)
  observe({
    auto_invalidate()
    cat(".")
  })


}
#sets language right at the top of source (required this way for screen readers)
attr(ui, "lang") = "en"

#conditionally password protect app
if (password_protect){ ui <- secure_app(ui) }


# Run the application
shinyApp(ui=ui, server=server)

### END OF SCRIPT ###
