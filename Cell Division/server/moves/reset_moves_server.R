# Reset the reactive values
# equivalent to removing all moves
observeEvent(
  c(input$reset_button, input$play_again, input$player_mode, input$first_move,
    input$adaptive, input$difficulty, input$skill, input$reset_game, rv$plot_params), {
      rv <- reset_rv(rv, input$first_move)
    }
)
