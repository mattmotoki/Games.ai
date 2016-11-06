reset_rv <- function(rv, first_move) {
  if (is.null(first_move)) {return(rv)}
  
  rv$timestep <- 0
  rv$open_pos <- NULL
  rv$player <- first_move
  rv$connection_traj <- NULL

  return(rv)
}


