#------------------
# board size control
get_board_size_ui <- function(type) {
  renderUI({
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
}
output$board_size_ui <- get_board_size_ui(type)



# Petri Game
observeEvent(input$petri_n, {
  ind <- which(petri_dims$n_cells<=as.numeric(input$petri_n))
  ind <- ind[length(ind)]
  rv$h <- petri_dims[ind]$adj*2
  rv$w <- petri_dims[ind]$adj*2
  rv$plot_params <- new_petri(petri_dims[ind]$opp, petri_dims[ind]$adj)
})


observeEvent(input$dec_petri, {
  ind <- which(petri_dims$n_cells<=as.numeric(input$petri_n))
  ind <- ind[length(ind)]
  if (ind>1) {
    ind <- ind-1
    rv$h <- petri_dims[ind]$adj*2
    rv$w <- petri_dims[ind]$adj*2
    updateSelectInput(session, "petri_n", selected = as.character(petri_dims[ind]$n_cells))
  }
})

observeEvent(input$inc_petri, {
  ind <- which(petri_dims$n_cells<=as.numeric(input$petri_n))
  ind <- ind[length(ind)]
  if (ind<nrow(petri_dims)) {
    ind <- ind+1
    rv$h <- petri_dims[ind]$adj*2
    rv$w <- petri_dims[ind]$adj*2
    updateSelectInput(session, "petri_n", selected = as.character(petri_dims[ind]$n_cells))
  }
})


# Beaker Game
observeEvent(input$beaker_height, { 
  rv$h <- input$beaker_height 
  rv$plot_params <- new_beaker(rv$h, rv$w)
})

observeEvent(input$beaker_width, { 
  rv$w <- input$beaker_width
  rv$plot_params <- new_beaker(rv$h, rv$w)
})


# Flask Game
observeEvent(input$flask_neck_h, { 
  rv$h <- input$flask_neck_h + input$flask_base_w/2
  rv$plot_params <- new_flask(input$flask_neck_h, input$flask_base_w)
})

observeEvent(input$flask_base_w, { 
  rv$h <- input$flask_neck_h + input$flask_base_w/2
  rv$w <- input$flask_base_w
  rv$plot_params <- new_flask(input$flask_neck_h, input$flask_base_w)
})

# output total cells in board
output$total_cells <- renderText(paste0("Total number of cells: ", rv$plot_params$n_cells))



#------------------
# opponent options


# if player mode changes then update player names
observeEvent(input$player_mode, {
  
  # reset first move
  if (!is.null(input$first_move)) { rv$player <- input$first_move }
  
  # update player names
  if (input$player_mode=="1") { rv$playernames <- c("You", "A.I.") }
  else { rv$playernames <- c("Player 1", "Player 2") }
})







