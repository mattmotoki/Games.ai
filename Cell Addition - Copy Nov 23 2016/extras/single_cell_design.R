# plotting parameters
n_pnts <- 100
color <- rgb(34/255,250/255,34/255)


#----------------
# square
square_cell <- function(r, n_pnts) {
  R <- rep(r, n_pnts)
  theta <- seq(0, 2*pi, length.out = 4*n_pnts)
  
  x <- r*cos(theta) + c(1-R, R, R, 1-R) - 0.5
  y <- r*sin(theta) + c(1-R, 1-R, R, R) - 0.5
  cbind(x, y)
}

# plot a single square cell
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(-0.6, 0.6), ylim = c(-0.6, 0.6)
)
abline(h=c(-0.5, 0.5), v=c(-0.5, 0.5))

sq_outline <- square_cell(0.1, n_pnts)
sq_x <- sq_outline[, 1]
sq_y <- sq_outline[, 2]
polygon(sq_x, sq_y, col=color, lwd=2)




#----------------
# triangular
triangular_cell <- function(r, r2, n_pnts) {
  R <- rep(r, n_pnts)
  R2 <- rep(r2, n_pnts)
  
  theta <- c(seq(0, pi/2, length.out = n_pnts), 
             seq(pi/2, 5*pi/4, length.out = n_pnts),
             seq(5*pi/4, 2*pi, length.out = n_pnts))
  
  
  x <- c(R, R2, R2)*cos(theta) + c(1-R, R2*(1+sqrt(2)),  1-R2) - 0.5
  y <- c(R, R2, R2)*sin(theta) + c(1-R, 1-R2,  R2*(1+sqrt(2))) - 0.5
  cbind(x, y)
}


# plot a dual triangular cells
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(-0.6, 0.6), ylim = c(-0.6, 0.6)
)
abline(h=c(-0.5, 0.5), v=c(-0.5, 0.5))

tri_outline <- triangular_cell(0.1, 0.05, n_pnts)
tri_x <- tri_outline[, 1]
tri_y <- tri_outline[, 2]
polygon(tri_x, tri_y, col=color, lwd=2)
polygon(-tri_x, -tri_y, col=color, lwd=2)





#----------------
# triangular
side_triangular_cell <- function(r, r2, n_pnts) {
  R <- rep(r, n_pnts)
  R2 <- rep(r2, n_pnts)
  theta <- c(seq(0, 3*pi/4, length.out = n_pnts),
             seq(3*pi/4, 5*pi/4, length.out = n_pnts),
             seq(5*pi/4, 2*pi, length.out = n_pnts))
  x <- c(R, R2, R)*cos(theta) + c(1-R, 0.5+sqrt(2)*R2, 1-R) - 0.5
  y <- c(R, R2, R)*sin(theta) + c(1-(1+sqrt(2))*R, rep(0.5, n_pnts), (1+sqrt(2))*R) - 0.5
  cbind(x, y)
}


# plot a triangular side cells
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(-0.6, 0.6), ylim = c(-0.6, 0.6)
)
abline(h=c(-0.5, 0.5), v=c(-0.5, 0.5))

side_tri_outline <- side_triangular_cell(0.05, 0.1, n_pnts)
side_tri_x <- side_tri_outline[, 1]
side_tri_y <- side_tri_outline[, 2]
polygon(side_tri_x, side_tri_y, col=color, lwd=2)
polygon(-side_tri_x, side_tri_y, col=color, lwd=2)
polygon(side_tri_y, side_tri_x, col=color, lwd=2)
polygon(side_tri_y, -side_tri_x, col=color, lwd=2)





#----------------
# quadrilateral
quad_cell <- function(r, r2, n_pnts) {
  R <- rep(r, n_pnts)
  R2 <- rep(r2, n_pnts)
  
  theta <- c(seq(0, pi/2, length.out = n_pnts), 
             seq(pi/2, pi, length.out = n_pnts),
             seq(pi, 5*pi/4, length.out = n_pnts),
             seq(5*pi/4, 2*pi, length.out = n_pnts))
  
  x <- c(R, R, R, R2)*cos(theta) + c(1-R, 0.5+R, 0.5+R, 1-R2) - 0.5
  y <- c(R, R ,R, R2)*sin(theta) + c(1-R, 1-R, 0.5 + R*(sqrt(2)-1), R2*(1+sqrt(2))) - 0.5
  cbind(x, y)
}

# plot quad with triangles
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(-0.6, 0.6), ylim = c(-0.6, 0.6)
)
abline(h=c(-0.5, 0.5), v=c(-0.5, 0.5))

quad_outline <- quad_cell(0.15, 0.05, n_pnts)
quad_x <- quad_outline[, 1]
quad_y <- quad_outline[, 2]
polygon(quad_x, quad_y, col=color, lwd=2)
polygon(-quad_x, -quad_y, col=color, lwd=2)

tri_outline <- triangular_cell(0.2, 0.1, n_pnts)
tri_x <- tri_outline[, 1]
tri_y <- tri_outline[, 2]
polygon(0.5*(tri_x-0.5), 0.5*(tri_y+0.5), col=color, lwd=2)
polygon(0.5-0.5*(tri_x+0.5), 0.5*(0.5-tri_y)-0.5, col=color, lwd=2)


