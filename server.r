library(shiny)
library(ggplot2)
library(googleVis)

shinyServer(function(input, output) {
  
  var <- reactive({
    input$var})
  
  output$gvis <- renderGvis({    
            data <- fooddata[fooddata$term == input$food,]
            gvisGeoChart(data, locationvar = 'loc', 
                 colorvar = var(), 
                 hovervar = 'city',
                 options=list(region = 'US',
                              displayMode = 'regions', 
                              resolution = 'metros',
                              backgroundColor = '#8B99AB',
                              colorAxis = ifelse(((var() == "avgprice")|(var() == "medprice")), 
                                                 "{minValue: 0, maxValue: 4, colors:['yellow','orangered','red']}",
                                                 ifelse((var() == "count"), 
                                                        "{minValue: 0, colors:['#c0ffd0','LimeGreen','DarkGreen']}",
                                                        ifelse((var() == "tweets"),
                                                          "{minValue: 0, maxValue: 100, colors:['plum','#3D003D']}",
                                                            ifelse((var() == "sentiment"),
                                                               "{minValue: -1, maxValue: 1, 
                                                               colors:['DarkRed','red','yellow','green','DarkGreen']}",
                                                               "{minValue: 0, colors: ['#b3c6ff','#000099']}")))),
                              width = 800, height = 500))    
  })
    
  
  })    
  
