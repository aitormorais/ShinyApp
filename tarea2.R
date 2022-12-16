
library(DT)

ui <- fluidPage(
  h2("Netflix"),
  DT::dataTableOutput("mytable"),
  mainPanel(
    
    # Output: Histogram ----
    #plotOutput(outputId = "distPlot"),
    plotOutput(outputId = "boxPlot")
    
  )
)

server <- function(input, output) {
  data <- read.csv("Series.csv", sep=",")
  summary(data)
  str (data)
  numeros <- data.frame(
    "maximo"=data$Max_Length,
    "minimo"=data$Min_Length
    
  )
  stak <- stack(numeros)
  output$mytable = DT::renderDataTable({
    read.csv("Series.csv", sep=",")
  })
  output$boxPlot <-renderPlot({boxplot(stak$values ~ stak$ind,col = rainbow(ncol(numeros)))})
}

shinyApp(ui, server)
