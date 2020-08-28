#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(here)

### loading helper code
# loads the data onto the map
#source("load_data.R")
# contains the part of the app
#source("app_parts.R")


#filtering the dataset
#filtered_category <- reactive({
#  data <- poi %>%
#    filter(Category = input$category)
    
#})



server <- function(input, output, session){
  

   
   
   #selecting by state
 
 # observe({
 #   updateSelectInput(
 #     session,
 #     "table_state",
 #     choices = select_state
 #   )
 # })

#selecting by city
#  observe({
#    updateSelectInput(session, 
#                     "city",
#      choices = poi %>%
#        filter(City == input$city)  
#    )
    
#  })
  
#selecting category based on city
observe({
  updateSelectInput(session,
                    "category",
                    choices =  c(poi %>%
                      filter(City == input$city) %>%
                      select(Category) %>%
                      .[[1]],
                    "All")

                    )
})
   
   
# table
   # observe({
   #    updateSelectInput(session,
   #                      "table_category",
   #                      choices =  c(poi %>%
   #                                      filter(City == input$table_city) %>%
   #                                      select(Category) %>%
   #                                      .[[1]],
   #                                   Choose = '')
   #                      
   #    )
   # })
   
  

 
 state_filter_variable <- reactive({
   hermap_data <- poi %>%
     filter(State == input$state)
 })
 
 city_filter_variable <- reactive({
   hermap_data <- poi %>%
     filter(State == input$state) %>%
     filter(City == input$city)
 })
 
 category_filter_variable <- reactive({
   hermap_data <- poi %>%
     filter(State == input$state) %>%
     filter(City == input$city) %>%
     filter(Category == input$category) 
   
 }) 

 # Leaflet map
 
 # creating icons
 icons <- awesomeIcons(
   icon = "map-marker",
   iconColor = "#FFFFFF",
   library = "fa",
   markerColor = "purple"
 )
 
 popup <- paste("Name:", poi$Name,
            "<br>",
            "Address:", poi$Address,
            "City:", poi$City,
            "<br>",
            "State:", poi$State,
            "<br>",
            "Zip:", poi$Zipcode,
            "<br>",
            "Contact Person:", poi$Contact_Person,
            "<br>",
            "Email:", poi$Email,
            "<br>",
            "Phone Number:", poi$Phone,
            "<br>",
            "Website:", poi$Website)
 

 
 #this map isn't going to change.
 output$hermap <- renderLeaflet({
   leaflet(poi) %>%
     addTiles() %>%
     addAwesomeMarkers(icon = icons,
                       popup = ~popup) %>%
     setView(lng = -93.85, lat = 37.45, zoom = 4)
   
 })
 

 
   observeEvent(input$state, 
                {
                   state_popup <- paste("Name:", state_filter_variable()$Name,
                                        "<br>",
                                        "Address:", state_filter_variable()$Address,
                                        "City:", state_filter_variable()$City,
                                        "<br>",
                                        "State:", state_filter_variable()$State,
                                        "<br>",
                                        "Zip:", state_filter_variable()$Zipcode,
                                        "<br>",
                                        "Contact Person:", state_filter_variable()$Contact_Person,
                                        "<br>",
                                        "Email:", state_filter_variable()$Email,
                                        "<br>",
                                        "Phone Number:", state_filter_variable()$Phone,
                                        "<br>",
                                        "Website:", state_filter_variable()$Website)
                  
                  
                  leafletProxy("hermap") %>%
                    clearMarkers() %>%
                    addAwesomeMarkers(data = state_filter_variable(),
                                      icon = icons, popup = ~state_popup)
                  
                })
   
   observeEvent(input$city, 
                {
                   city_popup <- paste("Name:", city_filter_variable()$Name,
                                       "<br>",
                                       "Address:", city_filter_variable()$Address,
                                       "City:", city_filter_variable()$City,
                                       "<br>",
                                       "State:", city_filter_variable()$State,
                                       "<br>",
                                       "Zip:", city_filter_variable()$Zipcode,
                                       "<br>",
                                       "Contact Person:", city_filter_variable()$Contact_Person,
                                       "<br>",
                                       "Email:", city_filter_variable()$Email,
                                       "<br>",
                                       "Phone Number:", city_filter_variable()$Phone,
                                       "<br>",
                                       "Website:", city_filter_variable()$Website)
                  
                  
                  leafletProxy("hermap") %>%
                    clearMarkers() %>%
                   addAwesomeMarkers(data = city_filter_variable(),
                                     icon = icons, popup = ~city_popup)
                  
                })
   
   observeEvent(input$category, 
                {
                   
                   category_popup <- paste("Name:", category_filter_variable()$Name,
                                          "<br>",
                                          "Address:", category_filter_variable()$Address,
                                          "City:", category_filter_variable()$City,
                                          "<br>",
                                          "State:", category_filter_variable()$State,
                                          "<br>",
                                          "Zip:", category_filter_variable()$Zipcode,
                                          "<br>",
                                          "Contact Person:", category_filter_variable()$Contact_Person,
                                          "<br>",
                                          "Email:", category_filter_variable()$Email,
                                          "<br>",
                                          "Phone Number:", category_filter_variable()$Phone,
                                          "<br>",
                                          "Website:", category_filter_variable()$Website)
                  leafletProxy("hermap") %>%
                    clearMarkers() %>%
                    addAwesomeMarkers(data = category_filter_variable(),
                                      icon = icons,
                               popup = ~category_popup)
                })
   

### DATA TABLE ###
col <- "geom"
   
   output$hermap_table <- renderDT({
     DT::datatable({
       table_data <- tibble(poi) %>%
          select(-geom)
       
       if(input$table_state != "All"){
          table_data <- table_data[table_data$State == input$table_state,]
       }
       if(input$table_city != "All"){
          table_data <-table_data[table_data$City == input$table_city,]
       }
       if(input$table_category != "All"){
          table_data <- table_data[table_data$Category == input$table_category,]
       }
       table_data 
     })

   })



    }
  

 
#   
#   leafletProxy("hermap") %>%
#     clearMarkers() %>%
#     addMarkers(data = poi, #add filtered_category if it messes up
#                popup = ~paste("Name:", Name,
#                               "<br>",
#                               "Category:", Category,
#                               "<br>",
#                               "City:", City,
#                               "<br>",
#                               "State:", State))
#   
#   
# }    
# 
# if(input$state == poi$State){
#   
# 
#      
#     leafletProxy("hermap") %>%
#       clearMarkers() %>%
#       addMarkers(data = filtered_variable(), #add filtered_category if it messes up
#                  popup = ~paste("Name:", Name,
#                                 "<br>",
#                                 "Category:", Category,
#                                 "<br>",
#                                 "City:", City,
#                                 "<br>",
#                                 "State:", State))
# }
      
#  })  
    
 
    
 #}

