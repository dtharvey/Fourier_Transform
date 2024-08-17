# ui for fourier transform
library(shiny)
library(shinythemes)

ui = navbarPage("AC 3.0: The Fourier Transform",
                theme = shinytheme("journal"),
                header = tags$head(
                  tags$link(rel = "stylesheet",
                            type = "text/css",
                            href = "style.css")
          ),
              tabPanel("Introduction",
                fluidRow(
                  withMathJax(),
                  column(width = 6,
                    wellPanel(
                      includeHTML("text/introduction.html")
          )     
          ),
          
          column(width = 6,
          plotOutput("introplot",height = "750px")
          ))), # close introduction tabpanel
          
                tabPanel("FT of A Single Peak",
                    fluidRow(
                      column(width = 6,
                             wellPanel(
                               includeHTML("text/onepeak.html")
                             )),
                    column(width = 6,
                         align = "center",
                    splitLayout(
                      selectInput("peaktype", "peak type",
                                   choices = c("Gaussian","Lorentzian",
                                               "Voigt"),
                                   selected = "Gaussian",
                                   selectize = FALSE),
                      sliderInput("p1","peak position",
                                  min = 25, max = 75, value = 25,
                                  width = "150px", step = 1),
                      sliderInput("w1","Peak width",
                                  min = 5, max = 10, value = 5,
                                  width = "150px", step = 0.1),
                      sliderInput("a1","Peak area",
                                  min = 5, max = 10, value = 5,
                                  width = "150px", step = 0.1)
          ),
                    
                    plotOutput("onepeak", height = "650px")
          )
          )
          ),# close one peak tabpanel
          
          tabPanel("FT of Two Peaks",
                   fluidRow(
                     column(width = 6,
                            wellPanel(
                              includeHTML("text/twopeaks.html")
                            )),
                     column(width = 6,
                            align = "center",
                            splitLayout(
                              radioButtons("include", "include peaks",
                                           choices = c("1 only", 
                                                       "2 only",
                                                       "1 and 2"),
                                           selected = "1 and 2"),
                              sliderInput("p2a","peak 1: position",
                                          min = 25, max = 75, value = 40,
                                          width = "150px", step = 1),
                              sliderInput("w2a","Peak 1: width",
                                          min = 5, max = 10, value = 5,
                                          width = "150px", step = 0.1),
                              sliderInput("a2a","Peak 1: area",
                                          min = 5, max = 10, value = 10,
                                          width = "150px", step = 0.1)
                            ),
                            splitLayout(
                              p(""),
                              sliderInput("p2b","peak 2: position",
                                          min = 25, max = 75, value = 60,
                                          width = "150px", step = 1),
                              sliderInput("w2b","Peak 2: width",
                                          min = 5, max = 10, value = 5,
                                          width = "150px", step = 0.1),
                              sliderInput("a2b","Peak 2: area",
                                          min = 5, max = 10, value = 10,
                                          width = "150px", step = 0.1)
                            ),
                            plotOutput("twopeaks", height = "575px")
                     )
                   )
          ),# close two peak tabpanel
          
          tabPanel("Wrapping Up",
                   fluidRow(
                     column(width = 6,
                            wellPanel(id = "wrapuppanel",
                                      style = "overflow-y:scroll; max-height: 750px",
                              includeHTML("text/wrapup.html")
                            )),
                     column(width = 6,
                            align = "center",
                   plotOutput("wrapup", height = "700px")
                     )
                   ))
          )# close ui
