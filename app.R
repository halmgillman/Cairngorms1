# Libraries
library(shiny)
library(DT)

# Data load
source("data-input.r")

# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel(
        "Cairngorms1: Test App - Renewable Energy Sites in the Highlands"
        ),
    sidebarLayout(
        sidebarPanel(
            selectizeInput(
                'table_select',
                label = "Select report:",
                choices = c(
                    "What class are these sites?",
                    "What status do these sites have?"
                    ))
        ),
        mainPanel(
            paste0(
                "There are ",
                as.character(no_of_sites),
                " renewable energy sites in this region."
                ),
            dataTableOutput("table")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output){

observe({

    if (input$table_select == "What class are these sites?"){
        output$table <- renderDataTable(
            datatable(
                class_summary,
                options = list(searching = FALSE)
                )
        )
    }

    else if (input$table_select == "What status do these sites have?"){
        output$table <- renderDataTable(
            datatable(
                construction_status_summary,
                options = list(searching = FALSE)
                )
        )
    }

})

}

# Run the application
shinyApp(ui = ui, server = server)
