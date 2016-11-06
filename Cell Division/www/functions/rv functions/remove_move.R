#------------
# Remove a Move
remove_move <- function(rv) {
  if (rv$timestep==0) {
    print("You can't remove a move that hasn't been played.")
    return(rv)
  }
  
  # get the move played
  ind0 <- rv$connection_traj[timestep==max(timestep), ind0][1]
  
  # reduce score
  rv$score_traj[rv$timestep+2] <- 0
  
  # switch players
  rv$player <- as.character((rv$player=="1")+1)
  player <- as.numeric(rv$player)

  # decrement timestep
  rv$timestep <- rv$timestep - 1
  
  # remove last move from connection trajectory
  rv$connection_traj <- rv$connection_traj[timestep!=max(timestep)]
  
  # make ind0 open
  rv$open_pos <- sort(c(rv$open_pos, ind0))
  
  # remove move ind0 from the board
  rv$board[ind0] <- 0
  
  # remove overlap
  outline <-rv$adj_ind + ind0
  rv$overlap[[player]][ind0] <- sum(rv$board[outline]==player)
  rv$overlap[[player]][outline] <- rv$overlap[[player]][outline] - 1
  
  
  # reset extensions
  rv$extensions[[player]][ind0] <- 0
  
  # remove connections
  line_color <- ifelse(player==1, "yellow", "black") # "springgreen4", "orangered4"
  if (rv$overlap[[player]][ind0]>0) {
    # reset lone_cell
    rv$lone_cell[[player]][ind0] <- 0
    
    connections <- rv$adj_ind[which(rv$board[rv$adj_ind+ind0] == player)] + ind0
    for (ind in connections) { 
      
      # recalculate extensions surrounding ind0
      ind_diff <- ind - ind0
      ext_inds <- c(-1, 2)*ind_diff + ind0
      rv$extensions[[player]][ext_inds] <- rv$extensions[[player]][ext_inds] - 1 
      
      # recalculate extensions at ind0
      if (rv$board[2*ind_diff + ind0]==player) {
        rv$extensions[[player]][ind0] <- rv$extensions[[player]][ind0] + 1           
      } 
      
      # check if connection with lone_cell
      if ( all(rv$board[rv$adj_ind + ind] != player)) {
        rv$lone_cell[[player]][ind] <- Inf
        rv$lone_cell[[player]][rv$adj_ind+ind] <- rv$lone_cell[[player]][rv$adj_ind+ind] + 1
      }
    }
  } else { 
    # remove lone_cell
    rv$lone_cell[[player]][ind0] <- 0
    rv$lone_cell[[player]][outline] <- rv$lone_cell[[player]][outline] - 1
  }
  
  # reset interlap
  rv$interlap[[player]][ind0] <- sum(
    rv$board[[player]][outline[1:4]]==player & rv$board[[player]][outline[8:5]]==player , na.rm = TRUE
  )
  inline <- rv$adj_ind[which(rv$board[2*rv$adj_ind+ind0] == player)] + ind0
  rv$interlap[[player]][inline] <- rv$interlap[[player]][inline] - 1
  
  
  # reset openness 
  rv$openness[ind0] <- sum(rv$board[outline]==0)
  rv$openness[outline] <- rv$openness[outline]+1
  

  #-------
  # Update Opposite player
  player <- (player==1)+1
  
  # remove overlap
  rv$overlap[[player]][ind0] <- sum(rv$board[outline]==player)
  
  # recalculate lone cells
  rv$lone_cell[[player]][ind0] <- sum(rv$lone_cell[[player]][outline]==Inf)
  
  # reset extensions
  rv$extensions[[player]][ind0] <- 0
  if (rv$overlap[[player]][ind0]>0) {
    
    connections <- rv$adj_ind[which(rv$board[rv$adj_ind+ind0] == player)] + ind0
    for (ind in connections) { 
      
      # recalculate extensions
      ind_diff <- ind - ind0
      if (rv$board[2*ind_diff + ind0]==player) {
        rv$extensions[[player]][ind0] <- rv$extensions[[player]][ind0] + 1           
      } 
    }
  }
  
  # reset interlap
  rv$interlap[[player]][ind0] <- sum(
    rv$board[[player]][outline[1:4]]==player & rv$board[[player]][outline[8:5]]==player , na.rm = TRUE
  )
  
  return(rv)
}