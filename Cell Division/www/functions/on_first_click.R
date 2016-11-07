## These are operations/functions that should take 
## place only after h and w have been finalized; 
## that is, at the first click.

on_first_click <- function(rv, type) {
  
  #----------
  # auxiliary
  rv$adj_ind <- (rep(c(-1,0,1), 3) + (rv$h+4)*rep(0:2, each=3) - (rv$h+4))[-5]
  
  #----------
  # time series
  rv$score_traj <- rep(0, rv$h*rv$w + 2)
  rv$connection_traj <- data.table(
    ind0 = integer(), 
    ind = integer(),
    player = integer(),
    timestep = integer()
  )
  
  #----------
  # calculate open positions and create board 
  
  # make blank board (no margin)
  rv$board <- matrix(-Inf, rv$h+4, rv$w+4)

  # calculate feasible moves
  if (type=="petri_game") {

    rv$open_pos <- with(rv$plot_params, {
      keep <- !(is.na(grid_x) | is.na(grid_y))
      top <- grid_y[keep][seq(1, sum(keep), 2)]-1
      bot <- grid_y[keep][seq(2, sum(keep), 2)]
      left_open_pos <- do.call("c", lapply( 1:(ceiling(rv$w/2) ), function(k) sub2ind(bot[k]:top[k], k, rv$h) ) )
      right_open_pos <- do.call("c", lapply( (ceiling(rv$w/2)+2 ):(rv$w+1), function(k) sub2ind(bot[k]:top[k], k-1, rv$h) ) )
      c(left_open_pos, right_open_pos)
    })

  } else if (type=="flask_game") {
    rv$open_pos <- with(rv$plot_params, {
      keep <- !(is.na(grid_x) | is.na(grid_y))
      top <- grid_y[keep][seq(2, sum(keep), 2)]-1
      left_open_pos <- do.call("c", lapply( 1:(rv$w/2), function(k) sub2ind(1:top[k], k, rv$h) ) )
      right_open_pos <- do.call("c", lapply( (rv$w/2+2):(rv$w+1), function(k) sub2ind(1:top[k], k-1, rv$h) ) )
      sort(c(left_open_pos, right_open_pos))
    })
  } else {
    rv$open_pos <- sort(sub2ind( rep(1:rv$h, each=rv$w), rep(1:rv$w, rv$h), rv$h))
  }
  
  # update board
  rv$board[rv$open_pos] <- 0
  
  #----------
  # score, extensions, lone_cell, interlap, overlap
  rv$board -> rv$score ->
    rv$extensions[[1]] -> rv$extensions[[2]] ->
    rv$lone_cell[[1]] -> rv$lone_cell[[2]] ->
    rv$interlap[[1]] -> rv$interlap[[2]] ->
    rv$overlap[[1]] -> rv$overlap[[2]] 
  
  
  #----------
  # initialize openness with centrality
  rv$openness <- 0.01/matrix(
    abs(rep(1:(rv$h+4),(rv$w+4)) - ((rv$h+4)+1)/2) + abs(rep(1:(rv$w+4), each=(rv$h+4)) - ((rv$w+4)+1)/2),
    (rv$h+4), (rv$w+4))
  
  # interatively calculate openness 
  for (ind in rv$open_pos) { rv$openness[rv$adj_vec+ind] <- rv$openness[rv$adj_vec+ind] + 1 }
  
  # # get magin indices
  # rv$margin <- which(rv$board==-Inf)
  rv 
}
