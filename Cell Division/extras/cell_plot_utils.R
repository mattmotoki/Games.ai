library(png)


filepath <- "C:/Users/Matt/Documents/GitHub/Games.ai/Cell Division/extras/"
savepath <- "C:/Users/Matt/Documents/GitHub/Games.ai/Cell Division/www/Rmarkdown/cells/"
source(paste0(filepath, "single_cell_design.R"))

# plotting parameters
n_pnts <- 100
cellgreen <- c(34/255,250/255,34/255)
cellred <- c(230/255,142/255,54/255)
cellfuscia <- c(230/255,54/255,230/255)
cellblue <- c(34/255,142/255,250/255)



#------------------
# plotting functions

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




plot_cell <- function(x, y, cellgreen) {
  
  # start with all black cell
  polygon(x, y, col="black", border=NA)
  
  # get center of mass
  com <- com_calc(x, y)
  
  # add shadow
  n_layers <- 100
  shink <- seq(1, 0,length=n_layers)
  alpha <- seq(0.1, 1, length=n_layers)
  for (k in 1:n_layers) {
    polygon(shink[k]*(x-com[1])+com[1], shink[k]*(y-com[2])+com[2],
            col=rgb(cellgreen[1], cellgreen[2], cellgreen[3], alpha[k]),
            border=NA)
  }
  
  # add shine
  n_layers <- 25
  shink <- seq(0.25, 0.85, length=n_layers)^2
  alpha <- seq(0.01, 0.05, length=n_layers)
  cellgreen <- 0.5*cellgreen
  for (k in 1:n_layers) {
    polygon(shink[k]*(x-com[1])+com[1], shink[k]*(y-com[2])+com[2],
            col=rgb(cellgreen[1], cellgreen[2], cellgreen[3], alpha[k]),
            border=NA)
  }
}


blank_plot <- function() {
  par(mar=c(0,0,0,0), bg=NA)
  plot(1, type="n", asp=1, axes=FALSE, 
       yaxs="i", xaxs="i", xlab = "", ylab = "",
       xlim = c(-0.002, 1.002), ylim = c(-0.002, 1.002)
  )
}

