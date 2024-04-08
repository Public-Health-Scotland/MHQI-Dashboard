# Define how the tab names appear in the sidebar
# Use icons to show what type of information is available - chart for data, 
# link for external source, pic for image from old publication
sidebarMenu(id = "tabs",
            menuItem("Introduction", tabName = intro, icon = icon("home"), selected = TRUE),
            menuItem("Scotland Hub", tabName = scot_hub, icon = icon("globe")),
            
            br(),
            
            menuItem("Timely :", icon = icon("clock")),
            menuItem("T 1", tabName = T1_tab, icon = icon("link")),
            menuItem("T 2", tabName = T2_tab, icon = icon("up-right-from-square")),
            menuItem("T 3", tabName = T3_tab, icon = icon("up-right-from-square")),
            
            menuItem("Safe :"),
            menuItem("S 1", tabName = S1_tab, icon = icon("image")),
            menuItem("S 2", tabName = S2_tab, icon = icon("image")),
            menuItem("S 5", tabName = S5_tab, icon = icon("image")),
            
            br(),
            
            menuItem("Person Centred :"),
            menuItem("P 1", tabName = P1_tab, icon = icon("image")),
            menuItem("P 2", tabName = P2_tab, icon = icon("image")),
            menuItem("P 3", tabName = P3_tab, icon = icon("image")),
            menuItem("P 4", tabName = P4_tab, icon = icon("image")),
            
            br(),
            
            menuItem("Effective :"),
            menuItem("E 1", tabName = E1_tab, icon = icon("bar-chart"), 
                     badgeLabel = "New", badgeColor = "green"),
            
            br(),
            
            menuItem("Efficient :"),
            menuItem("EF 1", tabName = EF1_tab, icon = icon("image")),
            menuItem("EF 2", tabName = EF2_tab, icon = icon("image")),
            menuItem("EF 3", tabName = EF3_tab, icon = icon("image")),
            menuItem("EF 4", tabName = EF4_tab, icon = icon("bar-chart")),
            menuItem("EF 5", tabName = EF5_tab, icon = icon("image")),
            
            br(),
            
            menuItem("Equitable :"),
            menuItem("EQ 1", tabName = EQ1_tab, icon = icon("bar-chart")),
            menuItem("EQ 2", tabName = EQ2_tab, icon = icon("image")),
            menuItem("EQ 4", tabName = EQ4_tab, icon = icon("image"))
            
) # End of sidebarMenu