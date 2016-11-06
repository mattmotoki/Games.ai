# add user moves to the board
observeEvent(input$plot_click, {
  # initialize things on first click    
  if (is.null(rv$open_pos)) { rv <- on_first_click(rv, type) }
  
  # check if row or column is out of bounds
  row <- floor(input$plot_click$y)
  col <- floor(input$plot_click$x)
  if (row<1 || row>rv$h || col<1 || col>rv$w) {return()} 
  ind0 <- sub2ind(row, col, rv$h)
  
  # apply gravity if neccessary
  if (type!="petri_game") {
    row <- which(rv$board[,col+2]==0)[1]-2
    ind0 <- sub2ind(row, col, rv$h)
  }
  
  # implement move
  if (ind0 %in% rv$open_pos) { rv <- implement_move(rv, ind0) }
  
})