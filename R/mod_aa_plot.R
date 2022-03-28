#' aa_plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_aa_plot_ui <- function(id){
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        "peptide_sequence"
      ),
      mainPanel(
        "plot"
      )
    )
  )
}

#' aa_plot Server Functions
#'
#' @noRd
mod_aa_plot_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_aa_plot_ui("aa_plot_1")

## To be copied in the server
# mod_aa_plot_server("aa_plot_1")
