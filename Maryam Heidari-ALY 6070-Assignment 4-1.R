#install.packages that we need
install.packages("shiny")
library(shiny)
library(ggplot2)
library(readxl)

# read the data set
#please select the Claims dataset  
dt <- read_excel(file.choose())
#dt<- read_excel("Northeastern University/term3, summer 2019/6070-Communication and visulization/week 4/HW/Claims.xlsx")

#finding the outlier and delete them
boxplot(dt$TOTAL_PAID_BY_INSURANCE)
outliers <- boxplot(dt$TOTAL_PAID_BY_INSURANCE, plot=FALSE)$out
dt <- dt[-which(dt$TOTAL_PAID_BY_INSURANCE %in% outliers),]
boxplot(dt$TOTAL_PAID_BY_INSURANCE)
#Histogram where you control the number of bins
ui <- fluidPage(
  # App title ----
  titlePanel("Dynamic Histogram of Total Paid by Insurance"),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs ----
    sidebarPanel(sliderInput(inputId = "bins",
                             label = "Number of bins:",
                             min = 1,
                             max = 100,
                             value = 5)  # defualt for start
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      
    )
  )
)
server <- function(input, output) {
  output$distPlot <- renderPlot({
    x    <- dt$TOTAL_PAID_BY_INSURANCE
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "light blue", border = "black",
         xlab = "Distribution of Paid Amount",
         main = ' ')
    
  })
  
}

shinyApp(ui, server)