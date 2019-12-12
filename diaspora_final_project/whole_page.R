# Here I am loading in the library

library(shiny)
library(readr)
library(httr)
library(knitr)
library(anytime)
library(moderndive)
library(gt)
library(maps)
library(png)
library(ggplot2)
library(fs)
library(sf)
library(dplyr)
library(reprex)
library(stringr)
library(gganimate)
library(vembedr)


# The ui specifies what we are going to output for the graphics,
# and in this specific case I am saying I want to have the
# website show a title, and two pages which say graphic and about

diasporas <- read_rds("./diasporasA.rds")
histo.df <- read_rds("./histo.rds")
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
                        column(align = "center", width = 12,
                        h1("Welcome to the Armenian Diaspora Project"),
                        h3("Learn more about where Armenian Diaspora Communities exist and how they got there!"),
                        plotOutput("world_map"),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        p("As you can see, there are many countries around the world which have Armenian diaspora communties. Those countries shown on this graph
                        are ones which have communities of at least 1000 Armenians. However, there are also some countries which have multiple communities!"),
                        br(),
                        br(),
                        br(),
                        h2("How many communities are there typically in countries which have an Armenian diaspora?"),
                        br(),
                        p("Using the slider below, we can try to get a grasp of how many countries have a particular
                           number of Armenian diaspora communities. For example, we see only one country, which is Russia,
                           has 16 diaspora communities, whearas many countries have only one or two diaspora communities. As
                           you decrese the binwidth, the columns of the histogram put together the country observations. We see
                           that the data is right skewed, shows that there are generally more countries with small numbers of
                           communities."),
                        plotOutput('distPlot'),
                        sliderInput("bins",
                                    "Bin Width",
                                    min = 1,
                                    max = 26,
                                    width = 900,
                                    value = 40),
                        br(),
                        br(),
                        br(),
                        h2("Highlights of Communities on Different Continents"),
                        br(),
                        plotOutput("latin_map"),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        p("In South America, there are few countries, Argentina, Brazil and Uruguay, which have major
                           Armenian Diaspora communities. These were primarily formed after the Armenian Genocide
                           and also the result of some migration from Europe and Lebanon after WW2."),
                        plotOutput("eurasia_map"),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        p("In Eurasia, a lot Armenians have diaspora communities because the geographic proximity 
                           to the Armenian homeland and also historical connections. The majority of diaspora communities 
                           are in Europe and Central Asia."),
                        br(),
                        br()
               )),
               tabPanel("Populations of Diaspora Communities",
                        h2("Population of Diaspora Communities"),
                        h4("Check out the bar graphs below to see how populous the Armenian communities
                           are in various countries around the world."),
                        br(),
                        br(),
                        br(),
                        sidebarLayout(
                          sidebarPanel(
                            selectInput(
                              inputId = "input_1",
                              label = "Population of Communities in Various Countries",
                              choices = c(
                                "Argentina" = "Argentina",
                                "Brazil" = "Brazil",
                                "Bulgaria" = "Bulgaria",
                                "Canada" = "Canada",
                                "Egypt" = "Egypt",
                                "France" = "France",
                                "Georgia" = "Georgia",
                                "Germany" = "Brazil",
                                "Greece" = "Greece",
                                "Iran" = "Iran",
                                "Iraq" = "Iraq",
                                "Israel" = "Israel",
                                "Kazakhstan" = "Kazakhstan",
                                "Lebanon" = "Lebanon",
                                "Russia" = "Russia",
                                "Sweden" = "Sweden",
                                "Switzerland" = "Switzerland",
                                "Syria" = "Syria",
                                "Turkey" = "Turkey",
                                "Turkmenistan" = "Turkmenistan",
                                "United Kingdom" = "UK",
                                "Ukraine" = "Ukraine",
                                "United States" = "United States",
                                "Uruguay" = "Uruguay",
                                "Uzbekistan" = "Uzbekistan"
                              )
                            )
                          ),
                        mainPanel(plotOutput("Eurasian_Diaspora")))),
               tabPanel("Diaspora Data Highlights",
                        column(align = "center", width = 12,
                        h1("Types of Diaspora Communities"),
                        plotOutput("historic"),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        p("Some diaspora communities have existed historical over the area of the Armenian highlands. Others have formed simply due to economic migration factors."),
                        plotOutput("diasporasgenocide"),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        p("Diasporas formed after the Armenian Genocide, as people were fleeing persecution from the Turks in 1915. That is main reason for large diaspora communities which exist in France, the US, Canada, Syria and Lebanon. "),
                        plotOutput("postsoviet"),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        p("Armenian communities existed in the countries you see on above during the Soviet Union Many Armenians had moved around the USSR and did not travel to countries which they were not permitted to. 
                           However, many Armenians also started moving to Western Countries once the USSR collapsed.")
               )),
               tabPanel("What Influences Number of Communities & Population",
                        column(align = "center", width = 12,
                        br(),
                        br(),
                        h2("Correlation of Population and Number of Communities"),
                        plotOutput("regression"),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        p("Here I have used a simple linear regression to understand how population 
                           is related to the number of communities in a country. Obviously, this is a very
                           rudimentary analysis and there is a high possibility of reverse casaulty. But we can 
                           see that there is a positive correlation between population and number of communities 
                           in a country, which makes sense, as the more people you have likely would result in those 
                           people wanting to form communities."),
                        br(),
                        br(),
                        h2("Multivariate Linear Regression of Population on Various Regressors"),
                        br(),
                        htmlOutput("regression1"),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        p("The model I have above is a multivariate linear regression, where Y = a + Bx, where Y is my dependent variable for population and I have intercept 'a' with multiple 'B' coefficients for multiple x variables.
                        I am interpreting my regression using the Frequentist perspective, and the coefficients for each variable state that for a 1 unit increase in x, we expect to a change in y for whatever
                        coefficient we see. My x regressor variables are as follows: 'Top Ten Genocide Search' and 'Top Ten Duxov Search' mean that a country was a part of the top 10 countries which searched the term
                        Armenian Genocide or Duxov. I included these variables because I thought it would be an interesting measure of community strength and presence, and used Google Trends to categorize both as binary variables
                        a 1 being if a country in the top 10 list and 0 if it was not. The 'Number of Communities' is the number of communities there is in country, and is a continous variable. The 'Has an Armenian Embassy' variable is
                        if the country has an Armenian Embassy in it, and is a binary variable for 1 if there is an embassy and 0 if there is no embassy. The final variable is the 'Post Soviet', which is an indicator variable that 
                        shows a 1 if the country was formerly a member of the Soviet Union, and 0 if the country was not. The intercept is the baseline population of Armenian communities in my dataset."), 
                        p("
                        My data and model is problematic, to say the least. I only have 26 observations and I have used population estimates and official number from Wikipedia, which have been
                        compiled from sources which are outdated. Nonetheless, I can try to interpret what these numbers mean. We can see that none of the coefficients have any statistical significance
                        except for population, which is positive, something that is pretty obvious. Basically, this regression, from a Frequentist perspective, is saying for an additional community in a
                        country, we see an associated increase in Armenian diaspora population of 6,9434 people. I have tried to account for the fact that Russia is a huge outlier by removing it from the 
                        dataset, which at least helps the data be not as biased. As we can see with the R^2 and the Adjusted R^2, my model does a poor job of explaining population.
"),
                        )),
               tabPanel("About", 
                        column(align = "center", width = 12,
                        h2("About the Armenian Diaspora Data Project"),
                        p("This project is trying to better understand the trends and characteristics of the Armenian Diaspora communities which exist all over the world. Armenian Diaspora communities have existed for hundreds of years, but the primary large communities that scattered and exist today come from two major events in Armenian history. The first event was the Armenian Genocide of 1915, during which 1.5 Armenians and many other Christian minorities such as the Assyrians and Greeks were killed due to the genocidal campaign of the Ottoman Turkish government. The result of the genocide was the mass exodus of Armenians to countries such as Syria, France, Lebanon, Russia, the United States, Australia and even Argentina. The second major event which explains the diaspora communities of that exist in other parts of the world was the collapse of the USSR and subsequent socio-economic crisis, after which many Armenians immigrated to the United States, Russia, and various other countries. Of course, there also exist other older, but much smaller community in Jerusalem - which has ties back to ancient Armenian religious ties."),
                        h2("Data on the Diaspora"),
                        p("Finding data on the Armenian diaspora is notoriously difficult, but Wikipedia and Google trends are able to capture a rough idea of where Armenians are generally located. By looking at compilations of various sources on Wikipedia's Armenian diaspora Communities page ", a( "Armenian diaspora Communities page", href = "https://en.wikipedia.org/wiki/Largest_Armenian_diaspora_communities")," I am able to confirm for a variety of countries the number of communities and also the populations of those communities. Additionally, by looking at data on the ", a( "Google Trends Website", href = "https://trends.google.com/trends/?geo=US")," I am able to look at these countries and try to look at trends or key words for Armenians that I think might confirm the census data. Interestingly, there are different and similar trends for Armenians depending on which community we are looking at (old vs newly formed)."),
                        h2("About the Author"),
                        p("I am a senior at Harvard College studying Economics with a minor in Government."),
                        h2("Video About the Project"),
                        p("Check out this video about my Shiny App project!"),
                        br(),
                        br(),
                        embed_youtube("nTIfHxcn2v0"),
                        h2("Submission to The Undergraduate Statistics Project Competition"),
                        p("I wrote a paper about this project to enter a contest called the The Undergraduate Statistics Project Competition.
                          Check it out below!"),
                        tags$iframe(style="height:400px; width:70%; scrolling=yes",
                                    src="Gov_1005_paper.pdf")
               ))))

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
    
    datareact1 <- reactive({
      diasporas %>%
        filter(str_detect(Country,fixed(input$input_1)))
    })
    
    
    output$Eurasian_Diaspora <- renderPlot({
      diasporas %>%
        filter(str_detect(Country,fixed(input$input_1))) %>%
        mutate(Population = Population/1000) %>%
        ggplot(aes(x=Area, y=Population)) + geom_col(color="red", fill = "red") +
        labs(
          title=paste("Population of Communities in", input$input_1),
          subtitle = "Population measured in 1000s",
          x=paste("Communities in", input$input_1),
          y="Population") +
        theme(
          axis.text.x = element_text(face = "bold", size = 12, angle = 45, hjust = 1),
              axis.text.y = element_text(face = "bold",  size = 12, angle = 45, hjust = 1)
              )
    })
    
    getPage <- function() {
      return(includeHTML("regression.html"))
    }
    
    output$regression1 <- renderUI({
      
      getPage()})
    
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- histo.df[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        hist(x, breaks = bins, col = 'black', border = 'white',
             xlab = "Number of Communities in a Country",
             ylab = "Number of Countries",
             xlim = c(0,20),
             main = "Frequencies of Community Sizes")
       
    })
}
shinyApp(ui = ui, server = server)