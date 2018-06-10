# Undo a move
observeEvent(input$undo_move, { 
  rv <- remove_move(rv) 
  if (input$player_mode=="1") {rv <- remove_move(rv) }
})
