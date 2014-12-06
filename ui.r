# Author: kmr

library(shiny)
library(googleVis)

# UI for Map Visualization 

shinyUI(fluidPage(
  titlePanel(
      br()),
    
  sidebarPanel(
          
      h2("Food Trends by City"),
      
      br(),
      
      tags$head(
        tags$style("body {background-color: #8B99AB; }")),
    
      h4("Select a food to examine: "),      
      selectInput("food","", levels(fooddata$term), selected='kale'),
      
      br(),
        
      h4("View this food by: "),
      selectInput("var", " ",
                   list("Restaurants" = "count", 
                        "Restaurants per capita" = "pc_count",
                        "Tweets" = "tweets", 
                        "Tweets per capita" = "pc_tweets",
                        "Sentiment of Tweets" = "sentiment",
                        "Average Dish Price" = "avgprice",
                        "Median Dish Price" = "medprice"), 
                    selected='count'),
      
      br(),
      
      em("Dish price levels are:"),
      h6("1: 10 dollars and under"),
      h6("2: 10-20 dollars"),
      h6("3: 20-30 dollars"),
      h6("4: 30 dollars and above")    
                       
    ),
    
    mainPanel(    
        htmlOutput("gvis"))
        
))
