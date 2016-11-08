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
  # check for valid input
  user_input <- parse_numeric_input(input$beaker_height, 2, 10, 1)
  if (is.na(user_input)) {return()}
  
  rv$h <- user_input
  rv$plot_params <- new_beaker(rv$h, rv$w)
})

observeEvent(input$beaker_width, { 
  # check for valid input
  user_input <- parse_numeric_input(input$beaker_width, 2, 10, 1)
  if (is.na(user_input)) {return()}

  rv$w <- user_input
  rv$plot_params <- new_beaker(rv$h, rv$w)
})


# Flask Game
observeEvent(input$flask_neck_h, { 
  # check for valid input
  user_input <- parse_numeric_input(input$flask_neck_h, 2, 10, 1)
  if (is.na(user_input)) {return()}
  
  rv$h <- user_input + rv$w/2
  rv$plot_params <- new_flask(user_input, rv$w)
})

observeEvent(input$flask_base_w, { 
  # check for valid input
  user_input <- parse_numeric_input(input$flask_base_w, 4, 10, 2)
  if (is.na(user_input)) {return()}
  
  # recall neck_h = h - base_w/2
  rv$h <- (rv$h-rv$w/2) + user_input/2
  rv$w <- user_input
  rv$plot_params <- new_flask(rv$h-rv$w/2, rv$w)
})
