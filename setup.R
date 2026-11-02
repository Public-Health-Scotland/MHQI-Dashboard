### Plot Style & Parameters ----
#phs palette colours - https://code.publichealthscotland.scot/phsstyles/
plot_colours <- phsstyles::phs_colors(
  c("phs-purple", "phs-magenta", "phs-blue", "phs-teal")
)

#shared axis styling
axis_style <- list(
  automargin = TRUE,
  showline = TRUE,
  ticks = "outside"
)

#graph height
plot_height <- 600

#margin dimensions
plot_margin <- list(
  l = 90, r = 60, b = 170, t = 90
)

#line and marker styling
line_style <- list(
  width = 3
)

marker_style <- list(
  size = 12
)

font_style <- list(
  size = 13
)

#legend styling
legend_style <- list(
  x = 1,
  y = 0.8,
  bgcolor = "rgba(255, 255, 255, 0)",
  bordercolor = "rgba(255, 255, 255, 0)"
)

#mode bar buttons to remove
modebar_buttons_remove <- c(
  "select2d",
  "lasso2d",
  "toggleSpikelines",
  "hoverCompareCartesian",
  "hoverClosestCartesian"
)
