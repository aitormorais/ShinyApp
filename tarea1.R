library(shiny)
#install.packages("wordcloud")
library(wordcloud)
#install.packages("tm")
library(tm)
# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Tarea1"),
  
  # Sidebar layout with input and output definitions ----
    
    # Sidebar panel for inputs ----
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot"),
      plotOutput(outputId = "boxPlot")
      
    )
  
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  data <- read.csv("Series.csv", sep=",")
  summary(data)
  str (data)
  numeros <- data.frame(
    "maximo"=data$Max_Length,
    "minimo"=data$Min_Length
    
  )
  stak <- stack(numeros)
 
  
  output$distPlot <- renderPlot({
    # The graph shows how many series have X episodes
    hist(data$Episodes)
  })

  output$boxPlot <-renderPlot({boxplot(stak$values ~ stak$ind,col = rainbow(ncol(numeros)))})
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)

