#-----------------
# define plot parameters for petri
new_petri <- function(h, w) {
  if (h > sqrt(1+2*w)) {stop("h is too large")}
  
  #-------------
  # define the petri dish
  center <- 1+w
  r <- sqrt(w^2+h^2)
  theta <- seq(0, 2*pi, length=100)
  fill_x <- r*cos(theta) + center
  fill_y <- r*sin(theta) + center
  
  #-------------
  # define the outline
  outline_x <- (1 + 0.005*h/sqrt(h^2+w^2))*(fill_x - center) + center
  outline_y <- (1 + 0.005*w/sqrt(h^2+w^2))*(fill_y - center) + center
  
  #-------------
  # define the grid
  x <- 1:(2*w+1)
  y <- floor( sqrt( r^2 - (x-center)^2 ) + 0.000001 - (w%%1)) + (w%%1)
  
  # correct singular cells
  if ((w%%1)==0) { if ( y[w+1] != y[w]) {y[w+1] <- y[w]}  }
  else {
    if ( y[ceiling(center)] != y[floor(center)]) {
      y[ceiling(center)] <- y[floor(center)] <- max(y[ceiling(center)],  y[floor(center)])
      } 
  }
  
  
  grid_x <- c(rbind(x, x, NA), rbind(center+y, center-y, NA))
  grid_y <- c(rbind(center+y, center-y, NA), rbind(x, x, NA))
  
  
  #-------------
  # combine paramaters into a list
  margin <- 1.05*r-w
  list(
    # opposite and adjacent sides 
    adj = w,
    opp = h,
      
    # set the limits of the plot
    box_lim_x = c(1-margin, 2*w+1+margin),
    box_lim_y = c(1-margin, 2*w+1+r-w), 
    
    # shape parameters
    fill_x = fill_x,
    fill_y = fill_y,
    fill_color = "paleturquoise1",
    
    # outline parameters
    outline_x =outline_x,
    outline_y =outline_y,
    outline_width = 4,
    
    # additional overlays
    overlay_x = NULL,
    overlay_y = NULL,
    overlay_width = NULL,
    
    # grid lines
    grid_x = grid_x,
    grid_y = grid_y,
    
    # number of cells
    n_cells = 2*sum(y[-(w+1)])
    
  )
}


# calculate a data.table of petri sizes and cell count
petri_dims <- data.table(opp = integer(), adj = integer(), r = numeric(), n_cells = integer())
for (w in 2:6) {
  for (h in 1:floor(sqrt(1+2*w))) {
    # offset defines even/odd number of cells
    for (offset in c(0, 0.5)) {
      center <- 1+w-offset
      r <- sqrt((w-offset)^2 + (h-offset)^2)
      x <- 1:(2*(w-offset) + 1)
      y <- floor( sqrt( r^2 - (x-center)^2 ) + 0.000001 - ((w-offset)%%1) ) + ((w-offset)%%1)
      petri_dims <- rbind(petri_dims, list(h-offset, w-offset, r, 2*sum(y[-(w+1)])))      
    }
  }
}
setorder(petri_dims, "n_cells")
rm(w, h, center, r, x, y)



