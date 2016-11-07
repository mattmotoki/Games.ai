# first move radio buttons
output$first_move_ui <- renderUI({
  ns <- session$ns
  new_choices <- list("1", "2")
  names(new_choices) <- rv$playernames  
  radioButtons(ns("first_move"), "First Move", new_choices, selected = isolate(rv$player)) 
}) 