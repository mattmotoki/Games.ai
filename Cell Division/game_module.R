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
  
  # Initialize Reactive Values
  source(file.path("www", "initial values", "initialize_rvs.R"),  local = TRUE)
  
  # Plot Output
  output$board_plot <- renderPlot(plot_board( rv$plot_params, rv$connection_traj, rv$h), res = 10)
  
  # Move Implementations:  
  #  user move, AI move, undo move, reset all moves
  for (f in dir(file.path("server", "moves"), full.names = TRUE)) { source(f, local = TRUE) }
  
  # Render Dynamic UI (server logic for all uiOutput): 
  #  info bar, board size controls, first move radio buttons
  for (f in dir(file.path("server", "render_dynamic_UI"), full.names = TRUE)) { source(f, local = TRUE) }
  
  # Game Options:
  #  board size, game help
  for (f in dir(file.path("server", "game_options"), full.names = TRUE)) { source(f, local = TRUE) }

  # Visual effects:
  #  bottom main panel display, sidebar panel section folding, AI difficulty settings
  source(file.path("server", "visual_effects.R"),  local = TRUE)
}