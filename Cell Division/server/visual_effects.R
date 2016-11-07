#-----------
# bottom display of main panel (help text and game buttons)
hide("game_over_buttons")
hide("game_play_buttons")
observeEvent(rv$timestep, {
  is_start <- (rv$timestep==0)
  is_over <- (rv$timestep==rv$plot_params$n_cells)
  
  toggle("help_text", condition = is_start, anim=TRUE) 
  toggle("game_over_buttons", condition = (!is_start) && is_over, anim=TRUE)
  toggle("game_play_buttons", condition = (!is_start) && (!is_over), anim=TRUE)
  
})


#-----------
# section folding settings
observeEvent(input$board_size_link, toggle("board_size_section", anim=TRUE))
observeEvent(input$player_options_link, toggle("player_options_section", anim=TRUE))
observeEvent(input$visual_contols_link, toggle("visual_contols_section", anim=TRUE))

#-----------
# display settings for adaptive or fixed difficulty
observeEvent(input$adaptive, {
  toggle("difficulty", condition = (input$adaptive=="0"), anim = TRUE)
  toggle("skill", condition = (input$adaptive=="1"), anim = TRUE)
})

