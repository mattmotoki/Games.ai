gameUI <- function(id, tab_name, tab_icon) {
  ns <- NS(id)
  tabPanel(
    title = tab_name, icon = tab_icon, useShinyjs(),
    sidebarLayout(
      
      # Sidebar Panel:
      #  tutorial/about link, board controls, player settings, github link
      source(file.path("ui", "sidebar_panel_ui.R"), local = TRUE)$value,
      
      # Main Panel:
      #  info bar, board display, help text, game buttons
      source(file.path("ui", "main_panel_ui.R"), local = TRUE)$value
    )
  )
}


play_game <- function(input, output, session, type) {
  
  # initialize reactive values
  source(file.path("www", "initial values", "initialize_rvs.R"),  local = TRUE)
  
  # Game Options
  source(file.path("server", "sidebar_panel_server.R"),  local = TRUE)

  
  # Move Implementations:  
  #  user move, AI move, undo move, reset all moves
  for (f in dir(file.path("server", "moves"), full.names = TRUE)) { source(f, local = TRUE) }
  
  
  # Render Dynamic UI (server logic for all uiOutput): 
  #  info bar, 
  for (f in dir(file.path("server", "render_dynamic_UI"), full.names = TRUE)) { source(f, local = TRUE) }
  
  
  

  
  
  # swtich turns
  observeEvent(input$switch_turns, {
    updateRadioButtons(session, "first_move", selected = as.character(1+(input$first_move=="1")))
  })
  
  
  
  
  # Plot Output
  output$board_plot <- renderPlot(plot_board( rv$plot_params, rv$connection_traj, rv$h), res = 10)
  
  
  # # add user moves to the board
  # source(file.path("server", "user_move_server.R"),  local = TRUE)
  # 
  # # add A.I.'s moves to the board
  # source(file.path("server", "AI_move_server.R"),  local = TRUE)
  
  
  # Game Help
  source(file.path("server", "game_help_server.R"),  local = TRUE)
  
}




