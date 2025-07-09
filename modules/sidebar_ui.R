# Define how the tab names appear in the sidebar
# Use icons to show what type of information is available - chart for data, 
# link for external source, pic for image from old publication

sidebarMenu(
  # Enable scrolling of sidebar
  style = "height:94vh; 
  overflow-y:auto; 
  scrollbar-color: #9F9BC2 #3F3685;" ,
  # width: 300px;", 
  
  id = "tabs",
  
  menuItem("Introduction", tabName = "intro", icon = icon("home"), selected = TRUE),
  menuItem("Scotland Hub", tabName = "scot_hub", icon = icon("globe")),
  menuItem("Glossary", tabName = "glossary", icon = icon("book")),
  menuItem("Data Tab", tabName = "data_tab", icon = icon("database")),
  
  br(),
  ## Timely Tabs ----          
  menuItem("Timely :", icon = icon("clock")),
  menuItem("T1 - Adult", tabName = "T1_tab", icon = icon("link")),
  menuItem("T2 - Child and Adolescent", tabName = "T2_tab", icon = icon("up-right-from-square")),
  menuItem("T3 - Drugs or Alcohol", tabName = "T3_tab", icon = icon("up-right-from-square")),
        
  br(),
  ## Safe Tabs ----           
  menuItem("Safe :"),
  menuItem("S1 - Suicide", tabName = "S1_tab", icon = icon("image")),
  menuItem("S2 - Community Follow-up", tabName = "S2_tab", icon = icon("bar-chart"), 
           badgeLabel = "Updated", badgeColor = "orange"),
  menuItem("S5 - Physical Violence", tabName = "S5_tab", icon = icon("bar-chart"), 
           badgeLabel = "Updated", badgeColor = "orange"),
            
  br(),
  ## Person Tabs ----           
  menuItem("Person Centred :"),
  menuItem("P1 - Carers", tabName = "P1_tab", icon = icon("image")),
  menuItem("P2 - At Home Support", tabName = "P2_tab", icon = icon("image")),
  menuItem("P3 - Listened To", tabName = "P3_tab", icon = icon("image")),
  menuItem("P4 - Advance Statements", tabName = "P4_tab", icon = icon("image")),
            
  br(),
  ## Effective Tabs ----           
  menuItem("Effective :"),
  menuItem("E1 - Delayed Discharge", tabName = "E1_tab", icon = icon("bar-chart"), 
           badgeLabel = "Updated", badgeColor = "orange"),
          
  br(),
  ## Efficient Tabs ----           
  menuItem("Efficient :"),
  menuItem("EF 1 - Emergency Bed Days", tabName = "EF1_tab", icon = icon("image")),
  menuItem("EF 2 - Readmissions", tabName = "EF2_tab", icon = icon("image")),
  menuItem("EF 3 - Psychiatric Beds", tabName = "EF3_tab", icon = icon("image")),
  menuItem("EF 4 - Mental Health Spend", tabName = "EF4_tab", icon = icon("bar-chart")),
  menuItem("EF 5 - Community DNA", tabName = "EF5_tab", icon = icon("bar-chart"), 
           badgeLabel = "Updated", badgeColor = "orange"),
            
  br(),
  ## Equitable Tabs ----           
  menuItem("Equitable :"),
  menuItem("EQ 1 - Premature Mortality", tabName = "EQ1_tab", icon = icon("bar-chart")),
  menuItem("EQ 2 - Emergency Detention", tabName = "EQ2_tab", icon = icon("image")),
  menuItem("EQ 4 - U18 Outwith CAMH Wards", tabName = "EQ4_tab", icon = icon("image"))
            
) # End of sidebarMenu