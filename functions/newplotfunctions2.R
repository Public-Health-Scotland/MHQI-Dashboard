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
                              tooltip_value_title,
                              tooltip_4_column = NULL,
                              tooltip_4_title = NULL,
                              tooltip_4_suffix = "",
                              tooltip_suffix = "",
                              tooltip_value_comma = FALSE) 
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
  
  # Format tooltip value
  tooltip_value <- data[[y_column]]
  
  if (tooltip_value_comma) {
    tooltip_value <- prettyNum(
      tooltip_value,
      big.mark = ","
    )
  }
  
  # Use group value as title if no value title supplied
  if (is.null(tooltip_value_title)) {
    tooltip_value_title <- data[[group_column]]
  }
  
  # Create tooltip
  tooltip_text <- paste0(
    x_axis_title, ": ", data[[x_column]],
    if (!is.null(group_title)) {
      paste0(
        "<br>",
        group_title, ": ", data[[group_column]]
      )
    },
    "<br>",
    tooltip_value_title, ": ", tooltip_value,
    tooltip_suffix
  )
  
  # Add optional fourth tooltip
  if (!is.null(tooltip_4_column)) {
    
    tooltip_text <- paste0(
      tooltip_text,
      "<br>",
      tooltip_4_title, ": ",
      data[[tooltip_4_column]],
      tooltip_4_suffix
    )
  }

  plotly::plot_ly(
    data = data,
    
    x = data[[x_column]],
    y = data[[y_column]],
    color = data[[group_column]],
    
    text = tooltip_text,
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

### Bar Chart ----
create_bar_plot1 <- function(data,
                            x_column,
                            y_column,
                            x_axis_title,
                            y_axis_title,
                            tooltip_1_column,
                            tooltip_1_title,
                            tooltip_2_column,
                            tooltip_2_title,
                            tooltip_3_column,
                            tooltip_3_title,
                            tooltip_3_suffix,
                            tooltip_3_comma = FALSE) {
  
  req(nrow(data) > 0)
  
  x_values <- data[[x_column]]
  y_values <- data[[y_column]]
  
  # Optional comma formatting for tooltip value
  tooltip_3_value <- data[[tooltip_3_column]]
  
  if (tooltip_3_comma) {
    
    tooltip_3_value <- format(
      tooltip_3_value,
      big.mark = ",",
      scientific = FALSE,
      trim = TRUE
    )
    
  }
  
  tooltip_text <- paste0(
    tooltip_1_title, ": ",
    data[[tooltip_1_column]],
    "<br>",
    tooltip_2_title, ": ",
    data[[tooltip_2_column]],
    "<br>",
    tooltip_3_title, ": ",
    tooltip_3_value,
    tooltip_3_suffix
  )
  
  # Calculate x-axis range
  x_max <- max(x_values, na.rm = TRUE) * 1.2
  x_axis_range <- c(0, x_max)
  
  
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
    
    text = tooltip_text,
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
        range = x_axis_range,
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

