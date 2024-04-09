### [Navigation page buttons] ----------------------------------------------------
# Uses objects which are updated in 'constants.R' file

## [Sidebar Buttons] ------------------------------
# Timely ----
observeEvent(input$T1_button, {
  updateTabItems(session, "tabs", T1_tab)
})
observeEvent(input$T2_button, {
  updateTabItems(session, "tabs", T2_tab)
})
observeEvent(input$T3_button, {
  updateTabItems(session, "tabs", T3_tab)
})

# Safe ----
observeEvent(input$S1_button, {
  updateTabItems(session, "tabs", S1_tab)
})
observeEvent(input$S2_button, {
  updateTabItems(session, "tabs", S2_tab)
})
observeEvent(input$S5_button, {
  updateTabItems(session, "tabs", S5_tab)
})

# Person Centred ----
observeEvent(input$P1_button, {
  updateTabItems(session, "tabs", P1_tab)
})
observeEvent(input$P2_button, {
  updateTabItems(session, "tabs", P2_tab)
})
observeEvent(input$P3_button, {
  updateTabItems(session, "tabs", P3_tab)
})
observeEvent(input$P4_button, {
  updateTabItems(session, "tabs", P4_tab)
})

# Effective ----
observeEvent(input$E1_button, {
  updateTabItems(session, "tabs", E1_tab)
})

# Efficient ----
observeEvent(input$EF1_button, {
  updateTabItems(session, "tabs", EF1_tab)
})
observeEvent(input$EF2_button, {
  updateTabItems(session, "tabs", EF2_tab)
})
observeEvent(input$EF3_button, {
  updateTabItems(session, "tabs", EF3_tab)
})
observeEvent(input$EF4_button, {
  updateTabItems(session, "tabs", EF4_tab)
})
observeEvent(input$EF5_button, {
  updateTabItems(session, "tabs", EF5_tab)
})

# Equitable ----
observeEvent(input$EQ1_button, {
  updateTabItems(session, "tabs", EQ1_tab)
})
observeEvent(input$EQ2_button, {
  updateTabItems(session, "tabs", EQ2_tab)
})
observeEvent(input$EQ4_button, {
  updateTabItems(session, "tabs", EQ4_tab)
})


## [Scotland Hub buttons] ------------------------------
# Timely ----
observeEvent(input$T1_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$T2_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$T3_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})

# Safe ----
observeEvent(input$S1_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$S2_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$S5_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})

# Person Centred ----
observeEvent(input$P1_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$P2_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$P3_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$P4_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})

# Effective ----
observeEvent(input$E1_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})

# Efficient ----
observeEvent(input$EF1_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$EF2_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$EF3_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$EF4_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$EF5_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})

# Equitable ----
observeEvent(input$EQ1_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$EQ2_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})
observeEvent(input$EQ4_scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})


## [Next page buttons] ------------------------------

# Timely ----
observeEvent(input$T1_nextButton, {
  updateTabItems(session, "tabs", T1_tab)
})
observeEvent(input$T2_nextButton, {
  updateTabItems(session, "tabs", T2_tab)
})
observeEvent(input$T3_nextButton, {
  updateTabItems(session, "tabs", T3_tab)
})

# Safe ----
observeEvent(input$S1_nextButton, {
  updateTabItems(session, "tabs", S1_tab)
})
observeEvent(input$S2_nextButton, {
  updateTabItems(session, "tabs", S2_tab)
})
observeEvent(input$S5_nextButton, {
  updateTabItems(session, "tabs", S5_tab)
})

# Person Centred ----
observeEvent(input$P1_nextButton, {
  updateTabItems(session, "tabs", P1_tab)
})
observeEvent(input$P2_nextButton, {
  updateTabItems(session, "tabs", P2_tab)
})
observeEvent(input$P3_nextButton, {
  updateTabItems(session, "tabs", P3_tab)
})
observeEvent(input$P4_nextButton, {
  updateTabItems(session, "tabs", P4_tab)
})

# Effective ----
observeEvent(input$E1_nextButton, {
  updateTabItems(session, "tabs", E1_tab)
})

# Efficient ----
observeEvent(input$EF1_nextButton, {
  updateTabItems(session, "tabs", EF1_tab)
})
observeEvent(input$EF2_nextButton, {
  updateTabItems(session, "tabs", EF2_tab)
})
observeEvent(input$EF3_nextButton, {
  updateTabItems(session, "tabs", EF3_tab)
})
observeEvent(input$EF4_nextButton, {
  updateTabItems(session, "tabs", EF4_tab)
})
observeEvent(input$EF5_nextButton, {
  updateTabItems(session, "tabs", EF5_tab)
})

# Equitable ----
observeEvent(input$EQ1_nextButton, {
  updateTabItems(session, "tabs", EQ1_tab)
})
observeEvent(input$EQ2_nextButton, {
  updateTabItems(session, "tabs", EQ2_tab)
})
observeEvent(input$EQ4_nextButton, {
  updateTabItems(session, "tabs", EQ4_tab)
})


# [Previous page buttons] ------------------------------

# Timely ----
observeEvent(input$T1_prevButton, {
  updateTabItems(session, "tabs", T1_tab)
})
observeEvent(input$T2_prevButton, {
  updateTabItems(session, "tabs", T2_tab)
})
observeEvent(input$T3_prevButton, {
  updateTabItems(session, "tabs", T3_tab)
})

# Safe ----
observeEvent(input$S1_prevButton, {
  updateTabItems(session, "tabs", S1_tab)
})
observeEvent(input$S2_prevButton, {
  updateTabItems(session, "tabs", S2_tab)
})
observeEvent(input$S5_prevButton, {
  updateTabItems(session, "tabs", S5_tab)
})


# Person Centred ----
observeEvent(input$P1_prevButton, {
  updateTabItems(session, "tabs", P1_tab)
})
observeEvent(input$P2_prevButton, {
  updateTabItems(session, "tabs", P2_tab)
})
observeEvent(input$P3_prevButton, {
  updateTabItems(session, "tabs", P3_tab)
})
observeEvent(input$P4_prevButton, {
  updateTabItems(session, "tabs", P4_tab)
})

# Effective ----
observeEvent(input$E1_prevButton, {
  updateTabItems(session, "tabs", E1_tab)
})

# Efficient ----
observeEvent(input$EF1_prevButton, {
  updateTabItems(session, "tabs", EF1_tab)
})
observeEvent(input$EF2_prevButton, {
  updateTabItems(session, "tabs", EF2_tab)
})
observeEvent(input$EF3_prevButton, {
  updateTabItems(session, "tabs", EF3_tab)
})
observeEvent(input$EF4_prevButton, {
  updateTabItems(session, "tabs", EF4_tab)
})
observeEvent(input$EF5_prevButton, {
  updateTabItems(session, "tabs", EF5_tab)
})

# Equitable ----
observeEvent(input$EQ1_prevButton, {
  updateTabItems(session, "tabs", EQ1_tab)
})
observeEvent(input$EQ2_prevButton, {
  updateTabItems(session, "tabs", EQ2_tab)
})
observeEvent(input$EQ4_prevButton, {
  updateTabItems(session, "tabs", EQ4_tab)
})