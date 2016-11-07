# Game help text
output$help_text <- renderUI({
  if (rv$timestep==0) {
    if (rv$timestep==0) { 
      if (type=="petri_game") { 
        help_text <- "Click anywhere in the grid to place your move."
      }
      else { 
        help_text <- "Click in any column to place your move in the bottom row (gravity applies)."
      }
    }
    p(help_text, style="color: #C43B5E;")      
  } else {p("")}
})

