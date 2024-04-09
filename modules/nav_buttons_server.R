# [Navigation page buttons] ----------------------------------------------------
# Uses objects which are updated in 'constants.R' file

# # Hub ----
# observeEvent(input$scot_hub_button, {
#   updateTabItems(session, "tabs", scot_hub)
# })

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

# Equitable
observeEvent(input$EQ1_button, {
  updateTabItems(session, "tabs", EQ1_tab)
})
observeEvent(input$EQ2_button, {
  updateTabItems(session, "tabs", EQ2_tab)
})
observeEvent(input$EQ4_button, {
  updateTabItems(session, "tabs", EQ4_tab)
})



# Hub ----
observeEvent(input$scot_hub_button, {
  updateTabItems(session, "tabs", scot_hub)
})

# Next page buttons --------------------------

# Timely ----
observeEvent(input$T1_navButton, {
  updateTabItems(session, "tabs", T1_tab)
})
observeEvent(input$T2_navButton, {
  updateTabItems(session, "tabs", T2_tab)
})
observeEvent(input$T3_navButton, {
  updateTabItems(session, "tabs", T3_tab)
})

# Safe ----
observeEvent(input$S1_navButton, {
  updateTabItems(session, "tabs", S1_tab)
})
observeEvent(input$S2_navButton, {
  updateTabItems(session, "tabs", S2_tab)
})
observeEvent(input$S5_navButton, {
  updateTabItems(session, "tabs", S5_tab)
})


# Person Centred ----
observeEvent(input$P1_navButton, {
  updateTabItems(session, "tabs", P1_tab)
})
observeEvent(input$P2_navButton, {
  updateTabItems(session, "tabs", P2_tab)
})
observeEvent(input$P3_navButton, {
  updateTabItems(session, "tabs", P3_tab)
})
observeEvent(input$P4_navButton, {
  updateTabItems(session, "tabs", P4_tab)
})

# Effective ----
observeEvent(input$E1_navButton, {
  updateTabItems(session, "tabs", E1_tab)
})

# Efficient ----
observeEvent(input$EF1_navButton, {
  updateTabItems(session, "tabs", EF1_tab)
})
observeEvent(input$EF2_navButton, {
  updateTabItems(session, "tabs", EF2_tab)
})
observeEvent(input$EF3_navButton, {
  updateTabItems(session, "tabs", EF3_tab)
})
observeEvent(input$EF4_navButton, {
  updateTabItems(session, "tabs", EF4_tab)
})
observeEvent(input$EF5_navButton, {
  updateTabItems(session, "tabs", EF5_tab)
})

# Equitable ----
observeEvent(input$EQ1_navButton, {
  updateTabItems(session, "tabs", EQ1_tab)
})
observeEvent(input$EQ2_navButton, {
  updateTabItems(session, "tabs", EQ2_tab)
})
observeEvent(input$EQ4_navButton, {
  updateTabItems(session, "tabs", EQ4_tab)
})

# # 'Next Page' Buttons ----------------------------------------------------
# # Uses  objects which are updated in 'constants.R' file
# observeEvent(input$nextPage1, {
#   updateTabItems(session, "tabs", page2)
# })
# observeEvent(input$nextPage2, {
#   updateTabItems(session, "tabs", page3)
# })
# observeEvent(input$nextPage3, {
#   updateTabItems(session, "tabs", page4)
# })
# observeEvent(input$nextPage4, {
#   updateTabItems(session, "tabs", page5)
# })
# observeEvent(input$nextPage5, {
#   updateTabItems(session, "tabs", page6)
# })
# observeEvent(input$nextPage6, {
#   updateTabItems(session, "tabs", intro)
# })