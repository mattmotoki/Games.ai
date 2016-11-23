# add AI moves to the board
observeEvent(c(rv$player, input$player_mode, input$play_again, input$first_move), {
  
  
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
      
      # lookup feature vectors
      features <- cbind(
        score_calc(rv$overlap[[2]][moves], rv$interlap[[2]][moves], rv$extensions[[2]][moves], rv$lone_cell[[2]][moves]),
        score_calc(rv$overlap[[1]][moves], rv$interlap[[1]][moves], rv$extensions[[1]][moves], rv$lone_cell[[1]][moves]),
        rv$openness[moves],
        rv$centrality[moves]
      )
      
      # caluculate the value of the feature vectors
      easy_coef <- c(10, 5, 0, 0)
      hard_coef <- c(2, 2, 1, 1)
      if (input$adaptive=="1") {
          score_diff <- diff(rv$score_traj[rv$timestep + 1:0]) # your score - AI score
          alpha <- 0.01*min(max(input$skill + score_diff, 1), 100) # weighting
          value <- features %*% (alpha*hard_coef + (1-alpha)*easy_coef)
      } else {
        if (input$difficulty=="1") {
          value <- features %*% easy_coef
        } 
        else if (input$difficulty=="2") {
          value <- features %*% (easy_coef + hard_coef)/2
        }
        else if (input$difficulty=="3") {
          value <- features %*% hard_coef
        }
      }

      # get most valuable move
      ind0 <- moves[which.max(value)[1]]
    }
    
    # implement move
    rv <- implement_move(rv, ind0)
  }
})