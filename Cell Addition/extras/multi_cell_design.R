library(png)


filepath <- "C:/Users/Matt/Documents/GitHub/Games.ai/Cell Division/extras/"
source(paste0(filepath, "single_cell_design.R"))

# plotting parameters
n_pnts <- 100
color <- c(34/255,250/255,34/255)


# get center of mass
com_calc <- function(x, y) {
  # plot shape
  png('temp.png', width = 1000, height = 1000)
  par(mar=c(0,0,0,0), bg="NA")
  plot(1, type="n", asp=1, axes = FALSE,
       yaxs="i", xaxs="i", xlab = "", ylab = "",
       xlim = c(0, 1), ylim = c(0, 1)
  )
  polygon(x, y, col=rgb(0,0,0), border=NA)
  dev.off()
  
  img <- 1*(readPNG("temp.png")[, , 4]>0.5)
  img <- img/sum(img)
  
  com_x <- sum(img %*% seq(0, 1, length=dim(img)[1]))
  com_y <- 1-sum(t(img) %*% seq(0, 1, length=dim(img)[1]))
  
  print(c(com_x, com_y))
  c(com_x, com_y)
  
}


plot_cell <- function(x, y, color) {
  # shadow parameters
  n_layers <- 50
  shink <- sqrt(seq(1, 0,length=n_layers))
  alpha <- seq(0.15, 1, length=n_layers)
  
  polygon(x, y, col="black", border=NA)
  
  # add shadow
  com <- com_calc(x, y)
  for (k in 1:n_layers) {
    polygon(shink[k]*(x-com[1])+com[1], shink[k]*(y-com[2])+com[2],
            col=rgb(color[1], color[2], color[3], alpha[k]),
            border=NA)
  }
}






# []
png("cell1.png")
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1)
)
abline(h=c(0, 1), v=c(0, 1))

sq_outline <- square_cell(0.15, 100)
sq_x <- sq_outline[, 1] + 0.5
sq_y <- sq_outline[, 2] + 0.5
plot_cell(sq_x, sq_y, color)
dev.off()



# [|]
png("cell2v.png")
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1)
)
abline(h=c(0, 1), v=c(0, 1))

rect_x <- sq_x - 0.5*(sq_x>0.5)
plot_cell(rect_x, sq_y, color)
plot_cell(rect_x+0.5, sq_y, color)
dev.off()





# [/]
png("cell2fd.png")
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1)
)
abline(h=c(0, 1), v=c(0, 1))

tri_outline <- triangular_cell(0.15, 0.05, n_pnts)
tri_x <- tri_outline[, 1]+0.5
tri_y <- tri_outline[, 2]+0.5

plot_cell(tri_x, tri_y, color)
plot_cell(1-tri_x, 1-tri_y, color)
dev.off()



# [+]
png("cell4p.png")
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1)
)
abline(h=c(0, 1), v=c(0, 1))

sm_sq_outline <- square_cell(0.3, 100)
sm_sq_x <- 0.5*(sm_sq_outline[, 1] + 0.5)
sm_sq_y <- 0.5*(sm_sq_outline[, 2] + 0.5)

plot_cell(sm_sq_x, sm_sq_y, color)
plot_cell(sm_sq_x, sm_sq_y+0.5, color)
plot_cell(sm_sq_x+0.5, sm_sq_y, color)
plot_cell(sm_sq_x+0.5, sm_sq_y+0.5, color)
dev.off()




# [x]
png("cell4x.png")
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1)
)
abline(h=c(0, 1), v=c(0, 1))


side_tri_outline <- side_triangular_cell(0.05, 0.15, n_pnts)
side_tri_x <- side_tri_outline[, 1]+0.5
side_tri_y <- side_tri_outline[, 2]+0.5
plot_cell(side_tri_x, side_tri_y, col=color)
plot_cell(1-side_tri_x, side_tri_y, col=color)
plot_cell(side_tri_y, side_tri_x, col=color)
plot_cell(side_tri_y, 1-side_tri_x, col=color)
dev.off()



# [\|]
png("cell4vbd.png")
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1)
)
abline(h=c(0, 1), v=c(0, 1))


quad_outline <- quad_cell(0.15, 0.05, n_pnts)
quad_x <- quad_outline[, 1]+0.5
quad_y <- quad_outline[, 2]+0.5
plot_cell(quad_x, quad_y, col=color)
plot_cell(1-quad_x, 1-quad_y, col=color)

sm_tri_outline <- triangular_cell(0.3, 0.1, n_pnts)
sm_tri_x <- 0.5*(sm_tri_outline[, 1]+0.5)
sm_tri_y <- 0.5*(sm_tri_outline[, 2]+0.5)
plot_cell(sm_tri_x, sm_tri_y+0.5, col=color)
plot_cell(1-sm_tri_x, 0.5-sm_tri_y, col=color)
dev.off()


# [|/]
png("cell4vfd.png")
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1)
)
abline(h=c(0, 1), v=c(0, 1))

plot_cell(quad_x, 1-quad_y, col=color)
plot_cell(1-quad_x, quad_y, col=color)

plot_cell(sm_tri_x, 0.5-sm_tri_y, col=color)
plot_cell(1-sm_tri_x, sm_tri_y+0.5, col=color)
dev.off()





# [+/]
png("cell6pfd.png")
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1)
)
abline(h=c(0, 1), v=c(0, 1))


plot_cell(sm_sq_x, sm_sq_y+0.5, color)
plot_cell(sm_sq_x+0.5, sm_sq_y, color)

plot_cell(sm_tri_x, 0.5-sm_tri_y, col=color)
plot_cell(0.5-sm_tri_x, sm_tri_y, col=color)

plot_cell(sm_tri_x+0.5, 1-sm_tri_y, col=color)
plot_cell(1-sm_tri_x, sm_tri_y+0.5, col=color)
dev.off()




# [x|]
png("cell6vx.png")
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1)
)
abline(h=c(0, 1), v=c(0, 1))

plot_cell(side_tri_y, side_tri_x, col=color)
plot_cell(side_tri_y, 1-side_tri_x, col=color)

plot_cell(0.5-sm_tri_x, sm_tri_y, col=color)
plot_cell(0.5-sm_tri_x, 1-sm_tri_y, col=color)

plot_cell(sm_tri_x+0.5, sm_tri_y, col=color)
plot_cell(sm_tri_x+0.5, 1-sm_tri_y, col=color)
dev.off()




# [+x]
png("cell8.png")
plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1)
)
abline(h=c(0, 1), v=c(0, 1))

plot_cell(sm_tri_x, 0.5-sm_tri_y, col=color)
plot_cell(0.5-sm_tri_x, sm_tri_y, col=color)

plot_cell(sm_tri_x+0.5, sm_tri_y, col=color)
plot_cell(1-sm_tri_x, 0.5-sm_tri_y, col=color)

plot_cell(sm_tri_x+0.5, 1-sm_tri_y, col=color)
plot_cell(1-sm_tri_x, 0.5+sm_tri_y, col=color)

plot_cell(sm_tri_x, 0.5+sm_tri_y, col=color)
plot_cell(0.5-sm_tri_x, 1-sm_tri_y, col=color)
dev.off()




