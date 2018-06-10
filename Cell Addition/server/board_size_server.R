#------------------
# board size control
output$board_size_ui <- renderUI({
  ns <- session$ns
  if (type == "petri_game") {
    #----------
    # Petri Game
    tagList(
      fluidRow(
        column(12, 
               selectInput(ns("petri_n"), p(
                 HTML("Number of Cells: &nbsp"),
                 actionLink(ns("dec_petri"), "", icon=icon("chevron-down"), style="color: black;"),
                 actionLink(ns("inc_petri"), "", icon=icon("chevron-up"), style="color: black;"),
                 style="margin-bottom:0; padding-bottom:0;"
               ), as.list(petri_dims$n_cells), selected = 16) 
        )
      )
    )
    
  } else if (type == "beaker_game") {
    #----------
    # Beaker Game
    fluidRow( 
      column(6, 
             selectInput(ns("beaker_height"), p(
               "Height: ", HTML("&nbsp"),
               actionLink(ns("dec_beaker_h"), "", icon=icon("chevron-down"), style="color: black;"),
               actionLink(ns("inc_beaker_h"), "", icon=icon("chevron-up"), style="color: black;"),
               style="margin-bottom:0; padding-bottom:0;"
             ), as.list(2:10), selected = 3) 
      ), 
      column(6, 
             selectInput(ns("beaker_width"), p(
               "Width: ", HTML("&nbsp"),
               actionLink(ns("dec_beaker_w"), "", icon=icon("chevron-down"), style="color: black;"),
               actionLink(ns("inc_beaker_w"), "", icon=icon("chevron-up"), style="color: black;"),
               style="margin-bottom:0; padding-bottom:0;"
             ), as.list(2:10), selected = 4) 
      )
    )
    
    
  } else if (type == "flask_game") {
    #----------
    # Flask Game
    fluidRow( 
      column(6, 
             selectInput(ns("flask_neck_h"), p(
               "Neck-Height: ", HTML("&nbsp"),
               actionLink(ns("dec_neck_h"), "", icon=icon("chevron-down"), style="color: black;"),
               actionLink(ns("inc_neck_h"), "", icon=icon("chevron-up"), style="color: black;"),
               style="margin-bottom:0; padding-bottom:0;" 
             ), as.list(2:8), selected = 3) 
      ), 
      column(6, 
             selectInput(ns("flask_base_w"), p(
               "Base-Width: ", HTML("&nbsp"),
               actionLink(ns("dec_base_w"), "", icon=icon("chevron-down"), style="color: black;"),
               actionLink(ns("inc_base_w"), "", icon=icon("chevron-up"), style="color: black;"),
               style="margin-bottom:0; padding-bottom:0;" 
             ), as.list(seq(4, 10, 2)), selected = 6) 
      )
    )
  } 
}) 



#-------------
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

#-------------
# Beaker Game
observeEvent(c(input$beaker_height, input$beaker_width), {
  rv$h <- as.numeric(input$beaker_height)
  rv$w <- as.numeric(input$beaker_width)
  rv$plot_params <- new_beaker(rv$h, rv$w)
})


observeEvent(input$dec_beaker_w, {
  if (rv$w==2) return()
  rv$w <- rv$w - 1
  updateSelectInput(session, "beaker_width", selected = rv$w)
})

observeEvent(input$inc_beaker_w, {
  if (rv$w==10) return()
  rv$w <- rv$w + 1
  updateSelectInput(session, "beaker_width", selected = rv$w)
})


observeEvent(input$dec_beaker_h, {
  if (rv$h==2) return()
  rv$h <- rv$h - 1
  updateSelectInput(session, "beaker_height", selected = rv$h)
})

observeEvent(input$inc_beaker_h, {
  if (rv$h==10) return()
  rv$h <- rv$h + 1
  updateSelectInput(session, "beaker_height", selected = rv$h)
})




#-------------
# Flask Game
observeEvent(c(input$flask_neck_h, input$flask_base_w), {
  rv$w <- as.numeric(input$flask_base_w)
  rv$h <- as.numeric(input$flask_neck_h) + rv$w/2
  rv$plot_params <- new_flask(rv$h - rv$w/2, rv$w)
})


observeEvent(input$dec_base_w, {
  if (rv$w==4) return()
  rv$w <- rv$w - 2
  updateSelectInput(session, "flask_base_w", selected = rv$w)
})

observeEvent(input$inc_base_w, {
  if (rv$w==10) return()
  rv$w <- rv$w + 2
  updateSelectInput(session, "flask_base_w", selected = rv$w)
})


observeEvent(input$dec_neck_h, {
  print(rv$h)
  if (rv$h-rv$w/2==2) return()
  rv$h <- rv$h - 1
  updateSelectInput(session, "flask_neck_h", selected = rv$h - rv$w/2)
})

observeEvent(input$inc_neck_h, {
  if (rv$h-rv$w/2==8) return()
  rv$h <- rv$h + 1
  updateSelectInput(session, "flask_neck_h", selected = rv$h - rv$w/2)
})







# 
# 
# observeEvent(input$flask_neck_h, { 
#   # check for valid input
#   user_input <- parse_numeric_input(input$flask_neck_h, 2, 10, 1)
#   if (is.na(user_input)) {return()}
#   
#   rv$h <- user_input + rv$w/2
#   rv$plot_params <- new_flask(user_input, rv$w)
# })
# 
# observeEvent(input$flask_base_w, { 
#   # check for valid input
#   user_input <- parse_numeric_input(input$flask_base_w, 4, 10, 2)
#   if (is.na(user_input)) {return()}
#   
#   # recall neck_h = h - base_w/2
#   rv$h <- (rv$h-rv$w/2) + user_input/2
#   rv$w <- user_input
#   rv$plot_params <- new_flask(rv$h-rv$w/2, rv$w)
# })
