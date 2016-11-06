
#-----------------
# define plot parameters for beaker
new_beaker <- function(h, w) {
  
  #-------------
  # define the fill polygon of the beaker
  r_small <- 0.1
  r_large <- 1
  
  top_x <- c(w+1+r_large*cos(pi/3), 1-r_large*cos(pi/3))
  top_y <- rep(h+1+r_large*sin(pi/3), 2)
  
  theta <- seq(pi/3, 0, length=10)
  left_lip_x <- r_large*cos(theta) + 1-r_large
  left_lip_y <- r_large*sin(theta) + h+1
  
  left_side_x <- c(1, 1)
  left_side_y <- c(1+r_small, h+1)
  
  theta <- seq(pi, 1.5*pi, length=10)
  left_corner_x <- r_small*cos(theta) + 1+r_small
  left_corner_y <- r_small*sin(theta) + 1+r_small
  
  bottom_x <- c(1+r_small, w+1-r_small)
  bottom_y <- c(1, 1)
  
  theta <- seq(1.5*pi, 2*pi, length=10)
  right_corner_x <- r_small*cos(theta) + w+1-r_small
  right_corner_y <- r_small*sin(theta) + 1+r_small
  
  right_side_x <- c(w+1, w+1)
  right_side_y <- c(1+r_small, h+1)
  
  theta <- seq(pi, 2*pi/3, length=10)
  right_lip_x <- r_large*cos(theta) + w+1+r_large
  right_lip_y <- r_large*sin(theta) + h+1
  
  
  fill_x <- c(
    top_x, left_lip_x, left_side_x, 
    left_corner_x, bottom_x, right_corner_x,
    right_side_x, right_lip_x
  )
  
  fill_y <- c(
    top_y, left_lip_y, left_side_y, 
    left_corner_y, bottom_y, right_corner_y,
    right_side_y, right_lip_y
  )
  
  
  #-------------
  # define the outline
  outline_x <- (1 + 0.005*h/sqrt(h^2+w^2))*(fill_x - (w+2)/2) + (w+2)/2
  outline_y <- (1 + 0.005*w/sqrt(h^2+w^2))*(fill_y - (h+2.5)/2) + (h+2.5)/2
  
  #-------------
  # define the overlay
  overlay_x <- r_large*cos(pi/4)*c(1, -1) + c(0, w+2)
  overlay_y <- rep(r_large*sin(pi/4)+h+1, 2)
  
  
  #-------------
  # define the grid
  grid_x <- c(rep(1:(w+1), each=3), rep(c(1, w+1, NA), h+1))
  grid_y <- c(rep(c(1, h+1, NA), w+1), rep(1:(h+1), each=3))
  
  #-------------
  # combine paramaters into a list
  list(
    
    # set the limits of the plot
    box_lim_x = c(0, w+2),
    box_lim_y = c(0.5, h+2),
    
    # shape parameters
    fill_x = fill_x,
    fill_y = fill_y,
    fill_color = "aliceblue",
    
    # outline parameters
    outline_x =outline_x,
    outline_y =outline_y,
    outline_width = 6,
    
    # additional overlays
    overlay_x = overlay_x,
    overlay_y = overlay_y,
    overlay_width = 3,
    
    # grid lines
    grid_x = grid_x,
    grid_y = grid_y,
    
    # number of cells
    n_cells = w*h
  )
}
