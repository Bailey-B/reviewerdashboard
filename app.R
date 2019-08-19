# Dummy Data Reviewer Dashboard

library(tidyverse)
library(DT)
library(shiny)
library(shinythemes)
library(readr)

# Import & Format Data
master <- read.csv("dummymaster.csv")
mastercolumns2hide <- c(2, 9, 10)
articlesreviewed <- read.csv("dummyarticlesreviewed.csv")
articlesauthored <- read.csv("dummyarticlesauthored.csv")
reviewercolumns2hide <- c(3)

# Create UI
ui <- 
  fluidPage(
    titlePanel("Reviewer Pool"),
      mainPanel(
        tabsetPanel(
          tabPanel("Reviewer List",
                   p("Select reviewers in this tab to filter results in the next two tabs."),
                   dataTableOutput("master")),
          tabPanel("Articles Reviewed by Selected Reviewers",
                   dataTableOutput("articlesreviewed")),
          tabPanel("Articles Authored by Selected Reviewers",
                   dataTableOutput("articlesauthored"))
    )
    )
  )


server <- function(input, output, session) {
  
  output$master <- renderDataTable({
    datatable(master,
              options = list(pageLength = nrow(master),
                             lengthChange = FALSE,
                             searching = TRUE,
                             paging = FALSE,
                             columnDefs = list(list(visible = FALSE, targets = mastercolumns2hide))
                             ),
              filter = "top",
              rownames = FALSE,
              selection = "multiple"
              )
    })


  output$articlesreviewed <- renderDataTable({
    selectedORCIDS <- master[input$master_rows_selected, match("ORCID", names(master))] 
    datatable(articlesreviewed[articlesreviewed$ORCID == selectedORCIDS,],
              options = list(pageLength = nrow(articlesreviewed),
                             lengthChange = FALSE,
                             searching = FALSE,
                             paging = FALSE,
                             columnDefs = list(list(visible = FALSE, targets = reviewercolumns2hide))
                             ),
              rownames = FALSE,
              selection = "none"
              )
    })

  output$articlesauthored <- renderDataTable({
    selectedORCIDS <- master[input$master_rows_selected, match("ORCID", names(master))] 
    datatable(articlesauthored[articlesauthored$ORCID == selectedORCIDS,],
              options = list(pageLength = nrow(articlesauthored),
                             lengthChange = FALSE,
                             searching = FALSE,
                             paging = FALSE,
                             columnDefs = list(list(visible = FALSE, targets = reviewercolumns2hide))
                             ),
              rownames = FALSE,
              selection = "none"
              )
    })

}

shinyApp(ui, server)
