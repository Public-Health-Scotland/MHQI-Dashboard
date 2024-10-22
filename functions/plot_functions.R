### Functions used in plots throughout the app

## PHS colour spinner ----

phs_spinner <- function(plot_name){
  withSpinner(
    plotlyOutput(plot_name, width = "100%"),
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
    line = list(width = 2),
    linetype = ~line_var,
    linetypes = c("solid", "dash"),
    marker = list(size = 8),
    name = ~str_wrap(line_var, 19))
    
}
