# Here I am loading in the library

library(shiny)
library(readr)
library(httr)
library(knitr)
library(lubridate)
library(anytime)
library(moderndive)
library(gt)
library(maps)
library(png)


# The ui specifies what we are going to output for the graphics,
# and in this specific case I am saying I want to have the
# website show a title, and two pages which say graphic and about

histo.df <- read_rds("histo.rds")
world_map <- readPNG("world_map.png")
eurasia_map <- readPNG("eurasia_map.png")
latin_map <- readPNG("latin_map.png")
regression <- readPNG("regression.png")
historic <- readPNG("historic.png")
diasporasgenocide <- readPNG("diasporasgenocide.png")
postsoviet <- readPNG("postsoviet.png")

ui <- fluidPage(
    navbarPage("Armenian Diaspora Project",
               tabPanel("Community Information",
                        h1("Welcome to the Armenian Diaspora Project"),
                        h3("Learn more about where Armenian Diaspora Communities exist and how they got there!"),
                        plotOutput("world_map"),
                        br(),
                        br(),
                        br(),
                        br(),
                        plotOutput('distPlot'),
                        sliderInput("bins",
                                    "Number of bins:",
                                    min = 1,
                                    max = 30,
                                    width = 900,
                                    value = 40),
                        plotOutput("latin_map"),
                        plotOutput("eurasia_map"),
               ),
               
               tabPanel("Diaspora Data Highlights",
                        h1("Types of Diaspora Communities"),
                        plotOutput("historic"),
                        br(" "),
                        br(" "),
                        br(" "),
                        h3("Some diaspora communities have existed historical over the area of the Armenian highlands. Others have formed simply due to economic migration factors"),
                        plotOutput("diasporasgenocide"),
                        br(" "),
                        br(" "),
                        h3("Diasporas formed after the Armenian Genocide, as people were fleeing persecution from the Turks in 1915. That is main reason for large diaspora communities which exist in France, the US, Canada, Syria and Lebanon. "),
                        plotOutput("postsoviet"),
                        br(" "),
                        br(" "),
                        h3("Diasporas existed in places after the collapse of the USSR, as many Armenians had moved around the USSR and did not travel to countries which they were not permitted to. Additionally, many Armenians started moving to Western Countries once the USSR collapsed."),
               ),
               tabPanel("What Influences Number of Communities",
                        plotOutput("regression"),
                        br(" "),
                        br(" "),
                        br(" "),
                        br(" "),
                        br(" "),
                        br(" "),
                        h3("Here I have used a simple linear regression to understand how population is related to the number of communities in a country. Obviously, this is a very rudimentary analysis and there is a high possibility of reverse casaulty. But we can see that there is a positive correlation between population and number of communities in a country, which makes sense, as the more people you have likely would result in those people wanting to form communities."),
                        
                        ),
               tabPanel("About", 
                        h2("About the Armenian Diaspora Data Project"),
                        h5("This project is trying to better understand the trends and characteristics of the Armenian Diaspora communities which exist all over the world. Armenian Diaspora communities have existed for hundreds of years, but the primary large communities that scattered and exist today come from two major events in Armenian history. The first event was the Armenian Genocide of 1915, during which 1.5 Armenians and many other Christian minorities such as the Assyrians and Greeks were killed due to the genocidal campaign of the Ottoman Turkish government. The result of the genocide was the mass exodus of Armenians to countries such as Syria, France, Lebanon, Russia, the United States, Australia and even Argentina. The second major event which explains the diaspora communities of that exist in other parts of the world was the collapse of the USSR and subsequent socio-economic crisis, after which many Armenians immigrated to the United States, Russia, and various other countries. Of course, there also exist other older, but much smaller community in Jerusalem - which has ties back to ancient Armenian religious ties."),
                        h2("Data on the Diaspora"),
                        h5("Finding data on the Armenian Diaspora is notoriously difficult, but Wikipedia and Google trends are able to capture a rough idea of where Armenians are generally located. By looking at compilations of various sources on Wikipedia's Armenian Diaspora Communities page (https://en.wikipedia.org/wiki/Largest_Armenian_diaspora_communities), I am able to confirm for a variety of countries the number of communities and also the populations of those communities. Additionally, by looking at data on the Google Trends Website (https://trends.google.com/trends/?geo=US), I am able to look at these countries and try to look at trends or key words for Armenians that I think might confirm the census data. Interestingly, there are different and similar trends for Armenians depending on which community we are looking at (old vs newly formed)."),
                        h2("About the Author"),
                        h5("I am a senior at Harvard College studying Economics with a minor in Government.")
               )))

# Here, server defines what that output we specified earlier will be
# and now we are actually assigning that output to be our graphic
# and our description for the about.

server <- function(input, output){
    
    output$world_map <- renderImage({
        filename <- "world_map.png"
        list(src = filename)
        },deleteFile = FALSE)
    
    output$latin_map <- renderImage({
        filename <- "latin_map.png"
        list(src = filename)
    },deleteFile = FALSE)
    
    output$eurasia_map <- renderImage({
        filename <- "eurasia_map.png"
        list(src = filename)
    },deleteFile = FALSE)
  
    output$regression <- renderImage({
        filename <- "regression.png"
        list(src = filename)
    },deleteFile = FALSE)  
    
    output$historic <- renderImage({
        filename <- "historic.png"
        list(src = filename)
    },deleteFile = FALSE)
    
    output$diasporasgenocide <- renderImage({
        filename <- "diasporasgenocide.png"
        list(src = filename)
    },deleteFile = FALSE)
    
    output$postsoviet <- renderImage({
        filename <- "postsoviet.png"
        list(src = filename)
    },deleteFile = FALSE)
    
    
    
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- histo.df[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        hist(x, breaks = bins, col = 'black', border = 'white',
             xlab = "Number of Communities in a Country",
             main = "Frequencies of Community Sizes in a Country")
    })
}
# Here I am running the output. This is how
# my actual app is run because we are calling the 
# information we had previously

shinyApp(ui = ui, server = server)