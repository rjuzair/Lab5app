
library(shiny)

# Define UI for application that draws a histogram
ui<-(fluidPage(
    
    # Application title
    titlePanel("Air Quality Index (AQI) ~ PM10"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            radioButtons("city",
                         "Select City",
                         choices = c( "Linkoping" = "1", "Stockholm" = "2", "Malmo" = "3",
                                      "Gothenburg" = "4", "Lulea" = "5", "Umea" = "6"),
                         selected = ("Linkoping" = "1")
            )
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("Plot")
        )
    )
))
# Define server logic required to draw a histogram
server<- shinyServer(function(input, output, session) {
    
    outdf <- reactive(
        {
            df<- Lab05::aqiGet()
            temp<-df[[as.numeric(input$city)]]
            temp<-as.data.frame(temp)
        }
    )
    
    output$Plot <- renderPlot({
        
        # generate bins based on input$bins from ui.R
        plot(outdf(), col = "blue", xlab = ("Time"), ylab = ("PM10 µg/m³"))+
            abline(h=mean(outdf()$value), col = "red")
    })
    
    shinyApp(shinyUI, server)
    
})

# Run the application 
shinyApp(ui = ui, server = server)
