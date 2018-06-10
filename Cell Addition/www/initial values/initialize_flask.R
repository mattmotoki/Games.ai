
#-----------------
# define plot parameters for flask
new_flask <- function(neck_h, base_w) {
  
  #-------------
  # define the fill polygon of the flask
  neck_w <- 2
  base_h <- base_w/2
  h <- base_h + neck_h
  w <- base_w + neck_w-2
  r_small <- 0.1
  
  top_x <- c(cos(pi/3) - 1 - neck_w/2, 0) 
  top_y <- rep(neck_h+1+sin(pi/3), 2) +base_h
  
  theta <- seq(pi/3, 0, length=10)
  lip_x <- cos(theta) - 1 - neck_w/2
  lip_y <- sin(theta) + base_h + neck_h + 1
  
  neck_side_x <- c(-neck_w/2, -neck_w/2)
  neck_side_y <- c(neck_h+1, 1 + 2*sin(pi/4)) + base_h
  
  theta <- seq(0, -pi/4, length=10)
  neck_to_base_x <- cos(theta) - 1 - neck_w/2
  neck_to_base_y <- sin(theta) + 1 + 2*sin(pi/4) + base_h
  
  base_side_x <- c( cos(-pi/4) - 1, 0.5 - base_w/2) - neck_w/2
  base_side_y <- c( sin(-pi/4) + 1 + 2*sin(pi/4) + base_h, 2.5)
  
  
  theta <- seq(3*pi/4, pi, length=10)
  base_to_bot_x <- cos(theta) + cos(-pi/4) -0.5 - (base_w + neck_w-2)/2
  base_to_bot_y <- sin(theta) + sin(-pi/4) + 2.5
  
  
  theta <- seq(pi, 3*pi/2, length=10)
  bot_corner_x <- (cos(theta)+1)*sin(pi/4) -1.5 + sin(pi/4) - (base_w + neck_w-2)/2
  bot_corner_y <- sin(theta)*sin(pi/4) - sin(-pi/4) + 1
  
  
  
  left_flask_x <- c(
    top_x, lip_x, neck_side_x,
    neck_to_base_x, base_side_x,
    base_to_bot_x, bot_corner_x
  )
  
  left_flask_y <- c(
    top_y, lip_y, neck_side_y,
    neck_to_base_y, base_side_y,
    base_to_bot_y, bot_corner_y
  )
  
  fill_x <- c(left_flask_x, -rev(left_flask_x)) + base_w/2 + 1
  fill_y <- c(left_flask_y,  rev(left_flask_y))
  
  
  #-------------
  # define the outline
  outline_x <- (1 + 0.005*h/sqrt(h^2+base_w^2))*(fill_x - (base_w+2)/2) + (base_w+2)/2
  outline_y <- (1 + 0.005*base_w/sqrt(h^2+base_w^2))*(fill_y - (h+2.5)/2) + (h+2.5)/2
  
  
  #-------------
  # define the overlay
  overlay_x <- cos(pi/4)*c(1, -1) + c(-neck_w/2-1, neck_w/2+1) + w/2 + 1
  overlay_y <- rep(sin(pi/4)+h+1, 2)
  
  
  #-------------
  # define the grid
  grid_x <- c(
    # vertical
    rbind(1:(w+1), 1:(w+1), NA),
    # horizontal
    rbind(
      c(1, 1, 1:(base_w/2), rep(base_w/2, neck_h-1)),
      2 + w - c(1, 1, 1:(base_w/2), rep(base_w/2, neck_h-1)),
      NA
    )
  )
  grid_y <- c(
    # vertical
    rbind(
      rep(1, w+1),
      1+c(1 + 1:(base_w/2-1), rep(h, neck_w+1), rev(1 + 1:(base_w/2-1))),
      NA
    ),
    # horizontal
    rbind(1:(h+1), 1:(h+1), NA)
  )
  
  
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
    n_cells = (base_w/2+1)*base_w/2 + base_w + (neck_h-1)*neck_w
  )
}
