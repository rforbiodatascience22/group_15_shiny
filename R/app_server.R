#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#' @importFrom magrittr %>%
app_server <- function(input, output, session) {
  # Your application server logic
  mod_aa_plot_server("aa_plot_1")
}
