library(png)
source("cell_plot_utils.R")



#------------------
# cell definitions

# small triangular cell
sm_tri_outline <- triangular_cell(0.3, 0.2, n_pnts)
sm_tri_x <- 0.5*(sm_tri_outline[, 1]+0.5)
sm_tri_y <- 0.5*(sm_tri_outline[, 2]+0.5)

# quadrilateral cell
quad_outline <- quad_cell(0.2, 0.1, n_pnts)
quad_x <- quad_outline[, 1]+0.5
quad_y <- quad_outline[, 2]+0.5



#------------------
# plot cells
graphics.off()

# [\|]
png("cell_q4a.png")
blank_plot()
plot_cell(quad_x, quad_y, cellgreen)
plot_cell(1-quad_x, 1-quad_y, cellgreen)
plot_cell(sm_tri_x, sm_tri_y+0.5, cellgreen)
plot_cell(1-sm_tri_x, 0.5-sm_tri_y, cellgreen)
dev.off()


# [|/]
png("cell_q4b.png")
blank_plot()
plot_cell(quad_x, 1-quad_y, cellgreen)
plot_cell(1-quad_x, quad_y, cellgreen)
plot_cell(sm_tri_x, 0.5-sm_tri_y, cellgreen)
plot_cell(1-sm_tri_x, sm_tri_y+0.5, cellgreen)
dev.off()

