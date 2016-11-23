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
  observe({
    # don't plot player's move when playing against AI
    if (rv$player=="1" && input$player_mode=="1" && rv$timestep>1) {return()}
    output$board_plot <- renderPlot(plot_board( rv$plot_params, rv$connection_traj, rv$h), res = 10)
  })

  # Load Server Files:
  #  board size, game help
  #  user move, AI move, undo move, reset all moves
  #  info bar, board size controls, first move radio buttons
  #  bottom main panel display, sidebar panel section folding, AI difficulty settings
  for (f in dir("server", full.names = TRUE, recursive=TRUE)) { source(f, local = TRUE) }
  

}