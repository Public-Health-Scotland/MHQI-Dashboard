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
      # [Introduction Tab] ----------------------------------------------------
      tabItem(tabName = intro,
              fluidPage(
                titlePanel("Mental Health Quality Indicators Joint Collection Materials"),
                mainPanel("Words")
              )), # End of Intro Tab
      
      # [Scotland Hub Tab] ----------------------------------------------------
      tabItem(tabName = scot_hub,
              # fluidPage(
              #   mainPanel(
              
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
                  title = tagList(icon("hourglass-end"),
                                  "% of young people who commence treatment 
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
              
              # 'Efficient' Indicators ----
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
              
              # Closing brackets ----
              
              # ) # End of Main Panel
              # ) # End of fluidPage
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
                  column(6, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(6, actionButton(inputId = "T2_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            ) # End of fluidPage
    ), # End of tab
    
    # T2 ----------------------------------------------------
    tabItem(tabName = T2_tab,
            fluidPage(
              titlePanel("Page 2"),
              mainPanel(
                h3("Text description of T2"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton("T1_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton("T3_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # T3 ----------------------------------------------------
    tabItem(tabName = T3_tab,
            fluidPage(
              titlePanel("Page 3"),
              mainPanel(
                h3("Text description of T3"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "T2_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "S1_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # S1 ----------------------------------------------------
    tabItem(tabName = S1_tab,
            fluidPage(
              titlePanel("Page 4"),
              mainPanel(
                h3("You are on Page 4"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "T3_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "S2_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # S2 ----------------------------------------------------
    tabItem(tabName = S2_tab,
            fluidPage(
              titlePanel("Page 5"),
              mainPanel(
                h3("You are on Page 5"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "S1_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "S5_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # S5 ----------------------------------------------------
    tabItem(tabName = S5_tab,
            fluidPage(
              titlePanel("Page 6"),
              mainPanel(
                h3("You are on Page 6"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "S2_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "P1_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              ) # End of mainPanel
            ) # End of fluidPage
    ),
    
    # P1 ----------------------------------------------------
    tabItem(tabName = P1_tab,
            fluidPage(
              titlePanel("P1"),
              mainPanel(
                h3("You are on P1"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "S1_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "P2_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # P2 ----------------------------------------------------
    tabItem(tabName = P2_tab,
            fluidPage(
              titlePanel("P2"),
              mainPanel(
                h3("You are on P2"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "P1_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "P3_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # P3 ----------------------------------------------------
    tabItem(tabName = P3_tab,
            fluidPage(
              titlePanel("P3"),
              mainPanel(
                h3("You are on P3"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "p2_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "p4_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # P4 ----------------------------------------------------
    tabItem(tabName = P4_tab,
            fluidPage(
              titlePanel("P4"),
              mainPanel(
                h3("You are on P4"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "P3_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "E1_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # E1 ----------------------------------------------------
    tabItem(tabName = E1_tab,
            fluidPage(
              titlePanel("E1"),
              mainPanel(
                h3("You are on E1"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "P4_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EF1_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # EF1 ----------------------------------------------------
    tabItem(tabName = EF1_tab,
            fluidPage(
              titlePanel("EF1"),
              mainPanel(
                h3("You are on EF1"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "E1_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EF2_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # EF2 ----------------------------------------------------
    tabItem(tabName = P4_tab,
            fluidPage(
              titlePanel("EF2"),
              mainPanel(
                h3("You are on EF2"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EF1_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EF3_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # EF3 ----------------------------------------------------
    tabItem(tabName = EF3_tab,
            fluidPage(
              titlePanel("EF3"),
              mainPanel(
                h3("You are on EF3"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EF2_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EF4_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # EF4 ----------------------------------------------------
    tabItem(tabName = EF4_tab,
            fluidPage(
              titlePanel("EF4"),
              mainPanel(
                h3("You are on EF4"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EF3_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EF5_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # EF5 ----------------------------------------------------
    tabItem(tabName = EF5_tab,
            fluidPage(
              titlePanel("EF5"),
              mainPanel(
                h3("You are on EF5"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EF4_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EQ1_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # EQ1 ----------------------------------------------------
    tabItem(tabName = EQ1_tab,
            fluidPage(
              titlePanel("EQ1"),
              mainPanel(
                h3("You are on EQ1"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EF5_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EQ2_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # EQ2 ----------------------------------------------------
    tabItem(tabName = EQ2_tab,
            fluidPage(
              titlePanel("EQ2"),
              mainPanel(
                h3("You are on EQ2"),
                fluidRow(
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EQ1_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "EQ4_navButton", 
                                         label = "Next Page", icon = icon("arrow-right"),
                                         class = "navpageButton"))
                )
              )
            )
    ),
    
    # EQ4 ----------------------------------------------------
    tabItem(tabName = EQ4_tab,
            fluidPage(
              titlePanel("EQ4"),
              mainPanel(
                h3("You are on EQ4"),
                fluidRow(
                  column(4, actionButton(inputId = "EQ2_navButton", 
                                         label = "Previous Page", icon = icon("arrow-left"),
                                         class = "navpageButton")),
                  column(4, actionButton(inputId = "scot_hub_button", 
                                         label = "Scotland Hub", icon = icon("home"),
                                         class = "navpageButton"))
                )
              )
            )
    )
   )
  ) # End of dashboardBody
) # End of UI

# Server  ----------------------------------------------------
server <- function(input, output, session) {
  
  # [Navigation page buttons] ----------------------------------------------------
  # Uses objects which are updated in 'constants.R' file
  
  # # Hub ----
  # observeEvent(input$scot_hub_button, {
  #   updateTabItems(session, "tabs", scot_hub)
  # })
  
  # Timely ----
  observeEvent(input$T1_button, {
    updateTabItems(session, "tabs", T1_tab)
  })
  observeEvent(input$T2_button, {
    updateTabItems(session, "tabs", T2_tab)
  })
  observeEvent(input$T3_button, {
    updateTabItems(session, "tabs", T3_tab)
  })
  
  # Safe ----
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

  # Hub ----
  observeEvent(input$scot_hub_button, {
    updateTabItems(session, "tabs", scot_hub)
  })

  # Timely ----
  observeEvent(input$T1_navButton, {
    updateTabItems(session, "tabs", T1_tab)
  })
  observeEvent(input$T2_navButton, {
    updateTabItems(session, "tabs", T2_tab)
  })
    observeEvent(input$T3_navButton, {
    updateTabItems(session, "tabs", T3_tab)
  })

  # Safe ----
  observeEvent(input$S1_navButton, {
    updateTabItems(session, "tabs", S1_tab)
  })
  observeEvent(input$S2_navButton, {
    updateTabItems(session, "tabs", S2_tab)
  })
  observeEvent(input$S5_navButton, {
    updateTabItems(session, "tabs", S5_tab)
  })


  # Person Centred ----
  observeEvent(input$P1_navButton, {
    updateTabItems(session, "tabs", P1_tab)
  })
  observeEvent(input$P2_navButton, {
    updateTabItems(session, "tabs", P2_tab)
  })
  observeEvent(input$P3_navButton, {
    updateTabItems(session, "tabs", P3_tab)
  })
  observeEvent(input$P4_navButton, {
    updateTabItems(session, "tabs", P4_tab)
  })

  # Effective ----
  observeEvent(input$E1_navButton, {
    updateTabItems(session, "tabs", E1_tab)
  })

  # Efficient ----
  observeEvent(input$EF1_navButton, {
    updateTabItems(session, "tabs", EF1_tab)
  })
  observeEvent(input$EF2_navButton, {
    updateTabItems(session, "tabs", EF2_tab)
  })
  observeEvent(input$EF3_navButton, {
    updateTabItems(session, "tabs", EF3_tab)
  })
  observeEvent(input$EF4_navButton, {
    updateTabItems(session, "tabs", EF4_tab)
  })
  observeEvent(input$EF5_navButton, {
    updateTabItems(session, "tabs", EF5_tab)
  })

  # Equitable ----
  observeEvent(input$EQ1_navButton, {
    updateTabItems(session, "tabs", EQ1_tab)
  })
  observeEvent(input$EQ2_navButton, {
    updateTabItems(session, "tabs", EQ2_tab)
  })
  observeEvent(input$EQ4_navButton, {
    updateTabItems(session, "tabs", EQ4_tab)
  })

  # # 'Next Page' Buttons ----------------------------------------------------
  # # Uses  objects which are updated in 'constants.R' file
  # observeEvent(input$nextPage1, {
  #   updateTabItems(session, "tabs", page2)
  # })
  # observeEvent(input$nextPage2, {
  #   updateTabItems(session, "tabs", page3)
  # })
  # observeEvent(input$nextPage3, {
  #   updateTabItems(session, "tabs", page4)
  # })
  # observeEvent(input$nextPage4, {
  #   updateTabItems(session, "tabs", page5)
  # })
  # observeEvent(input$nextPage5, {
  #   updateTabItems(session, "tabs", page6)
  # })
  # observeEvent(input$nextPage6, {
  #   updateTabItems(session, "tabs", intro)
  # })
}

shinyApp(ui, server)
