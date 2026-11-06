### Tooltip ----
# Create tooltip
# get the columns to use in tooltip
create_tooltips <- function(data, 
                            tooltip_columns,
                            tooltip_suffix = "") {
  
  #get column names for tooptip hover
  #drop = F ensures the result stays as a data frame even if only specify one
  #tooptip column
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
#' @param tooltip_columns Character string containing the names to 
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
create_trend_plot1 <- function(data,
                              x_column,
                              y_column,
                              group_column,
                              x_axis_title,
                              y_axis_title,
                              tooltip_columns,
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
create_bar_plot1 <- function(data,
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

