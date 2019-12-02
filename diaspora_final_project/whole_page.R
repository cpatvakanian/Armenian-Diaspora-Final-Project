# Here I am loading in the library

library(shiny)

# The ui specifies what we are going to output for the graphics,
# and in this specific case I am saying I want to have the
# website show a title, and two pages which say graphic and about

ui <- navbarPage("Armenian Diaspora Project",
                 tabPanel("Community Information", fluidPage(imageOutput('map'))),
                 tabPanel("Diaspora Data Highlights", fluidPage(imageOutput('map'))),
                 tabPanel("What Influences Number of Communities", fluidPage(imageOutput('map'))),
                 tabPanel("About", fluidPage(textOutput('text'))))



# Here, server defines what that output we specified earlier will be
# and now we are actually assigning that output to be our graphic
# and our description for the about.

server <- function(input, output)
    output$text <- renderText({
        "The graphic here is of a map which shows stops of red toyotas in Oklahoma, by date ."
    })

# Here I am running the output. This is how
# my actual app is run because we are calling the 
# information we had previously

shinyApp(ui = ui, server = server)