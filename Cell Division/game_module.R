
gameUI <- function(id, tab_name, tab_icon) {
  ns <- NS(id)
  tabPanel(
    title = tab_name, icon = tab_icon, useShinyjs(),
    
    # load in the ui
    sidebarLayout(
      source(file.path("ui", "sidebar_panel_ui.R"), local = TRUE)$value,
      source(file.path("ui", "main_panel_ui.R"), local = TRUE)$value
    )
  )
}


play_game <- function(input, output, session, type) {
  
  
  # load external data
  source(file.path("www", "initial values", "initialize_rvs.R"),  local = TRUE)
  
  # sidebar panel server logic
  source(file.path("server", "sidebar_panel_server.R"),  local = TRUE)
  
  # create dynamic information display
  output$info_bar <-   renderUI({
    display_info_bar(rv$score_traj,
                     rv$timestep,
                     rv$player,
                     rv$playernames,
                     rv$plot_params$n_cells,
                     input$first_move
    )
  })
  
  
  # Reset the reactive values
  observeEvent(
    c(input$reset_button, input$play_again, input$player_mode, input$first_move,
      input$adaptive, input$difficulty, input$skill, input$reset_game, rv$plot_params), {
        rv <- reset_rv(rv, input$first_move)
      }
  )
  
  # Undo a move
  observeEvent(input$undo_move, { 
    rv <- remove_move(rv) 
    if (input$player_mode=="1") {rv <- remove_move(rv) }
  })
  
  
  # swtich turns
  observeEvent(input$switch_turns, {
    updateRadioButtons(session, "first_move", selected = as.character(1+(input$first_move=="1")))
  })
  

  
  
  # Plot Output
  output$board_plot <- renderPlot(plot_board( rv$plot_params, rv$connection_traj, rv$h), res = 10)
  
  
  # add user moves to the board
  source(file.path("server", "user_move_server.R"),  local = TRUE)
  
  # add A.I.'s moves to the board
  source(file.path("server", "AI_move_server.R"),  local = TRUE)
  

  # Game Help
  source(file.path("server", "game_help_server.R"),  local = TRUE)
  
}




