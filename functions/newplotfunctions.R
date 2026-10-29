###--- HEALTH BOARD SORTING FUNCTION ---###
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

###--- LINE TREND PLOT FUNCTION ---###
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

create_trend_plot <- function(data,
                              x_column,
                              y_column,
                              group_columns,
                              x_axis_title,
                              y_axis_title,
                              tooltip_value_title,
                              group_titles = NULL,
                              style_column = NULL,
                              tooltip_4_column = NULL,
                              tooltip_4_title = NULL,
                              tooltip_4_suffix = "",
                              tooltip_suffix = "",
                              tooltip_value_comma = FALSE,
                              graph_height = 600,
                              tooltip_group_as_title = FALSE,
                              tooltip_title_column = NULL) {
  
  shiny::req(nrow(data) > 0)
  
  group_columns <- as.character(group_columns)
  
  # Use first grouping column for styling unless specified
  if (is.null(style_column)) {
    style_column <- group_columns[1]
  }
  
  # Tooltip titles
  if (is.null(group_titles)) {
    group_titles <- group_columns
  }
  
  if (length(group_titles) != length(group_columns)) {
    stop("group_titles must match group_columns.")
  }
  
  # Create unique line grouping
  data$.trace_id <- if (length(group_columns) == 1) {
    as.character(data[[group_columns]])
  } else {
    do.call(
      paste,
      c(data[group_columns], sep = "|||")
    )
  }
  
  data$.style_value <- as.character(data[[style_column]])
  
  # -----------------------
  # Tooltip
  # -----------------------
  
  tooltip_text <- paste0(
    x_axis_title, ": ", data[[x_column]]
  )
  
  if (!tooltip_group_as_title) {
    
    for (i in seq_along(group_columns)) {
      tooltip_text <- paste0(
        tooltip_text,
        "<br>",
        group_titles[i], ": ",
        data[[group_columns[i]]]
      )
    }
  }
  
  if (!is.null(tooltip_4_column) &&
      !is.null(tooltip_4_title)) {
    
    tooltip_text <- paste0(
      tooltip_text,
      "<br>",
      tooltip_4_title, ": ",
      data[[tooltip_4_column]],
      tooltip_4_suffix
    )
  }
  
  tooltip_value <- data[[y_column]]
  
  if (tooltip_value_comma) {
    tooltip_value <- format(
      tooltip_value,
      big.mark = ",",
      scientific = FALSE,
      trim = TRUE
    )
  }
  
  tooltip_title <- if (
    tooltip_group_as_title &&
    !is.null(tooltip_title_column)
  ) {
    data[[tooltip_title_column]]
  } else {
    tooltip_value_title
  }
  
  data$.tooltip_text <- paste0(
    tooltip_text,
    "<br>",
    tooltip_title, ": ",
    tooltip_value,
    tooltip_suffix
  )
  
  # -----------------------
  # Style order
  # Higher line = solid
  # -----------------------
  
  style_levels <- data %>%
    dplyr::group_by(.style_value) %>%
    dplyr::summarise(
      mean_value = mean(.data[[y_column]], na.rm = TRUE),
      .groups = "drop"
    ) %>%
    dplyr::arrange(dplyr::desc(mean_value)) %>%
    dplyr::pull(.style_value)
  
  colours <- stats::setNames(
    rep(
      c("#3F3685", "#9B4393", "#0078D4", "#1E7F84"),
      length.out = length(style_levels)
    ),
    style_levels
  )
  
  lines <- stats::setNames(
    rep(
      c("solid", "dash", "solid", "dash"),
      length.out = length(style_levels)
    ),
    style_levels
  )
  
  symbols <- stats::setNames(
    rep(
      c("circle", "square", "triangle-up", "triangle-down"),
      length.out = length(style_levels)
    ),
    style_levels
  )
  
  # -----------------------
  # Plot
  # -----------------------
  
  p <- plotly::plot_ly(height = graph_height)
  
  legend_added <- character(0)
  
  for (current_trace in unique(data$.trace_id)) {
    
    trace_data <- data[
      data$.trace_id == current_trace,
      ,
      drop = FALSE
    ]
    
    style <- trace_data$.style_value[1]
    show_legend <- !style %in% legend_added
    
    if (show_legend) {
      legend_added <- c(legend_added, style)
    }
    
    p <- plotly::add_trace(
      p,
      data = trace_data,
      x = trace_data[[x_column]],
      y = trace_data[[y_column]],
      type = "scatter",
      mode = "lines+markers",
      
      name = stringr::str_wrap(style, 15),
      legendgroup = style,
      showlegend = show_legend,
      
      text = trace_data$.tooltip_text,
      hoverinfo = "text",
      
      line = list(
        width = 3,
        color = colours[[style]],
        dash = lines[[style]]
      ),
      
      marker = list(
        size = 12,
        color = colours[[style]],
        symbol = symbols[[style]]
      ),
      
      inherit = FALSE
    )
  }
  
  # -----------------------
  # Layout
  # -----------------------
  
  y_axis_max <- max(data[[y_column]], na.rm = TRUE)
  
  if (!is.finite(y_axis_max)) {
    y_axis_max <- 1
  }
  
  p %>%
    plotly::layout(
      yaxis = list(
        exponentformat = "none",
        range = c(0, y_axis_max * 1.3),
        title = list(
          text = y_axis_title,
          standoff = 20
        ),
        automargin = TRUE,
        showline = TRUE,
        ticks = "outside"
      ),
      
      xaxis = list(
        tickangle = -45,
        title = list(
          text = x_axis_title,
          standoff = 30
        ),
        automargin = TRUE,
        range = c(
          -0.5,
          dplyr::n_distinct(data[[x_column]]) - 0.5
        ),
        showline = TRUE,
        ticks = "outside"
      ),
      
      margin = list(
        l = 90,
        r = 60,
        b = 170,
        t = 90
      ),
      
      font = list(size = 13),
      showlegend = TRUE,
      
      legend = list(
        x = 1,
        y = 0.8,
        bgcolor = "rgba(255,255,255,0)",
        bordercolor = "rgba(255,255,255,0)"
      )
    ) %>%
    
    plotly::config(
      displayModeBar = TRUE,
      
      modeBarButtonsToRemove = list(
        "select2d",
        "lasso2d",
        "toggleSpikelines",
        "hoverCompareCartesian",
        "hoverClosestCartesian"
      ),
      
      displaylogo = FALSE,
      editable = FALSE
    )
}


# bar chart function ----
create_bar_plot <- function(data,
                            x_column,
                            y_column,
                            colour_column = NULL,
                            board_column = NULL,
                            x_axis_title,
                            y_axis_title,
                            tooltip_1_column,
                            tooltip_1_title,
                            tooltip_2_column,
                            tooltip_2_title,
                            tooltip_3_column,
                            tooltip_3_title,
                            tooltip_3_suffix = "",
                            tooltip_3_comma = FALSE,
                            graph_height = 600) {
  
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
  bar_colours <- if (!is.null(colour_column)) {
    
    data[[colour_column]]
    
  } else if (!is.null(board_column)) {
    
    ifelse(
      data[[board_column]] == "NHS Scotland",
      "#3F3685",  # purple
      "#0078D4"   # blue
    )
    
  } else {
    
    "#0078D4"
    
  }
  
  plotly::plot_ly(
    data = data,
    
    x = x_values,
    y = y_values,
    
    type = "bar",
    
    text = tooltip_text,
    hoverinfo = "text",
    textposition = "none",
    
    marker = list(
      color = bar_colours
    ),
    
    height = graph_height
  ) %>%
    
    plotly::layout(
      
      font = list(size = 13),
      
      xaxis = list(
        title = x_axis_title,
        range = x_axis_range,
        exponentformat = "none",
        separatethousands = TRUE,
        showline = TRUE,
        ticks = "outside"
      ),
      
      yaxis = list(
        title = y_axis_title,
        showline = TRUE,
        ticks = "outside"
      ),
      
      margin = list(
        l = 90,
        r = 60,
        b = 170,
        t = 90
      )
    ) %>%
    
    plotly::config(
      displayModeBar = TRUE,
      
      modeBarButtonsToRemove = list(
        "select2d",
        "lasso2d",
        "toggleSpikelines",
        "hoverCompareCartesian",
        "hoverClosestCartesian"
      ),
      
      displaylogo = FALSE,
      editable = FALSE
    )
}

# grouped bar chart
create_grouped_bar_plot <- function(
    data,
    x_column,
    y1_column,
    y2_column,
    y1_name,
    y2_name,
    y1_colour = "#3393DD",
    y2_colour = "#B3D7F2",
    graph_height = 600
) {
  
  req(nrow(data) > 0)
  
  tooltip_1 <- paste0(
    "Quarter: ", data[[x_column]],
    "<br>",
    y1_name, ": ",
    prettyNum(data[[y1_column]], big.mark = ",")
  )
  
  tooltip_2 <- paste0(
    "Quarter: ", data[[x_column]],
    "<br>",
    y2_name, ": ",
    prettyNum(data[[y2_column]], big.mark = ",")
  )
  
  plotly::plot_ly(
    data = data,
    
    x = data[[x_column]],
    y = data[[y1_column]],
    
    type = "bar",
    name = y1_name,
    
    text = tooltip_1,
    hovertemplate = "%{text}<extra></extra>",
    textposition = "none",
    
    marker = list(
      color = y1_colour
    )
  ) %>%
    
    plotly::add_trace(
      y = data[[y2_column]],
      
      type = "bar",
      name = y2_name,
      
      text = tooltip_2,
      hovertemplate = "%{text}<extra></extra>",
      textposition = "none",
      
      marker = list(
        color = y2_colour
      )
    ) %>%
    
    plotly::layout(
      
      barmode = "group",
      
      font = list(size = 13),
      
      yaxis = list(
        title = "Number of Admissions",
        exponentformat = "none",
        tickformat = ",",
        showline = TRUE,
        ticks = "outside"
      ),
      
      xaxis = list(
        title = "Quarter",
        tickangle = -45,
        showline = TRUE,
        ticks = "outside"
      ),
      
      margin = list(
        l = 90,
        r = 60,
        b = 170,
        t = 90
      )
    ) %>%
    
    plotly::config(
      displayModeBar = TRUE,
      modeBarButtonsToRemove = list(
        "select2d",
        "lasso2d",
        "toggleSpikelines",
        "hoverCompareCartesian",
        "hoverClosestCartesian"
      ),
      displaylogo = FALSE,
      editable = FALSE
    )
  
}