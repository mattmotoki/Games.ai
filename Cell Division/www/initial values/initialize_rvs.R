{
  if      (type == "petri_game") { return(source(file.path("www", "initial values", "initialize_petri.R"),  local = TRUE)) }
  else if (type == "beaker_game") { source(file.path("www", "initial values", "initialize_beaker.R"),  local = TRUE) }
  else if (type == "flask_game") { source(file.path("www", "initial values", "initialize_flask.R"),  local = TRUE) }
  else { stop("Invalid board type") }    
}

rv <- new_rv(type)