library(shiny)
library(DT)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Estimate of Rat Blood Alcohol Content (BAC)"),
  
  fluidRow(
    column(3,
           helpText("customize rat information."),
           selectInput("sex", "Sex", selected = "unknown",
                       c("Male" = "male",
                         "Female" = "female")),
           textOutput("length_text"),
           sliderInput("length", step = 1,
                       "length (cm)",
                       min = 12,
                       max = 50,
                       value = 50),
           textOutput("weight_text"),
           sliderInput("weight", step = .01,
                       "weight (g)",
                       min = .1,
                       max = .6,
                       value = .6),
           sliderInput("halflife", step = 1,
                       "Absorption halflife in min.",
                       min = 6,
                       max = 18,
                       value = 18),
           helpText("Alcohol half-life",
                    "18 represents a full stomach and 6 represents an empty stomach."),
           sliderInput("elimination",
                       "Alcohol elimination",
                       step = 0.001,
                       min = 0.009,
                       max = 0.035,
                       value = 0.018),
           helpText("The amount of % BAC you eliminate each hour.")
    ),
    
    column(9,
           fluidRow(
             plotOutput("bac_plot")
           ),
           fluidRow(
             column(1),
             column(2, 
                    uiOutput("drink_time_input"),
                    uiOutput("drink_type_input")
             ),
             column(4,
                    uiOutput("volume_text"),
                    uiOutput("volume_input"),
                    uiOutput("alc_percent_input"),
                    actionButton("enter", "enter")
             ),
             column(1),
             column(4,
                    uiOutput("number_drinks_input"),
                    uiOutput("remove_drink_input")
             )
           )
           ),

HTML('<input type="text" id="client_time" name="client_time" style="display: none;"> '),
HTML('<input type="text" id="client_time_zone_offset" name="client_time_zone_offset" style="display: none;"> '),

tags$script('
    $(function() {
      var time_now = new Date()
      $("input#client_time").val(time_now.getTime())
      $("input#client_time_zone_offset").val(time_now.getTimezoneOffset())
    });    
  ')

))

server <- function(input, output) {
  output$bac_plot <- renderPlot({
    input$enter
})}

shinyApp(ui = ui, server = server)