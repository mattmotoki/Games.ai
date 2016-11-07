# add AI moves to the board
observeEvent(c(rv$player, input$player_mode), {


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
        # get value based on hard opponent's heuristic
        value <- score_calc(rv$overlap[[2]][moves],
                            rv$interlap[[2]][moves],
                            rv$extensions[[2]][moves],
                            rv$lone_cell[[2]][moves]) + 
          0.75 * score_calc(rv$overlap[[1]][moves],
                            rv$interlap[[1]][moves],
                            rv$extensions[[1]][moves],
                            rv$lone_cell[[1]][moves]) + 
          0.5*rv$openness[moves]
        
        # # within game adaptivity
        # play_move <- max(ceiling(0.01*(input$skill + rv$score_diff[1])*length(value)), 1)
        # value[order(value)[play_move]] <- max(value) + 1
        
      } else {
        if (input$difficulty=="1") {
          # easy

          value <- rv$openness[moves]
          value[which.min(moves)] <- 4*value[which.min(value)] 
        } else if (input$difficulty=="2") {
          # medium
          value <- rv$overlap[[1]][moves] + 0.5*rv$openness[moves]
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
            0.5*rv$openness[moves]
        }        
      }

      ind0 <- moves[which.max(value)[1]]
     
    }
    
    # implement move
    rv <- implement_move(rv, ind0)
  }
})