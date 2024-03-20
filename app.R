library(phsstyles)
library(shiny)
library(shinydashboard)
library(shinyWidgets)

# Data import section ----------------------------------------------------

# Source constants used throughout app
source("constants.R")



ui <- dashboardPage(

  
  dashboardHeader(title = "MH Quality Indicators"),
  
  # # Point shiny to the css stylesheet that defines how things look 
  # tags$head(includeCSS("www/stylesheet.css")),
  # 
  # Define how the sidebar looks
  dashboardSidebar(
    # Define how the tab names appear in the sidebar
    sidebarMenu(id = "tabs",
                menuItem("Home", tabName = page0, selected = TRUE),
                menuItem("Page 1", tabName = page1),
                menuItem("Page 2", tabName = page2),
                menuItem("Page 3", tabName = page3),
                menuItem("Page 4", tabName = page4),
                menuItem("Page 5", tabName = page5),
                menuItem("Page 6", tabName = page6)
    )
  ),
  # Define how the various pages of the dashboard look
  dashboardBody(
    # Point shiny to the css stylesheet that defines how things look 
    tags$head(includeCSS("www/stylesheet.css")),
    
    # tags$head(
    #   tags$style(HTML(
    #     ".actionBttn { background-color: #3F3685; border-color: #3F3685; color: white; }"
    #   ))
    # ),
    tabItems(
      # Page 0 ----------------------------------------------------
      tabItem(tabName = page0,
              fluidRow(
                box(title = tagList(icon("hourglass-end"),
                    "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:"),
                    solidHeader = TRUE,
                    paste0(E1),
                    footer = 
                    actionButton(inputId = "button1", 
                                 label = "E1 - Find out more", 
                                 class = "navpageButton")),
                box(title = "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:",
                    solidHeader = TRUE,
                    # collapsible = TRUE,
                    paste0(E1),
                    actionButton(inputId = "button2", 
                                 icon = icon("hourglass-end"),
                                 label = "Find out more about E1", 
                                 class = "navpageButton")),
                box(icon = icon("hourglass-end"),
                    title = "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:",
                    solidHeader = TRUE,
                    # collapsible = TRUE,
                    paste0(E1),
                    actionButton(inputId = "button3", 
                                 icon = icon("hourglass-end"),
                                 label = "Find out more about E1", 
                                 class = "navpageButton")),
                box(icon = icon("hourglass-end"),
                    title = "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:",
                    solidHeader = TRUE,
                    # collapsible = TRUE,
                    paste0(E1),
                    actionButton(inputId = "button4", 
                                 icon = icon("hourglass-end"),
                                 label = "Find out more about E1", 
                                 class = "navpageButton")),
                box(icon = icon("hourglass-end"),
                    title = "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:",
                    solidHeader = TRUE,
                    # collapsible = TRUE,
                    paste0(E1),
                    actionButton(inputId = "button5", 
                                 icon = icon("hourglass-end"),
                                 label = "Find out more about E1", 
                                 class = "navpageButton")),
                box(icon = icon("hourglass-end"),
                    title = "E1 - Days in hospital when clinically ready 
                    to discharge, per 1,000 population:",
                    solidHeader = TRUE,
                    # collapsible = TRUE,
                    paste0(E1),
                    actionButton(inputId = "button6", 
                                 icon = icon("hourglass-end"),
                                 label = "Find out more about E1", 
                                 class = "navpageButton"))
                  
                )

              ),
      
      # Page 1 ----------------------------------------------------
      tabItem(tabName = page1,
              fluidPage(
                titlePanel("Page 1"),
                mainPanel(
                  h3("You are on Page 1"),
                  fluidRow(
                    column(6, actionButton("prevPage1", "Home Page", icon = icon("arrow-left"))),
                    column(6, actionButton("nextPage1", "Next Page", icon = icon("arrow-right")))
                  )
                )
              )
      ),
      # Page 2 ----------------------------------------------------
      tabItem(tabName = page2,
              fluidPage(
                titlePanel("Page 2"),
                mainPanel(
                  h3("You are on Page 2"),
                  fluidRow(
                    column(6, actionButton("prevPage2", "Previous Page", icon = icon("arrow-left"))),
                    column(6, actionButton("nextPage2", "Next Page", icon = icon("arrow-right")))
                  )
                )
              )
      ),
      # Page 3 ----------------------------------------------------
      tabItem(tabName = page3,
              fluidPage(
                titlePanel("Page 3"),
                mainPanel(
                  h3("You are on Page 3"),
                  fluidRow(
                    column(6, actionButton("prevPage3", "Previous Page", icon = icon("arrow-left"))),
                    column(6, actionButton("nextPage3", "Next Page", icon = icon("arrow-right")))
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
                    column(6, actionButton("prevPage4", "Previous Page", icon = icon("arrow-left"))),
                    column(6, actionButton("nextPage4", "Next Page", icon = icon("arrow-right")))
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
                    column(6, actionButton("prevPage5", "Previous Page", icon = icon("arrow-left"))),
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
                    column(6, actionButton("prevPage6", "Previous Page", icon = icon("arrow-left"))),
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
  
  # Navigation page buttons ----------------------------------------------------
  # Uses 'pageX' objects which are updated in 'constants.R' file
  observeEvent(input$button1, {
    updateTabItems(session, "tabs", page1)
  })
  observeEvent(input$button2, {
    updateTabItems(session, "tabs", page2)
  })
  observeEvent(input$button3, {
    updateTabItems(session, "tabs", page3)
  })
  observeEvent(input$button4, {
    updateTabItems(session, "tabs", page4)
  })
  observeEvent(input$button5, {
    updateTabItems(session, "tabs", page5)
  })
  observeEvent(input$button6, {
    updateTabItems(session, "tabs", page6)
  })
  
  # 'Previous Page' Buttons ----------------------------------------------------
  # Uses 'pageX' objects which are updated in 'constants.R' file
  observeEvent(input$prevPage1, {
    updateTabItems(session, "tabs", page0)
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
  # Uses 'pageX' objects which are updated in 'constants.R' file
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
    updateTabItems(session, "tabs", page0)
  })
}

shinyApp(ui, server)
