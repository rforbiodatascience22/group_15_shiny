#' translate UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_translate_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(

      column(8,
             # "DNA_sequence"
             shiny::uiOutput(ns("DNA"))),

      column(4,
             # "Random_dna_length
             shiny::numericInput(inputId = ns("dna_length"),
                            label = "Length of DNA sequence",
                            value = 300,
                            min = 3,
                            max = 100000,
                            step = 3),
              # "Generate_dna_button"
              actionButton(inputId = ns("generate_dna"),
                             label = "Generate DNA sequence"))
    ),

    # show peptide header
    shiny::textOutput(outputId = ns("peptide_header")),

    # "piptide_sequence"
    shiny::verbatimTextOutput(outputId = ns("peptide")) %>%
      shiny::tagAppendAttributes(style = "white-space: pre-wrap;")
  )
}

#' translate Server Functions
#'
#' @noRd
mod_translate_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # updateable dna variable
    dna <- reactiveVal()

    # input text field for DNA
    output$DNA <- renderUI({
      textAreaInput(
        inputId = ns("DNA"),
        label = "DNA sequence",
        placeholder = "Insert DNA sequence",
        value = dna(),
        height = 100,
        width = 600
      )
    })

    # call dna generator function when button is clicked
    observeEvent(input$generate_dna, {
      dna(
        DNATGC::dna_sampler(input$dna_length)
      )
    })

    # peptide header
    output$peptide_header <- renderText({
      # only show output if dna length is at least 3
      if (is.null(input$DNA)) {
      } else if(nchar(input$DNA) < 3) {
        NULL
      } else {
        "Amino acid sequence:"
      }
    })

    # translate DNA to amino acids
    output$peptide <- renderText({
      # only show output if dna length is at least 3
      if (is.null(input$DNA)) {
      } else if (nchar(input$DNA) < 3) {
        NULL
      } else {
        input$DNA %>%
          toupper() %>% # convert to uppercase
          DNATGC::dna_to_rna() %>% # convert to RNA
          DNATGC::codon_list() %>% # make list of codons
          DNATGC::translate() #translate to amino acids
      }
    })

  })
}

## To be copied in the UI
# mod_translate_ui("translate_1")

## To be copied in the server
# mod_translate_server("translate_1")
