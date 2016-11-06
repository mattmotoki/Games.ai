#------------
# Implement a Move
implement_move <- function(rv, ind0) {
  
  # convert player string in to numeric
  player <- as.numeric(rv$player)

  # update open positions
  rv$open_pos <- rv$open_pos[rv$open_pos != ind0]
  
  # update timestep
  timestep <- rv$timestep + 1
  rv$timestep <- timestep
  
  # update decision trajectory
  rv$connection_traj <- rbind(rv$connection_traj, list(ind0, ind0, player, timestep))

  #update board
  rv$board[ind0] <- player
  
  
  # update score
  rv$score_traj[timestep+2] <- rv$score_traj[timestep] + 
    score_calc(rv$overlap[[player]][ind0],
               rv$interlap[[player]][ind0],
               rv$extensions[[player]][ind0],
               rv$lone_cell[[player]][ind0])
  
  # update connections (if any)
  outline <- intersect(rv$adj_ind + ind0, rv$open_pos)
  # line_color <- ifelse(player==1, "springgreen4", "orangered4") # "", ""
  if (rv$overlap[[player]][ind0]>0) {
    # set lone_cell
    rv$lone_cell[[player]][ind0] <- -Inf
    
    connections <- rv$adj_ind[which(rv$board[rv$adj_ind+ind0] == player)] + ind0
    for (ind in connections) { 
      
      # update extension
      ind_diff <- ind - ind0
      ext_inds <- c(-1, 2)*ind_diff + ind0
      rv$extensions[[player]][ext_inds] <- rv$extensions[[player]][ext_inds] + 1 
      
      # update connection trajectory
      rv$connection_traj <- rbind(rv$connection_traj, list(ind0, ind, player, timestep))
      # rv$connection_traj[1:2 + 3*(timestep-1), player] <- c(ind, ind0)
      
      # reduce lone_cell
      if (rv$lone_cell[[player]][ind] == Inf) {
        rv$lone_cell[[player]][ind] <- -Inf
        rv$lone_cell[[player]][rv$adj_ind+ind] <- rv$lone_cell[[player]][rv$adj_ind+ind] - 1        
      }
    }
  } else { 
    # update lone_cell
    rv$lone_cell[[player]][ind0] <- Inf
    rv$lone_cell[[player]][outline] <- rv$lone_cell[[player]][outline] + 1
  }
  
  
  # update interlap
  inline <- rv$adj_ind[which(rv$board[2*rv$adj_ind+ind0] == player)] + ind0
  rv$interlap[[player]][inline] <- rv$interlap[[player]][inline] + 1
  
  # update overlap
  rv$overlap[[player]][outline] <- rv$overlap[[player]][outline] + 1
  
  # update openness 
  rv$openness[outline] <- rv$openness[outline]-1
  
  # update infeasible positions 
  -Inf ->
    rv$lone_cell[[(player==1)+1]][ind0] -> 
    rv$extensions[[1]][ind0] -> rv$extensions[[2]][ind0] ->
    rv$interlap[[1]][ind0] -> rv$interlap[[2]][ind0] -> 
    rv$overlap[[1]][ind0] -> rv$overlap[[2]][ind0] -> 
    rv$openness[ind0] 
  

  # # update score matrix
  # rv$score <- matrix(1, dim(rv$board)[1], dim(rv$board)[2])
  # rv$score
  
  # switch players
  rv$player <- as.character((player==1)+1)
 
  return(rv )
}
