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
