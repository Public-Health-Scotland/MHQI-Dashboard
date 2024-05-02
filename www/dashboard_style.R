# Define theme for shinydashboard elements
use_theme(create_theme(
  
  adminlte_global(
    content_bg = "#ECEBF3"
  ),
  
  # Sidebar colours
  adminlte_sidebar(
    dark_bg = "#3F3685",
    dark_color = "#ECEBF3",
    dark_hover_bg = "#9B4393",
    dark_hover_color = "#ECEBF3"
  )
)
) # End of theme