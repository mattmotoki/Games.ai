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

