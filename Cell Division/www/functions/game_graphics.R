
#-----------------
# map the connection trajectory to squares and lines
add_player_moves <- function(connection_traj, p, h, margin_size=2) {
  # extract player connections
  connects <- connection_traj[player==p, .(ind0, ind)]    
  
  # convert ind0 to no margin row0 and col0
  row0 = ((connects$ind0-1) %% (h+4)) + 1-margin_size
  col0 = floor((connects$ind0-1) / (h+4)) + 1-margin_size
  
  # plot current moves
  rect(col0, row0, col0+1, row0+1,
       col=ifelse(p==1,"springgreen2", "orangered2"), #"#3BC4A1", "#C43B5E"
       lty=3, border=NA)
  
  # convert ind to no margin row and col
  row = ((connects$ind -1) %% (h+4)) + 1-margin_size
  col = floor((connects$ind -1) / (h+4)) + 1-margin_size
  
  # plot connections
  lines(
    0.5*c( rbind(3*col0-col, 3*col-col0, NA) + 1 ),
    0.5*c( rbind(3*row0-row, 3*row-row0, NA) + 1 ),
    col=ifelse(p==1,"springgreen4", "orangered4")
  )
}


#-----------------
# plot moves on the board
plot_board <- function(params, connection_traj, h) {
  
  # blank canvas
  par(mar=c(0,0,0,0), bg="NA")
  plot(1, type="n", axes = FALSE, asp=1,
       yaxs="i", xaxs="i", xlab = "", ylab = "",
       xlim=params$box_lim_x, ylim=params$box_lim_y
  )
  
  # fill in the board
  polygon(params$fill_x, params$fill_y, col = params$fill_color, border = NA)
  
  # plot moves and connections here
  if (!is.null(connection_traj)) {
    add_player_moves(connection_traj, 1, h)
    add_player_moves(connection_traj, 2, h)
  }

  # add outline, overlay, and grid
  lines(params$outline_x, params$outline_y, lwd=params$outline_width)
  lines(params$overlay_x, params$overlay_y, lwd=params$overlay_width)
  lines(params$grid_x, params$grid_y, lwd=1.5, lty=3)
}



