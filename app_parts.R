hermapViewer <- function(){
  bootstrapPage(div(class = "outer",
                    tags$style(type = "text/css",
                               ".outer {position: fixed; top: 41px; left: 0; right: 0; 
                                                         bottom: 0; overflow: hidden; padding: 0}"),
                    leafletOutput("hermap", width = "100%", height = "100%" )),
                    absolutePanel(id = "filter", class = "panel panel-default", fixed = TRUE,
                                  draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                  width = 330, height = "auto",
                                  h2("HER Map"),
                                  #----------------------
                                  # filtering options
                                  selectInput("state", "State", choices = c("All", select_state), selected = "All"),
                                  selectInput("city", "City",  choices = c("All", select_city), selected = "All"),
                                  selectInput("category", "Category",  choices = c("All", select_category), selected = "All")
                                  )
              
                    )
  
  
}
  
hermapListing <- function(){
  bootstrapPage(
                    titlePanel("HER Map Resource Listing"),
                    fluidRow(
                      column(4,
                             selectInput("table_state",
                                         "State",
                                         c("All", select_state))
                                         ),
                      column(4,
                             selectInput("table_city",
                                         "City",
                                         c("All", select_city))
                                         ),
                      column(4,
                             selectInput("table_category",
                                         "Category",
                                         c("All", select_category))
                                         ),
                ),
  DTOutput("hermap_table")
  )
}

