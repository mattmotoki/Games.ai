#------------------
# board size control
output$board_size_ui <- renderUI({
  ns <- session$ns
  if (type == "petri_game") {
    #----------
    # Petri Game
    tagList(
      fluidRow(  column(12, selectInput(ns("petri_n"), "Number of Cells", as.list(petri_dims$n_cells), selected = 12) ) ),
      fluidRow(  
        column(6, actionButton(ns("dec_petri"), "decrease", icon=icon("arrow-down")), align="left" ) ,
        column(6, actionButton(ns("inc_petri"), "increase", icon=icon("arrow-up")), align="right" ) 
      )
    )
    
  } else if (type == "beaker_game") {
    #----------
    # Beaker Game
    fluidRow( 
      column(6, numericInput(ns("beaker_height"), "Height", min = 2, max = 10, value = 3, step = 1)),
      column(6, numericInput(ns("beaker_width"), "Width",   min = 2, max = 10, value = 4, step = 1)),
      div(style="display:inline; text-indent: 15px;", p(textOutput(ns("total_cells"))))
    )
    
    
  } else if (type == "flask_game") {
    #----------
    # Flask Game
    fluidRow( 
      column(6, numericInput(ns("flask_neck_h"), "Neck-Height", min = 2, max = 10, value = 3, step = 1) ),
      column(6, numericInput(ns("flask_base_w"), "Base-Width",   min = 4, max = 10, value = 6, step = 2) ),
      div(style="display:inline; text-indent: 15px;", p(textOutput(ns("total_cells"))))
    )
  } 
}) 

# output total cells in board
output$total_cells <- renderText(paste0("Total number of cells: ", rv$plot_params$n_cells))