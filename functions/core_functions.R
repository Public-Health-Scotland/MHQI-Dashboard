### This script contains functions and repeated chunks of code used throughout 
### the app in order to reduce the app size.

### [ Repeated Code Chunks ] ----

# Go to top button ----
go_2_top_bttn <- gotop::use_gotop(
  src = "fas fa-chevron-circle-up", # css class from Font Awesome
  color = phs_colors('phs-blue'), # color
  opacity = 0.8, # transparency
  width = 50, # size
  appear = 80 # number of pixels before appearance
)

### [ Functions ] 

# Load data from shiny_app/data ----
load_csv_file <- function(csv){
  # Given a .csv file name in shiny_app/data
  # this function loads it as a variable with the same name as the
  # file apart from the extension
  assign(gsub(".csv", "", csv), read.csv(paste0("data/", csv)), envir = .GlobalEnv)
}

### Health Board Sorter ----
#' @title Sort NHS health board names
#' @description Sorts a character vector of NHS health board names into the
#' standard NHS Scotland reporting order.
#' To ensure correct ordering, "NHS Grampian (inc. Orkney & Shetland)" is
#' temporarily recoded to "NHS Grampian" for sorting purposes. The original
#' health board names are returned unchanged.
#' @param hb_name A character vector containing NHS health board names.
#' @return A character vector of health board names sorted into the standard
#' NHS Scotland ordering.
#' @examples
#' sort_hb_names(
#'   c(
#'     "NHS Lothian",
#'     "NHS Ayrshire & Arran",
#'     "NHS Scotland"
#'   )
#' )
#' would return:
#' c(
#'   "NHS Ayrshire & Arran",
#'   "NHS Lothian",
#'   "NHS Scotland"
#' )
sort_hb_names <- function(hb_name) {
  
  sort_name <- dplyr::recode(
    hb_name,
    "NHS Grampian (inc. Orkney & Shetland)" = "NHS Grampian"
  )
  
  hb_order <- c(
    "NHS Ayrshire & Arran",
    "NHS Borders",
    "NHS Dumfries & Galloway",
    "NHS Fife",
    "NHS Forth Valley",
    "NHS Grampian",
    "NHS Greater Glasgow & Clyde",
    "NHS Highland",
    "NHS Lanarkshire",
    "NHS Lothian",
    "NHS Orkney",
    "NHS Shetland",
    "NHS Tayside",
    "NHS Western Isles",
    "NHS Scotland"
  )
  
  hb_name[order(match(sort_name, hb_order))]
}

### Health Board Picker ----
# hb picker ----
create_hb_picker <- function(input_id,
                             choices,
                             selected = NULL,
                             maximum = 4) {
  
  choices <- sort_hb_names(unique(choices))
  
  if (is.null(selected)) {
    selected <- if ("NHS Scotland" %in% choices) {
      "NHS Scotland"
    } else {
      "NHS Ayrshire & Arran"
    }
  }
  
  shinyWidgets::pickerInput(
    inputId = input_id,
    label = paste0(
      "Select NHS health board(s) (Maximum ",
      maximum,
      "):"
    ),
    choices = choices,
    selected = selected,
    multiple = TRUE,
    options = list(
      "max-options" = maximum,
      `selected-text-format` = "count > 1"
    )
  )
}

### Tooltip ----
# Create tooltip
# get the columns to use in tooltip
create_tooltips <- function(data, 
                            tooltip_columns,
                            tooltip_suffix = "") {
  
  #get column names for tooltip hover
  #drop = F ensures the result stays as a data frame even if only specify one
  #tooltip column
  tooltip_data <- data[, unname(tooltip_columns), drop = FALSE]
  
  # Create tooltip text for each row, e.g.: NHS Grampian | 1234 | 82.5
  tooltip_text <- apply(
    tooltip_data,
    1,
    function(x) {
      #convert values to character (as building text)
      values <- as.character(x)
      
      # Format each tooltip value
      for (i in seq_along(values)) {
        
        if (tooltip_suffix[i] == "comma") {
          #add comma to value if needed, e.g.
          #1234 - converts back to numeric, and turns into 1,234
          values[i] <- scales::comma(
            as.numeric(values[i])
          )
          #for anything other than "comma", suffix is added to the end
        } else {
          # tooltip_suffix <- c("", "comma", "%")
          # "NHS Grampian" "1,234" "82.5%"
          values[i] <- paste0(
            values[i],
            tooltip_suffix[i]
          )
        }
      }
      # add tooltip labels and put each item on a new line
      paste(
        paste0(
          names(tooltip_columns),
          ": ",
          values
        ),
        collapse = "<br>"
      )
    }
  )
  
  return(tooltip_text)
}


### Line Chart ----
#' @title Create Plotly line trend chart
#' @description Creates an interactive line chart showing trends over time for
#' one or more groups.
#' The x-axis typically represents time periods (for example quarters or years),
#' while the y-axis represents the measure of interest.
#' Multiple groups can be displayed using different colours, line types and
#' marker symbols.
#' Optional tooltip fields can be added to display supporting information such
#' as counts, beds etc when a user hovers over a data point.
#' @param data A data frame containing the plotting data.
#' @param x_column Character string containing the name of the x-axis variable.
#' @param y_column Character string containing the name of the y-axis variable.
#' @param group_column Character string containing the name of the grouping
#' variable used for colours, line styles and symbols.
#' @param x_axis_title Character string used as the x-axis title.
#' @param y_axis_title Character string used as the y-axis title.
#' @param tooltip_columns Optional character string containing the names to 
#' display in the tooltip and the associated column name.
#' @param tooltip_suffix Suffix added to the tooltip variable (e.g., "%").
#' @return A plotly interactive trend chart.
#' @examples 
#' create_trend_plot(
#' data = data,
#' x_column = "year_months",
#' y_column = "bedday_rate",
#' group_column = "hb_name",
#' x_axis_title = "Quarter",
#' y_axis_title = "Emergency psychiatric bed days per 100,000 population",
#' group_title = "Health Board",
#' tooltip_columns = c(
#'   "Quarter" = "year_months",
#'   "Health board" = "hb_name",
#'   "Emergency psychiatric bed days per 100,000 population" = "bedday_rate"
#' ),
#' tooltip_suffix = c("", "", "comma"))
create_trend_plot <- function(data,
                              x_column,
                              y_column,
                              group_column,
                              x_axis_title,
                              y_axis_title,
                              tooltip_columns = NULL,
                              tooltip_suffix = "")
{
  
  # Stop the plot from running when the filtered data is empty
  shiny::req(nrow(data) > 0)
  
  # Calculate upper y-axis limit
  y_axis_max <- max(data[[y_column]], na.rm = TRUE)
  
  if (!is.finite(y_axis_max)) {
    y_axis_max <- 1
  }
  
  # Make the x-axis range adjust automatically to the number of periods
  x_axis_range <- c(
    -0.5,
    dplyr::n_distinct(data[[x_column]]) - 0.5
  )
  
  hover_text <- create_tooltips(data, tooltip_columns, tooltip_suffix)
  
  plotly::plot_ly(
    data = data,
    
    x = data[[x_column]],
    y = data[[y_column]],
    color = data[[group_column]],
    
    text = hover_text,
    hoverinfo = "text",
    
    type = "scatter",
    mode = "lines+markers",
    
    line = line_style,
    marker = marker_style,
    colors = plot_colours,
    
    height = plot_height,
    
    name = stringr::str_wrap(data[[group_column]], 15)
  ) %>%
    
    plotly::layout(
      yaxis = c(
        axis_style,
        list(
          exponentformat = "none",
          separatethousands = TRUE,
          range = c(0, y_axis_max * 1.3),
          title = list(
            text = y_axis_title,
            #distance between title and tick labels
            standoff = 20
          )
        )
      ),
      
      xaxis = c(
        axis_style,
        list(
          tickangle = -45,
          range = x_axis_range,
          title = list(
            text = x_axis_title,
            #distance between title and tick labels
            standoff = 30
          )
        )
      ),
      
      margin = plot_margin,
      
      font = font_style,
      
      showlegend = TRUE,
      legend = legend_style
    ) %>%
    
    plotly::config(
      displayModeBar = TRUE,
      modeBarButtonsToRemove = modebar_buttons_remove,
      displaylogo = FALSE,
      editable = FALSE
    )
}


# ### Bar Chart ----
create_bar_plot <- function(data,
                            x_column,
                            y_column,
                            x_axis_title,
                            y_axis_title,
                            tooltip_columns = NULL,
                            tooltip_suffix = "") {
  
  req(nrow(data) > 0)
  
  x_values <- data[[x_column]]
  y_values <- data[[y_column]]
  
  hover_text <- create_tooltips(data, tooltip_columns, tooltip_suffix)
  
  # Colour scheme
  bar_colours <- ifelse(
    y_values == "NHS Scotland",
    plot_colours[[1]],  # purple
    plot_colours[[3]]   # blue
  )
  
  plotly::plot_ly(
    data = data,
    
    x = x_values,
    y = y_values,
    
    type = "bar",
    orientation = "h",
    
    text = hover_text,
    hoverinfo = "text",
    textposition = "none",
    
    marker = list(
      color = bar_colours
    ),
    
    height = plot_height
  ) %>%
    
    plotly::layout(
      
      xaxis = c(
        axis_style,
        list(
          title = x_axis_title,
          exponentformat = "none",
          separatethousands = TRUE
        )
      ),
      
      yaxis = c(
        axis_style,
        list(
          title = y_axis_title
        )
      ),
      
      margin = plot_margin,
      font = font_style
    ) %>%
    
    plotly::config(
      displayModeBar = TRUE,
      modeBarButtonsToRemove = modebar_buttons_remove,
      displaylogo = FALSE,
      editable = FALSE
    )
}

