## This script defines some of the main colours of the dashboard 
## by creating a theme

# Define theme for shinydashboard elements
use_theme(create_theme(
  
  # Background colour for app pages
  adminlte_global(
    content_bg = "#ECEBF3"
  ),
  
  # Sidebar colours ----
  adminlte_sidebar(
    dark_bg = "#3F3685", # background colour
    dark_color = "#ECEBF3", # text colour
    dark_hover_bg = "#9B4393", # background hover colour
    dark_hover_color = "#ECEBF3" # text hover colour
  )
)
) # End of theme