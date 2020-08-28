#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(shinyjs) #shiny javascript package: https://deanattali.com/shinyjs/
library(shinyBS) #shiny bootstrap package: https://ebailey78.github.io/shinyBS/
library(DT)

### loading helper code
# loads the data onto the map
source("load_data.R")
# contains the part of the app
source("app_parts.R")

# Define UI for application
shinyUI(tagList(
        useShinyjs(),
        navbarPage(
                   title = "HER Map",
                   theme = "style/hermap_style.css",
                   fluid = TRUE,
                   collapsible = TRUE,
                   #--------------------------
                   #tab panel 1 - Home
                   tabPanel("Home"),
                   #--------------------------
                   #tab panel 2 - HER Map Viewer
                   tabPanel("HER Map Viewer",
                            # function in app_parts that allows you to view the map.
                            hermapViewer()
                   ),
                    tabPanel("HER Map Resource Listing",
                             # function in app_parts that allows you to see the resource listing.
                             hermapListing()
                             ),
                   #--------------------------
                   #tab panel 3 - Collaborators
                   tabPanel("Collaborators"),
                   #--------------------------
                   #tab panel 4 - About
                   tabPanel("About")
                  )
              )

          )
