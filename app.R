# Dummy Data Reviewer Dashboard

library(tidyverse)
library(DT)
library(shiny)
library(shinythemes)

# Import & Format Data
master <- read.csv("dummymaster.csv", fileEncoding = "UTF-8-BOM")
mastercolumns2hide <- c(2, 9, 10)
articlesreviewed <- read.csv("dummyarticlesreviewed.csv", fileEncoding = "UTF-8-BOM")
articlesauthored <- read.csv("dummyarticlesauthored.csv", fileEncoding = "UTF-8-BOM")
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
              selection = list(mode = "multiple", target = "row")
              )
    })


  output$articlesreviewed <- renderDataTable({
    selectedrows <- master[input$master_rows_selected,]
    datatable(articlesreviewed[articlesreviewed$ORCID %in% selectedrows$ORCID,],
              options = list(lengthChange = FALSE,
                             searching = FALSE,
                             paging = FALSE,
                             columnDefs = list(list(visible = FALSE, targets = reviewercolumns2hide))
                             ),
              rownames = FALSE,
              selection = "none"
              )
    })

  output$articlesauthored <- renderDataTable({
    selectedrows <- master[input$master_rows_selected,]
    datatable(articlesauthored[articlesauthored$ORCID %in% selectedrows$ORCID,],
              options = list(lengthChange = FALSE,
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
