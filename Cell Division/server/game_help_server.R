#-----------
# display settings
observeEvent(rv$timestep, {
  is_start <- (rv$timestep==0)
  is_over <- (rv$timestep==rv$plot_params$n_cells)

  toggle("game_help_text", condition = is_start, anim=TRUE) 
  toggle("game_over_buttons", condition = (!is_start) && is_over, anim=TRUE)
  toggle("game_play_buttons", condition = (!is_start) && (!is_over), anim=TRUE)
  
})

#-----------
# Game help text
output$game_help_text <- renderUI({
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

