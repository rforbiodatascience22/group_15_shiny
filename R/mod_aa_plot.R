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
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::textAreaInput(inputId = ns("peptide"),
                      label = h3("Input sequence"),
                      width = 300,
                      height = 100,
                      placeholder = "Input peptide sequence here..."
        )
      ),
      shiny::mainPanel(
        shiny::plotOutput(
          outputId = ns("abundance")
        )
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

    output$abundance <- renderPlot({
      if(input$peptide == ""){
        NULL
      } else{
        input$peptide %>%
          DNATGC::occurence_plotter() +
          ggplot2::theme(legend.position = "none")
      }

    })

  })
}

## To be copied in the UI
# mod_aa_plot_ui("aa_plot_1")

## To be copied in the server
# mod_aa_plot_server("aa_plot_1")
