library(phsstyles)
library(shiny)
library(shinydashboard)
library(shinyWidgets)

# Data import section ----------------------------------------------------

# Source constants used throughout app
source("constants.R")


# Source the ui file ----

# ui <- source('ui.R', local = TRUE)$value

ui <- dashboardPage(

  
  dashboardHeader(title = "MH Quality Indicators"),
  
  # # Point shiny to the css stylesheet that defines how things look 
  # tags$head(includeCSS("www/stylesheet.css")),
  # 
  # Define how the sidebar looks
  dashboardSidebar(
    # Define how the tab names appear in the sidebar
    # Use icons to show what type of information is available - chart for data, 
    # link for external source, pic for image from old pub
    sidebarMenu(id = "tabs",
                menuItem("Introduction", tabName = intro, icon = icon("home"), selected = TRUE),
                menuItem("Scotland Hub", tabName = scot_hub, icon = icon("globe")),
                
                menuItem("Timely 1", tabName = T1_tab, icon = icon("link")),
                menuItem("Timely 2", tabName = T2_tab, icon = icon("up-right-from-square")),
                menuItem("Timely 3", tabName = T3_tab, icon = icon("up-right-from-square")),
                
                menuItem("Safe"),
                menuItem("S 1", tabName = S1_tab, icon = icon("image")),
                menuItem("S 2", tabName = S2_tab, icon = icon("image")),
                menuItem("S 5", tabName = S5_tab, icon = icon("image")),
                br(),
                menuItem("Person Centred"),
                menuItem("P 1", tabName = P1_tab, icon = icon("image")),
                menuItem("P 2", tabName = P2_tab, icon = icon("image")),
                menuItem("P 3", tabName = P3_tab, icon = icon("image")),
                menuItem("P 4", tabName = P4_tab, icon = icon("image")),
                br(),
                menuItem("Effective"),
                menuItem("E 1", tabName = E1_tab, icon = icon("bar-chart")),
                br(),
                menuItem("Efficient"),
                menuItem("EF 1", tabName = EF1_tab, icon = icon("image")),
                menuItem("EF 2", tabName = EF2_tab, icon = icon("image")),
                menuItem("EF 3", tabName = EF3_tab, icon = icon("image")),
                menuItem("EF 4", tabName = EF4_tab, icon = icon("bar-chart")),
                menuItem("EF 5", tabName = EF5_tab, icon = icon("image")),
                br(),
                menuItem("Equitable"),
                menuItem("EQ 1", tabName = EQ1_tab, icon = icon("bar-chart")),
                menuItem("EQ 2", tabName = EQ2_tab, icon = icon("image")),
                menuItem("EQ 4", tabName = EQ4_tab, icon = icon("image"))
                
    )
  ),
  # Define how the various pages of the dashboard look
  dashboardBody(
    # Point shiny to the css stylesheet that defines how things look 
    tags$head(includeCSS("www/stylesheet.css")),
    
    tabItems(
      # Introduction Tab ----------------------------------------------------
      tabItem(tabName = intro,
              h1("Mental Health Quality Indicators Joint Collection Materials")
              ), # End of Intro Tab
      
      tabItem(tabName = scot_hub,
              
              # 'Timely' Indicators ----
              h1("Timely"),
              fluidRow(
                box(
                  # Header Text
                  title = tagList(icon("hourglass-end"),
                                  "T1 - % of people who commence psychological 
                                  therapy based treatment within 18 weeks of referral:"),
                  width = 4, solidHeader = TRUE,
                  # Body text
                  paste0(E1,"%"),
                  # Navigation button
                  actionButton(inputId = "T1_button", 
                               label = "T1 - Find out more", 
                               class = "navpageButton pull-right")
                    ),
                box(
                  # Header Text
                  title = tagList(icon("% of young people who commence treatment 
                                       by specialist Child and Adolescent Mental 
                                       Health services within 18 weeks of referral:"),
                  width = 4, solidHeader = TRUE,
                  # Body text
                  paste0(E1,"%"),
                  # Navigation button
                  actionButton(inputId = "T2_button", 
                               label = "T2 - Find out more", 
                               class = "navpageButton pull-right")
                ),
                box(
                  # Header Text
                  title = tagList(icon("hourglass-end"),
                                  "T1 - % of people who commence psychological 
                                  therapy based treatment within 18 weeks of referral:"),
                  width = 4, solidHeader = TRUE,
                  # Body text
                  paste0(E1,"%"),
                  # Navigation button
                  actionButton(inputId = "T1_button", 
                               label = "T1 - Find out more", 
                               class = "navpageButton pull-right")
                )
              ),
              br(),
              
              # 'Effective' Indicators ----
              h1("Effective"),
              fluidRow(
                box(# Link in title instead of button
                  title = actionLink("E1_button",
                                     "E2 - Days in hospital when clinically 
                                     ready to discharge, per 1,000 population:",
                                     icon = icon("refresh")),
                  width = 4, solidHeader = TRUE,
                    paste0(E1)
                    )
              ),
              br(),
              h1("Efficient"),
              
              
                box(width = 4, solidHeader = TRUE,
                    title = tagList(icon("hourglass-end"),
                                    "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:"),
                    paste0(E1),
                    footer = 
                    actionButton(inputId = "button3",
                                 label = "E1 - Find out more", 
                                 class = "navpageButton pull-right")
                    ),
                box(width = 4, solidHeader = TRUE,
                    title = tagList(icon("hourglass-end"),
                                    "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:"),
                    paste0(E1),
                    actionButton(inputId = "button4",
                                 label = "E1 - Find out more", 
                                 class = "navpageButton pull-right")
                    ),
                box(width = 4, solidHeader = TRUE,
                    title = tagList(icon("hourglass-end"),
                                    "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:"),
                    paste0(E1),
                    actionButton(inputId = "button5",
                                 label = "E1 - Find out more", 
                                 class = "navpageButton pull-right")
                    ),
                box(width = 4, solidHeader = TRUE,
                    title = tagList(icon("hourglass-end"),
                                    "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:"),
                    paste0(E1),
                    actionButton(inputId = "button6",
                                 label = "E1 - Find out more", 
                                 class = "navpageButton pull-right")
                    )
                  
                )

              ),
      
      # T1 ----------------------------------------------------
      tabItem(tabName = T1_tab,
              fluidPage(
                titlePanel("T1 - % of people who commence psychological therapy 
                           based treatment within 18 weeks of referral",
                           h5("Last Updated: Septemberr 2023")),
                mainPanel(
                  h3("Text description of T1"),
                  fluidRow(
                    column(6, actionButton("T1_prevPage", "Home Page", icon = icon("arrow-left"))),
                    column(6, actionButton("T1_nextPage", "Next Page", icon = icon("arrow-right")))
                  )
                )
              )
      ),
      # T2 ----------------------------------------------------
      tabItem(tabName = T2_tab,
              fluidPage(
                titlePanel("Page 2"),
                mainPanel(
                  h3("Text description of T2"),
                  fluidRow(
                    column(6, actionButton("T2_prevPage", "Previous Page", icon = icon("arrow-left"))),
                    column(6, actionButton("T2_nextPage", "Next Page", icon = icon("arrow-right")))
                  )
                )
              )
      ),
      # T3 ----------------------------------------------------
      tabItem(tabName = T3_tab,
              fluidPage(
                titlePanel("Page 3"),
                mainPanel(
                  h3("ext description of T1"),
                  fluidRow(
                    column(6, actionButton("T1prevPage", "Previous Page", icon = icon("arrow-left"))),
                    column(6, actionButton("nextPageT3", "Next Page", icon = icon("arrow-right")))
                  )
                )
              )
      ),
      # Page 4 ----------------------------------------------------
      tabItem(tabName = page4,
              fluidPage(
                titlePanel("Page 4"),
                mainPanel(
                  h3("You are on Page 4"),
                  fluidRow(
                    column(6, actionButton("T1prevPage", "Previous Page", icon = icon("arrow-left"))),
                    column(6, actionButton("T3_nextPage", "Next Page", icon = icon("arrow-right")))
                  )
                )
              )
      ),
      # Page 5 ----------------------------------------------------
      tabItem(tabName = page5,
              fluidPage(
                titlePanel("Page 5"),
                mainPanel(
                  h3("You are on Page 5"),
                  fluidRow(
                    column(6, actionButton("T1prevPage", "Previous Page", icon = icon("arrow-left"))),
                    column(6, actionButton("nextPage5", "Next Page", icon = icon("arrow-right")))
                  )
                )
              )
      ),
      # Page 6 ----------------------------------------------------
      tabItem(tabName = page6,
              fluidPage(
                titlePanel("Page 6"),
                mainPanel(
                  h3("You are on Page 6"),
                  fluidRow(
                    column(6, actionButton("T1prevPage", "Previous Page", icon = icon("arrow-left"))),
                    column(6, actionButton("nextPage6", "Home Page", icon = icon("arrow-right")))
                  )
                )
              )
      )
    )
  )
)
# Server  ----------------------------------------------------
server <- function(input, output, session) {
  
  # [Navigation page buttons] ----------------------------------------------------
  # Uses 'pageX' objects which are updated in 'constants.R' file
  observeEvent(input$T1_button, {
    updateTabItems(session, "tabs", T1_tab)
  })
  observeEvent(input$T2_button, {
    updateTabItems(session, "tabs", T2_tab)
  })
  observeEvent(input$T3_button, {
    updateTabItems(session, "tabs", T3_tab)
  })
  
  # Safe
  observeEvent(input$S1_button, {
    updateTabItems(session, "tabs", S1_tab)
  })
  observeEvent(input$S2_button, {
    updateTabItems(session, "tabs", S2_tab)
  })
  observeEvent(input$S5_button, {
    updateTabItems(session, "tabs", S5_tab)
  })
  
  # Person Centred ----
  observeEvent(input$P1_button, {
    updateTabItems(session, "tabs", P1_tab)
  })
  observeEvent(input$P2_button, {
    updateTabItems(session, "tabs", P2_tab)
  })
  observeEvent(input$P3_button, {
    updateTabItems(session, "tabs", P3_tab)
  })
  observeEvent(input$P4_button, {
    updateTabItems(session, "tabs", P4_tab)
  })
  
  # Effective ----
  observeEvent(input$E1_button, {
    updateTabItems(session, "tabs", E1_tab)
  })
  
  # Efficient ----
  observeEvent(input$EF1_button, {
    updateTabItems(session, "tabs", EF1_tab)
  })
  observeEvent(input$EF2_button, {
    updateTabItems(session, "tabs", EF2_tab)
  })
  observeEvent(input$EF3_button, {
    updateTabItems(session, "tabs", EF3_tab)
  })
  observeEvent(input$EF4_button, {
    updateTabItems(session, "tabs", EF4_tab)
  })
  observeEvent(input$EF5_button, {
    updateTabItems(session, "tabs", EF5_tab)
  })
  
  # Equitable
  observeEvent(input$EQ1_button, {
    updateTabItems(session, "tabs", EQ1_tab)
  })
  observeEvent(input$EQ2_button, {
    updateTabItems(session, "tabs", EQ2_tab)
  })
  observeEvent(input$EQ4_button, {
    updateTabItems(session, "tabs", EQ4_tab)
  })
  
  
  # 'Previous Page' Buttons ----------------------------------------------------
  # Uses objects which are updated in 'constants.R' file
  observeEvent(input$prevPage1, {
    updateTabItems(session, "tabs", intro)
  })
  observeEvent(input$prevPage2, {
    updateTabItems(session, "tabs", page1)
  })
  observeEvent(input$prevPage3, {
    updateTabItems(session, "tabs", page2)
  })
  observeEvent(input$prevPage4, {
    updateTabItems(session, "tabs", page3)
  })
  observeEvent(input$prevPage5, {
    updateTabItems(session, "tabs", page4)
  })
  observeEvent(input$prevPage6, {
    updateTabItems(session, "tabs", page5)
  })
  
  # 'Next Page' Buttons ----------------------------------------------------
  # Uses  objects which are updated in 'constants.R' file
  observeEvent(input$nextPage1, {
    updateTabItems(session, "tabs", page2)
  })
  observeEvent(input$nextPage2, {
    updateTabItems(session, "tabs", page3)
  })
  observeEvent(input$nextPage3, {
    updateTabItems(session, "tabs", page4)
  })
  observeEvent(input$nextPage4, {
    updateTabItems(session, "tabs", page5)
  })
  observeEvent(input$nextPage5, {
    updateTabItems(session, "tabs", page6)
  })
  observeEvent(input$nextPage6, {
    updateTabItems(session, "tabs", intro)
  })
}

shinyApp(ui, server)
