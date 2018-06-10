# Reset the reactive values (equivalent to removing all moves)
observeEvent(
  c(input$reset_button, input$player_mode, input$first_move,
    input$adaptive, input$difficulty, input$skill, input$reset_game, rv$plot_params), {
      
      rv$timestep <- 0
      rv$open_pos <- NULL
      rv$connection_traj <- NULL
      if (!is.null(input$first_move)) { rv$player <- input$first_move }
    }
)


observeEvent(input$play_again, {
  # update AI skill if necessary 
  if (input$player_mode=="1") {
    
    # get your score minus AI score
    score_diff <- diff(rv$score_traj[rv$timestep + 1:2]) # last player score - other score
    score_diff <- ifelse(rv$player=="2", 1, -1)*score_diff # negate score if AI was last
    
    # update skill by 0.5*score_diff if you lost and by score_diff if you won
    new_skill <- max(min(input$skill + floor(ifelse(score_diff<0, 0.5, 1)*score_diff), 100), 1)
    updateSliderInput(session, "skill", value = new_skill)
    
    # reset rvs just in case skill doesn't change
    rv$timestep <- 0
    rv$open_pos <- NULL
    rv$connection_traj <- NULL
    if (!is.null(input$first_move)) { rv$player <- input$first_move }
  }
})



# swtich turns (switch first_move)
observeEvent(input$switch_turns, {
  # update AI skill if necessary 
  if (input$player_mode=="1") {
    
    # get your score minus AI score
    score_diff <- diff(rv$score_traj[rv$timestep + 1:2]) # last player score - other score
    score_diff <- ifelse(rv$player=="1", 1, -1)
    
    # update skill by 0.5*score_diff if you lost and by score_diff if you won
    new_skill <- max(min(input$skill + floor(ifelse(score_diff<0, 0.5, 1)*score_diff), 100), 1)
    updateSliderInput(session, "skill", value = new_skill)
  }
  
  # switch first move
  updateRadioButtons(session, "first_move", selected = as.character(1+(input$first_move=="1")))
})



