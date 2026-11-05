### Tooltip ----
# Create tooltip
# get the columns to use in tooltip
create_tooltips <- function(data, 
                            tooltip_columns,
                            tooltip_suffix = "") {
  
  tooltip_data <- data[, unname(tooltip_columns), drop = FALSE]
  
  # Repeat suffix if only one supplied
  if (length(tooltip_suffix) == 1) {
    tooltip_suffix <- rep(
      tooltip_suffix,
      length(tooltip_columns)
    )
  }
  
  # Create tooltip text for each row
  tooltip_text <- apply(
    tooltip_data,
    1,
    function(x) {
      
      values <- as.character(x)
      
      # Format each tooltip value
      for (i in seq_along(values)) {
        
        if (tooltip_suffix[i] == "comma") {
          # add comma to value if needed
          values[i] <- scales::comma(
            as.numeric(values[i])
          )
          
        } else {
          # add suffix, e.g., % at the end of value
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
#' @param tooltip_value_title Character string used as the label for the main
#' measure displayed in the tooltip.
#' @param tooltip_4_column Optional character string containing the name of an
#' additional variable to display in the tooltip.
#' @param tooltip_4_title Optional character string used as the label for the
#' additional tooltip variable.
#' @param tooltip_4_suffix Optional suffix added to the additional tooltip
#' variable (e.g., "%").
#' @param tooltip_suffix Optional suffix added to the main tooltip value 
#' (e.g., "%").
#' @param tooltip_value_comma Logical value indicating whether the main tooltip
#' value should be formatted with thousands separators.
#' @param graph_height Numeric value specifying the plot height in pixels.
#' @return A plotly interactive trend chart.
#' @examples 
#' create_trend_plot(
#'   data = data,
#'   x_column = "quarter",
#'   y_column = "rate",
#'   group_column = "board_name",
#'   x_axis_title = "Quarter",
#'   y_axis_title = "Emergency psychiatric bed days per 100,000 population",
#'   tooltip_value_title = "Emergency psychiatric bed days per 100,000 population"
#' )
create_trend_plot1 <- function(data,
                              x_column,
                              y_column,
                              group_column,
                              x_axis_title,
                              y_axis_title,
                              group_title,
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

