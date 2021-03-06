library(shiny)

## Basic module including renderUI of slider.
## Shows argument to and return from sliderText() server logic.

sliderTextUI <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns("set_slider")),
    textOutput(ns("number"))
  )
}

sliderText <- function(input, output, session, show) {
  ns <- session$ns
  output$set_slider <- renderUI({
    sliderInput(ns("slider"), "Slide me", 0, 100, 5)
  })
  output$number <- renderText({
    if(show())
      input$slider
    else
      NULL
  })
  reactive({input$slider + 5})
}

ui <- fluidPage(
  checkboxInput("display", "Show Value"),
  sliderTextUI("module"),
  h2(textOutput("value"))
)

server <- function(input, output) {
  display <- reactive({input$display})
  num <- callModule(sliderText, "module", display)
  output$value <- renderText({paste0("slider1+5: ", num())})
}
shinyApp(ui, server)
