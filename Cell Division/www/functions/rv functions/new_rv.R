new_rv <- function(type) {
  reactiveValues(
    
    # fundamental values
    h = switch(type, "petri_game" = 1, "beaker_game" = 5, "flask_game" = 8), 
    w = switch(type, "petri_game" = 4, "beaker_game" = 4, "flask_game" = 6), 
    plot_params = NULL,
    
    
    # display values
    timestep = 0,
    player = "1", 
    playernames = c("You", "A.I."), 
    
    
    # auxiliary values
    open_pos = NULL,    
    adj_ind = NULL,
    
    
    # time series (trajectories)
    score_traj = c(0, 0),
    connection_traj = NULL,
    
    
    # matrices
    board = NULL,
    score = NULL,
    openness = NULL,
    interlap = list(), 
    overlap = list(), 
    extensions = list(), 
    lone_cell = list()
  )
}