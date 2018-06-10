sidebarPanel(
  width = 5,
  
  #--------------
  # header
  fluidRow(
    column(6, p("Options", style = "color: #3BC4A1; font-size:24pt;"), align = "center"),
    column(6,
           fluidRow(
             column(12,
                    tags$a(
                      class = "game_link",
                      title = "Games.ai github",
                      href = "https://github.com/mattmotoki/Games.ai", target = "_blank",
                      HTML('<i class="fa fa-github" aria-hidden="true"></i> More Games')
                    ), align = "right"            
             )
           ),           
           fluidRow(
             column(12,
                    tags$a(
                      class = "game_link",
                      title = "short tutorial on how to play",
                      href = file.path("Rmarkdown", "tutorial.html"), target = "_blank",
                      HTML('<i class="fa fa-play-circle" aria-hidden="true"></i> Tutorial')
                    ), align = "right"            
             )
           ),
           fluidRow(
             column(12,
                    tags$a(
                      class = "game_link",
                      title = "details about the game",
                      href = file.path("Rmarkdown", "about.html"), target = "_blank",
                      HTML('<i class="fa fa-book" aria-hidden="true"></i> About')
                    ), align = "right"            
             )
           )
    )
  ),
  
  
  
  #--------------
  # controls
  fluidPage(
    id = ns("sidebar_panel1"), 
    
    # change color of A.I. skill slider bar
    tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {border: black; background: #C4A13B}")),
    tags$style(HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar {border: black; background: #C4A13B}")),
    tags$style(HTML(".js-irs-2 .irs-single, .js-irs-2 .irs-bar-edge, .js-irs-2 .irs-bar {border: black; background: #C4A13B}")),
    
    # get the size of the board
    fluidRow( h4(actionLink(ns("board_size_link"), "Board Size", icon=icon("sort"))) ),
    fluidRow( id = ns("board_size_section"), uiOutput(ns("board_size_ui")) ),
    
    
    # Opponent difficulty
    fluidRow(h4(actionLink(ns("player_options_link"), "Player Options", icon=icon("user")))),
    fluidRow(
      id = ns("player_options_section"),
      column(6,
             fluidRow( radioButtons(ns("player_mode"), "Mode", list("A.I."="1", "Two Player"="2"), selected = "1") ),
             fluidRow( radioButtons(ns("adaptive"), "Adaptivity", list("On" = "1", "Off"="0"), selected = "0" ) ), 
             align="left"
      ),
      column(6,
             fluidRow( uiOutput(ns("first_move_ui")) ),
             fluidRow( radioButtons(ns("difficulty"), "Difficulty", list("Easy"="1", "Medium"="2", "Hard"="3"), selected="1") ),
             fluidRow( hidden(sliderInput(ns("skill"), "A.I. Skill", value=50, min=0, max=100, ticks=FALSE) )), 
             align="right"
      )
    )
  ),
  
  
  #--------------
  # footnote
  hr(style="background-color: #D0D0D0; height: 1px;") ,
  fluidRow(
    column(12,
           tags$a(
             class = "bio_link",
             title = "linkedin bio",
             href = "https://www.linkedin.com/in/matthew-motoki-9b7884a2",
             HTML('Created by Matt Motok<i class="fa fa-info-circle" aria-hidden="true"></i>'),
             target = "_blank"
           ), align = "center"            
    )
  )
  
)