library(shiny)
library(shinyjs)
library(shinythemes)
library(data.table)

# load external data
source("game_module.R",  local = TRUE)
for (f in dir(file.path("www", "functions"), full.names = TRUE, recursive = TRUE)) { source(f, local = TRUE) }

ui <- navbarPage(
  "header",
  
  title = tags$a(
    id = "navbar_header_content",
    href = "https://github.com/boto/boto#user-content-finding-out-more-about-boto",
    target = "_blank",
    tags$img(id="navbar_header_logo", src = file.path("images", "cell_logo.png") ),
    HTML("&nbsp Cell Division Prototype"),
    style = "color: #3BA3C4"
  ),
  
  windowTitle = "Cell Division",
  
  
  theme=shinytheme("flatly"), 
  gameUI("petri", "Petri Dish", icon("dot-circle-o")),
  gameUI("beaker", "Beaker", icon("table")),
  gameUI("flask", "Erlenmeyer Flask", icon("flask")),
  
  tags$head(
    tags$link(rel = "shortcut icon", href=file.path("images", "small_icon.ico")),
    tags$link(href = "style.css", rel = "stylesheet"),
    tags$style(HTML("
          .navbar .navbar-nav {float: right}
          .navbar .navbar-header {float: left}
        "))
  )
)

server <- function(input, output, session) {
  callModule(play_game, "petri", "petri_game")  
  callModule(play_game, "beaker", "beaker_game") 
  callModule(play_game, "flask", "flask_game")
}


shinyApp(ui, server)