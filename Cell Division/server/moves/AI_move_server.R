# add AI moves to the board
observeEvent(c(rv$player, input$player_mode, input$play_again), {
  
  
  # if it's A.I.'s turn
  if (input$player_mode=="1" && rv$player=="2" ) {
    # initialize things on first click    
    if (is.null(rv$open_pos)) { rv <- on_first_click(rv, type) }
    
    # get move
    if (length(rv$open_pos)<=1) { # only one move (sample gives error)
      if (length(rv$open_pos)==0) { return() } # return if no moves
      ind0 <- rv$open_pos
    } else {
      player <- as.numeric(rv$player)
      
      # apply gravity if neccesary
      if (type=="petri_game") { moves <- rv$open_pos }
      else {
        
        # get rows and columns with respect to no margin
        rows <- ((rv$open_pos-1) %% (rv$h+4)) - 1
        cols <- floor((rv$open_pos-1) / (rv$h+4)) - 1
        
        # get the lowest open rows (assuming open_pos is sorted)
        inds <- which(diff(c(0, cols)) >0)
        moves <- sub2ind(rows[inds], cols[inds], rv$h)
      }
      
      # calcualte the difficulty of AI (value of a state)
      if (input$adaptive=="1") {
        # get the easy and hard opponent's heuristic
        easy_value <- rv$overlap[[2]][moves] + 
          0.01*rv$centrality[moves]
        hard_value <- score_calc(rv$overlap[[2]][moves],
                            rv$interlap[[2]][moves],
                            rv$extensions[[2]][moves],
                            rv$lone_cell[[2]][moves]) + 
          0.75 * score_calc(rv$overlap[[1]][moves],
                            rv$interlap[[1]][moves],
                            rv$extensions[[1]][moves],
                            rv$lone_cell[[1]][moves]) + 
          0.5*rv$openness[moves] +
          0.01*rv$centrality[moves]
        
        
        # apply within game adaptivity
        score_diff <- diff(rv$score_traj[rv$timestep + 1:0]) # your score - AI score
        alpha <- 0.01*min(max(input$skill + score_diff, 1), 100) # weighting
        value <- alpha*hard_value/max(hard_value) + (1-alpha)*easy_value/max(easy_value)
        
      } else {
        if (input$difficulty=="1") {
          # easy
          value <- rv$overlap[[2]][moves] 
            0.01*rv$centrality[moves]
        } else if (input$difficulty=="2") {
          # medium
          value <- score_calc(rv$overlap[[2]][moves],
                              rv$interlap[[2]][moves],
                              rv$extensions[[2]][moves],
                              rv$lone_cell[[2]][moves]) + 
            0.01*rv$centrality[moves]
        } else  {
          # hard
          value <- score_calc(rv$overlap[[2]][moves],
                              rv$interlap[[2]][moves],
                              rv$extensions[[2]][moves],
                              rv$lone_cell[[2]][moves]) + 
            0.75 * score_calc(rv$overlap[[1]][moves],
                              rv$interlap[[1]][moves],
                              rv$extensions[[1]][moves],
                              rv$lone_cell[[1]][moves]) + 
            0.1*rv$openness[moves] +
            0.01*rv$centrality[moves]
        }        
      }
      # get most valuable move
      ind0 <- moves[which.max(value)[1]]
    }
    
    # implement move
    rv <- implement_move(rv, ind0)
  }
})