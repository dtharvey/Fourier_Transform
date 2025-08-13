# ui for fourier transform learning module

ui = navbarPage("AC 3.0: The Fourier Transform",
                theme = shinytheme("journal"),
                header = tags$head(
                  tags$link(rel = "stylesheet",
                            type = "text/css",
                            href = "style.css")
          ),
          
  # introduction
              tabPanel("Introduction",
                fluidRow(
                  withMathJax(),
                  column(width = 6,
                    wellPanel(
                      class = "scrollable-well",
                      div(
                        class = "html-fragment",
                        includeHTML("text/introduction.html")
          ))),
          
          column(width = 6,
          plotOutput("introplot",height = "550px")
          ))), # close introduction tabpanel
 
  # first activity         
                tabPanel("FT of A Single Peak",
                    fluidRow(
                      column(width = 6,
                             wellPanel(
                               class = "scrollable-well",
                               div(
                                 class = "html-fragment",
                                includeHTML("text/activity1.html")
                             ))),
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
                    
                    plotOutput("onepeak", height = "550px")
          )
          )
          ),# close one peak tabpanel
          
  # second activity  
          tabPanel("FT of Two Peaks",
                   fluidRow(
                     column(width = 6,
                            wellPanel(
                              class = "scrollable-well",
                              div(
                                class = "html-fragment",
                               includeHTML("text/activity2.html")
                            ))),
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
                            plotOutput("twopeaks", height = "400px")
                     )
                   )
          ),# close two peak tabpanel
          
  # wrapping up
          tabPanel("Wrapping Up",
                   fluidRow(
                     column(width = 6,
                            wellPanel(
                              class = "scrollable-well",
                              div(
                                class = "html-fragment",
                               includeHTML("text/wrapup.html")
                            ))),
                     column(width = 6,
                            align = "center",
                   plotOutput("wrapup", height = "600px")
                     )
                   ))
          )# close ui
