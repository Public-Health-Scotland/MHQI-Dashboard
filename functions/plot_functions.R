### This script contains functions and repeated chunks of code used in various 
### graphs to reduce the app size.


### [ Repeated Code Chunks ] ----

# Buttons to remove from plotly plots
bttn_remove <-  list(
  'select2d',
  'lasso2d',
  'zoomIn2d',
  'zoomOut2d',
  'autoScale2d',
  'toggleSpikelines',
  'hoverCompareCartesian',
  'hoverClosestCartesian'
)


### [ Functions ] ----

## PHS colour spinner ----

phs_spinner <- function(plot_name){
  withSpinner(
    plotlyOutput(plot_name, height = 600, width = "100%"),
    type = 8, size = 0.7,
    color = "#AF69A9", # color.background = "#E1C7DF",
    caption = "Loading...",
    hide.ui = FALSE
  )
}

## No Data function ----
# Function defining what is shown when there is no data to be presented:

noDataPlot <- function(line_colour){

  noDataPlot_text <- list(
  x = 5, 
  y = 2, 
  font = list(color = line_colour, size = 20),
  text = paste0("No discharges found for these selections."),
  xref = "x", 
  yref = "y",  
  showarrow = FALSE
)

# Visualise an empty graph with the above message in the middle.

plot_ly() %>% 
  layout(annotations = noDataPlot_text, 
         yaxis = list(showline = FALSE, 
                      showticklabels = FALSE, 
                      showgrid = FALSE), 
         xaxis = list(showline = FALSE, 
                      showticklabels = FALSE, 
                      showgrid = FALSE)) %>%  
  config(displayModeBar = FALSE,
         displaylogo = F, editable = F)

}

### Scatter Line Plot Function ----
# Aesthetic attributes for line graphs

phs_scatterPlot <- function(plot_data, # Graph reactive ouput
                            x_var, # variable on x axis
                            y_var, # variable on y axis
                            tooltip, # tooltip object name
                            line_var # line variable name
                            )
  {

plotly(
    data = plot_data(),
    x = ~x_var, y = ~y_var, 
    text = tooltip, hoverinfo = "text",
    color = ~line_var,
    colors = c("#0078D4", "#3393DD", "#80BCEA", "#B3D7F2"), # line colours
    type = 'scatter', mode = 'lines+markers',
    # width = 600, height = 300,
    line = list(width = 3),
    linetype = ~line_var,
    linetypes = c("solid", "dot", "solid", "dot"),
    symbol = ~line_var,
    symbols = c("circle", "square", "triangle-up", "triangle_down"),
    marker = list(size = 12),
    name = ~str_wrap(line_var, 19))
    
}
