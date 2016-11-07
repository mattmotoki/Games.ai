# change player mode
observeEvent(input$player_mode, {
  
  # reset first move
  if (!is.null(input$first_move)) { rv$player <- input$first_move }
  
  # update player names
  if (input$player_mode=="1") { rv$playernames <- c("You", "A.I.") }
  else { rv$playernames <- c("Player 1", "Player 2") }
})

# swtich turns (switch first_move)
observeEvent(input$switch_turns, {
  updateRadioButtons(session, "first_move", selected = as.character(1+(input$first_move=="1")))
})

