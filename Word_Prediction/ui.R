#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

library(shiny)
library(dplyr)
library(stringr)
library(stringdist)
library(textclean)
library(quanteda)
library(igraph)
library(Matrix)
library(doParallel)
library(foreach)
library(DT)



# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
        titlePanel(title=div("Word Prediction",
                             
                img(src="JHL.png"),img(src="Coursera_Logo.jpg",width=150))),
                HTML("<strong>Author: D. Lemieux</strong>"),br(),
                HTML("<strong>Date: June 11 2018</strong>"),
        
 
  
  # Sidebar with a slider input for number of bins 
        sidebarLayout(
                sidebarPanel(
                        textInput("source","The sentence to complete:",value = ""),
                        actionButton("run","Run the Prediction")
                        
    

                                ),
                mainPanel(
                        tabsetPanel(type="tab",
                                    tabPanel("Summary",
                                             h4("WordCloud of the different frequency of words"),
                                            tags$img(src='WordCloud.png',height="400",width="700",align="right"),br(),
                                            h4("Summary of the current apps"),
                                            includeMarkdown("Summary.md"),
                                            tags$img(src='sun.jpg',height="50",width="50",align="center")),
                                    tabPanel("Methodology",
                                             h4("Summary of the current methodology"),
                                             includeMarkdown("Metho.md")),
                                    tabPanel("Algorithm",
                                             h3("The 4 most common following words are:"),
                                             DT::dataTableOutput('prediction'))
                                    
                                    )
                        
                )
                        )
        
        )
)

