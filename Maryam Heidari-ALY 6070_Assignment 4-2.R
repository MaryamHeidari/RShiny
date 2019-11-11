#install.packages("shiny")
library(shiny)
library(ggplot2)
#dt<- read.csv(file="Northeastern University/term3,summer 2019/6070-Communication and visulization/week 4/HW/Global Superstore Orders 2016(1).csv")
#please select the Global Superstore Orders 2016 data set
dt<- read.csv(file = file.choose())
str(dt)
#Shiny Example: 
ui<-shinyUI(fluidPage(
  
  #fluid page for dynamically adapting to screens of different resolutions.
  titlePanel("Dynamic Scatter Plot of Fincance Columns"),
  sidebarLayout(
    sidebarPanel(
      #implementing radio buttons
      radioButtons("x", "Select first continuous column of dt dataset:",
                   list("Sales"='a', "Profit"='b', "Discount"='c', "Shipping.Cost"='d')),
      
      radioButtons("y", "Select second continuous column of dt dataset:",
                   list("Sales"='e', "Profit"='f', "Discount"='g', "Shipping.Cost"='h'))
      
      # Show a plot of the generated distribution
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
))

#writing server function
server<-shinyServer(function(input, output) {
  
  #referring output distPlot in ui.r as output$distPlot
  output$distPlot <- renderPlot({
    
    mpg_reduced<- dt[,c("Shipping.Cost", "Profit", "Discount", "Sales")]
    
    
    #referring input x in ui.r as input$x
    if(input$x=='a'){
      i<-1
    }
    
    if(input$x=='b'){
      i<-2
    }
    
    if(input$x=='c'){
      i<-3
    }
    
    if(input$x=='d'){
      i<-4
    }
    
    
    #referring input y in ui.r as input$y
    if(input$y=='e'){
      j<-1
    }
    
    if(input$y=='f'){
      j<-2
    }
    
    if(input$y=='g'){
      j<-3
    }
    
    if(input$y=='h'){
      j<-4
    }
    
    
    #producing histogram as output
    plot(mpg_reduced[,i],
         mpg_reduced[,j],
         xlab = "First continuous column",
         ylab = "Second continuous column")
    
  })
})

shinyApp(ui, server)