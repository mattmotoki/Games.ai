library(png)

filepath <- "C:/Users/Matt/Documents/GitHub/Games.ai/Cell Division/extras/"
savepath <- "C:/Users/Matt/Documents/GitHub/Games.ai/Cell Division/www/Rmarkdown/cells/"
source(paste0(filepath, "cell_plot_utils.R"))


#------------------
# cell definitions

# square cell
sq_outline <- square_cell(0.2, 100)
sq_x <- sq_outline[, 1] + 0.5
sq_y <- sq_outline[, 2] + 0.5

# trianglular cell
tri_outline <- triangular_cell(0.3, 0.1, n_pnts)
tri_x <- tri_outline[, 1]+0.5
tri_y <- tri_outline[, 2]+0.5

# side trianglular cell
side_tri_outline <- side_triangular_cell(0.1, 0.3, n_pnts)
side_tri_x <- side_tri_outline[, 1]+0.5
side_tri_y <- side_tri_outline[, 2]+0.5

# small trianglular cell
sm_tri_outline <- triangular_cell(0.3, 0.2, n_pnts)
sm_tri_x <- 0.5*(sm_tri_outline[, 1]+0.5)
sm_tri_y <- 0.5*(sm_tri_outline[, 2]+0.5)




#------------------
# plot the progression
graphics.off()

# one
png(paste0(savepath, "cell_d1.png"))
blank_plot()
plot_cell(sq_x, sq_y, cellgreen)
dev.off()



# two
png(paste0(savepath, "cell_d2.png"))
blank_plot()
plot_cell(tri_x, tri_y, cellgreen)
plot_cell(1-tri_x, 1-tri_y, cellgreen)
dev.off()




# three
png(paste0(savepath, "cell_d3.png"))
blank_plot()
plot_cell(side_tri_x, side_tri_y, cellgreen) # right
plot_cell(side_tri_y, side_tri_x, cellgreen) # top
plot_cell(1-tri_x, 1-tri_y, cellgreen)
dev.off()


# four
png(paste0(savepath, "cell_d4.png"))
blank_plot()
plot_cell(side_tri_x, side_tri_y, cellgreen) # right
plot_cell(side_tri_y, 1-side_tri_x, cellgreen) # bot
plot_cell(1-side_tri_x, side_tri_y, cellgreen) # left
plot_cell(side_tri_y, side_tri_x, cellgreen) # top
dev.off()




# five
png(paste0(savepath, "cell_d5.png"))
blank_plot()

# right
plot_cell(sm_tri_x+0.5, 1-sm_tri_y, cellgreen)
plot_cell(sm_tri_x+0.5, sm_tri_y, cellgreen)

plot_cell(side_tri_y, 1-side_tri_x, cellgreen) # bot
plot_cell(1-side_tri_x, side_tri_y, cellgreen) # left
plot_cell(side_tri_y, side_tri_x, cellgreen) # top

dev.off()





# six 
png(paste0(savepath, "cell_d6.png"))
blank_plot()

# right
plot_cell(sm_tri_x+0.5, 1-sm_tri_y, cellgreen)
plot_cell(sm_tri_x+0.5, sm_tri_y, cellgreen)

# left
plot_cell(0.5-sm_tri_x, 1-sm_tri_y, cellgreen)
plot_cell(0.5-sm_tri_x, sm_tri_y, cellgreen)

plot_cell(side_tri_y, 1-side_tri_x, cellgreen) # bot
plot_cell(side_tri_y, side_tri_x, cellgreen) # top
dev.off()




# seven 
png(paste0(savepath, "cell_d7.png"))
blank_plot()


# right
plot_cell(sm_tri_x+0.5, 1-sm_tri_y, cellgreen)
plot_cell(sm_tri_x+0.5, sm_tri_y, cellgreen)

# left
plot_cell(0.5-sm_tri_x, 1-sm_tri_y, cellgreen)
plot_cell(0.5-sm_tri_x, sm_tri_y, cellgreen)

# bot
plot_cell(sm_tri_x, 0.5-sm_tri_y, cellgreen)
plot_cell(1-sm_tri_x, 0.5-sm_tri_y, cellgreen)

plot_cell(side_tri_y, side_tri_x, cellgreen) # top

dev.off()



# eight
png(paste0(savepath, "cell_d8.png"))
blank_plot()

# right
plot_cell(sm_tri_x+0.5, 1-sm_tri_y, cellgreen)
plot_cell(sm_tri_x+0.5, sm_tri_y, cellgreen)

# bot
plot_cell(sm_tri_x, 0.5-sm_tri_y, cellgreen)
plot_cell(1-sm_tri_x, 0.5-sm_tri_y, cellgreen)

# left
plot_cell(0.5-sm_tri_x, 1-sm_tri_y, cellgreen)
plot_cell(0.5-sm_tri_x, sm_tri_y, cellgreen)

# top
plot_cell(sm_tri_x, 0.5+sm_tri_y, cellgreen)
plot_cell(1-sm_tri_x, 0.5+sm_tri_y, cellgreen)

dev.off()




