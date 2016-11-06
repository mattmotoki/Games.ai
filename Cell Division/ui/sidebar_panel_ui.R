sidebarPanel(
  width = 4,
  # header
  fluidRow(
    column(12, p("Game Options", style = "color: #3BC4A1; font-size:24pt; padding:0px; margin:0px;"), align = "center")
  ),
  
  # controls
  source(file.path("ui", "sidebar_panel_ui1.R"), local = TRUE)$value,
  # source(file.path("ui", "sidebar_panel_ui2.R"), local = TRUE)$value,
  
  # footnote
  fluidRow( hr(style="background-color: #D0D0D0; height: 1px;") ),
  fluidRow(
    column(12,
           tags$a(href = "https://github.com/mattmotoki/Games.ai", target = "_blank",
                  HTML('Created by Matt Motoki <i class="fa fa-github" aria-hidden="true"></i>'),
                  style = "color: #3BA3C4"),
           align = "center"            
    )
  )
)