# load packages –---------------------------------------------------------------

library(tidyverse)
library(shiny)

# load data –-------------------------------------------------------------------

weather <- read_csv("data/weather.csv")

# create app –------------------------------------------------------------------

shinyApp(
  ui = fluidPage(
    titlePanel("Weather Forecasts"),
    sidebarLayout(
      sidebarPanel(
        # UI input code goes here
        selectInput(
          # naming input as city
          inputId = "city",
          # user sees label as "Select a city"
          label = "Select a city",
          choices = c(
            "Chicago",
            "Durham",
            "New York",
            "Sedona",
            "Los Angeles"
          ),
          selected = "Durham"
        ),
        selectInput(
          inputId = "variable",
          label = "Select a variable",
          choices = c(
            "temp",
            "feelslike",
            "humidity"
          ),
          selected = "temp"
        )
      ),
      mainPanel(
        # UI output code goes here
        plotOutput("plot")
      )
    )
  ),
  server = function(input, output, session) {

    # server code goes here
    output$plot <- renderPlot({
      weather |>
        filter(city == input$city) |>
        ggplot(aes(x = time, y = input$variable)) +
        geom_line()
    })

  }
)