# No Data function ----
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
