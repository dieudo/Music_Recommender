library(shinydashboard)
header <- function() {
  header <- dashboardHeader()
  anchor <- tags$a(href='http://www.spotify.com',
                   tags$img(src='https://broadwaydollamusic.files.wordpress.com/2012/09/6274-spotify-logo-horizontal-white-rgb.png', height='40'),
                   '')
  
  header$children[[2]]$children <- tags$div(
    tags$head(tags$style(HTML(".name { background-color: black }"))),
    anchor,
    class = 'name')
  
  header$children[[3]]$children[[1]] <- tags$div(style = "padding-left: 40px",
                                                 actionButton('btn_tab_exp', 'Data Exploration', style = "height: 50px; font-family: Fixedsys; background-color: #121212; border: 0; color: #ddd; border-bottom: 3px solid; border-color:#ddd"),
                                                 actionButton('btn_tab_play', 'Playlist Creator', style = "height: 50px; font-family: Fixedsys; background-color: #121212; border: 0; color: #ddd; border-bottom: 3px solid; border-color:#ddd")
  )
  header$children[[3]]$children[[2]] <- NULL
  return(header)
}

body <- function() {
  
  dashboardBody(
    useShinyjs(),
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tabItems(
      # First tab content
      tabItem(tabName = "pag1",
              fluidRow( title = "Add Artists",
                        column(width = 1),
                        box(  title = "Running Playlist",
                              div(style = 'overflow-y: auto; overflow-x: auto', dataTableOutput("playlist_to_run")),
                              width = 5
                        ),
                        
                        box(  title = "Relaxing Playlist",
                              div(style = 'overflow-y: auto; overflow-x: auto', dataTableOutput("playlist_to_relax")),
                              width = 5
                        )
              )
      ),
      # Second tab content
      tabItem(tabName = "pag2",
              uiOutput("data_exp")
      )
    )
  )
}
sidebar <- function() {
  sidebar <- dashboardSidebar(
    sidebarMenu(id = "tabs",
                tags$div(style = "display: none;", menuItem("Data Exploration", tabName = "pag2", icon = icon("dashboard"))),
                tags$div(style = "display: none;", menuItem("Playlist Creator",tabName = "pag1", icon = icon("th"))),
                tags$div(style = "margin-top: 16px", add_artist_sidebarUI("add"))
    )
  )
  return(sidebar)
}

ui <- dashboardPage(header(),
                    sidebar(),
                    body())