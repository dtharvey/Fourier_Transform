# server for fourier transform

library(shiny)
library(shinythemes)

# set colors
palette("Okabe-Ito")

# create data for introduction
t = seq(0,2,0.001)
f = 1
yt = sign(sin(2*pi*f*t))
yt[length(yt)] = 0
k = seq(1,10,1)
A = 4/pi * 1/(2*k-1)
a = 2*k - 1
y1 = A[1] * sin(2*pi*a[1]*f*t)
y2 = A[2] * sin(2*pi*a[2]*f*t)
y3 = A[3] * sin(2*pi*a[3]*f*t)
y4 = A[4] * sin(2*pi*a[4]*f*t)
y5 = A[5] * sin(2*pi*a[5]*f*t)

# read in data for wrap up
urea = read.csv(file = "data/urea.csv")

shinyServer(function(input,output,session){
  
  output$introplot = renderPlot({
    old.par = par(mfrow = c(3,1))
    plot(x = t, y = yt, type = "l", xlab = "time (s)", ylab = "amplitude",
         lwd = 4, col = 6, cex.axis = 1.5, cex.lab = 1.5, 
         ylim = c(-1.5,1.5), cex.main = 1.5,
         main = "time domain")
    grid(lwd = 1, col = 1)
    plot(x = a, y = A, type = "h", xlab = "frequency", 
         ylab = "amplitude", lwd = 4, col = 6, cex.axis = 1.5, 
         cex.lab = 1.5, xlim = c(0,20), ylim = c(0,1.5), cex.main = 1.5,
         main = "frequency domain")
    text(x = a, y = A, labels = round(A, digits = 3), pos = 3, cex = 1.5)
    grid(lwd = 1, col = 1)
    plot(x = t, y = y1 + y2 + y3 + y4 + y5, type = "l", xlab = "time (s)",
         ylab = "amplitude", lwd = 4, col = 3, cex.axis = 1.5, 
         cex.lab = 1.5, ylim = c(-1.5,1.5), cex.main = 1.5, 
         main = "supperposition of Fourier series")
    lines(x = t, y = y1, lty = 2, lwd = 2, col = 2)
    lines(x = t, y = y2, lty = 2, lwd = 2, col = 4)
    lines(x = t, y = y3, lty = 2, lwd = 2, col = 5)
    lines(x = t, y = y4, lty = 2, lwd = 2, col = 7)
    lines(x = t, y = y5, lty = 2, lwd = 2, col = 8)
    lines(x = t, y = yt, lwd = 4, lty = 3, col = 1)
    grid(lwd = 1, col = 1)
    par(old.par)
  })
  
  output$onepeak = renderPlot({
    x = seq(1,512,1)
    position1 = input$p1
    width1 = input$w1
    area1 = input$a1
    
    if(input$peaktype == "Gaussian"){
      y = area1 * dnorm(x, position1, width1/2.35)
    }
    if(input$peaktype == "Lorentzian"){
      y = area1 * (1/pi * (0.5*width1)/((x-position1)^2 + (0.5*width1)^2))
    }
    if(input$peaktype == "Voigt"){
      y = 0.5*(area1 * dnorm(x, position1, width1/2.35)) + 0.5*(area1 * (1/pi * (0.5*width1)/((x-position1)^2 + (0.5*width1)^2)))
    }
    
    yfft = fft(y)
    old.par = par(mfrow = c(2,1))
    plot(x = x[1:256], y = y[1:256], type = "l", 
         lwd = 4, col = 6, ylim = c(0,2), xlim = c(0,150),
         xlab = "frequency", ylab = "signal",
         main = "frequency domain spectrum")
    abline(v = seq(0,150,10), lwd = 1, lty = 3, col = 3)
    abline(h = seq(0,2,0.5), lwd = 2, lty = 3, col = 3)
    plot(x = x[1:256], y = Re(yfft[1:256]), type = "l",
         lwd = 4, col = 6, ylim = c(-10,10), xlim = c(0,150),
         xlab = "time", ylab = "signal",
         main = "time domain spectrum")
    abline(v = seq(0,150,10), lwd = 1, lty = 3, col = 3)
    abline(h = seq(-10,10,5), lwd = 2, lty = 3, col = 3)
    par(old.par)
    })
  
  output$twopeaks = renderPlot({
    x = seq(1,512,1)
    position2a = input$p2a
    position2b = input$p2b
    width2a = input$w2a
    width2b = input$w2b
    area2a = input$a2a
    area2b = input$a2b
    
    # y2a = area2a * (1/pi * (0.5*width2a)/((x-position2a)^2 + (0.5*width2a)^2))
    # y2b = area2b * (1/pi * (0.5*width2b)/((x-position2b)^2 + (0.5*width2b)^2))
    
    # area2a * dnorm(x, position2a, width2a/2.35)
    
    y2a = area2a * dnorm(x, position2a, width2a/2.35)
    y2b = area2b * dnorm(x, position2b, width2b/2.35)
    
    yfft2a = fft(y2a)
    yfft2b = fft(y2b)
    
    if(input$include == "1 only"){
      y_total = y2a
      yfft_total = Re(yfft2a)
    }
    if(input$include == "2 only"){
      y_total = y2b
      yfft_total = Re(yfft2b)
    }
    if(input$include == "1 and 2"){
      y_total = y2a + y2b
      yfft_total = Re(yfft2a) + Re(yfft2b)
    }
    
    old.par = par(mfrow = c(2,1))
    plot(x = x[1:256], y = y_total[1:256], type = "l", 
         lwd = 4, col = 6,
         ylim = c(0,4), xlim = c(0,150), xlab = "frequency",
         ylab = "signal", main = "frequency domain spectrum")
    abline(v = seq(0,150,10), lwd = 1, lty = 3, col = 3)
    abline(h = seq(0,4,0.5), lwd = 2, lty = 3, col = 3)
    plot(x = x[1:256], y = yfft_total[1:256],
         type = "l", lwd = 4, col = 6,
         xlim = c(0,150), ylim = c(-20,20), 
         xlab = "time", ylab = "signal",main = "time domain spectrum")
    abline(v = seq(0,150,10), lwd = 1, lty = 3, col = 3)
    abline(h = seq(-20,20,5), lwd = 2, lty = 3, col = 3)
    par(old.par)
  })
  
  output$wrapup = renderPlot({
    urea_ft = fft(urea$urea_y)
    old.par = par(mfrow = c(2,1))
    plot(x = urea$urea_x, y = urea$urea_y,
         type = "l", lwd = 3, col = 6,
         xlab = "wavenumbers", ylab = "reflectance",
         main = "frequency domain spectrum")
    grid()
    plot(x = seq(1,length(urea$urea_x[4096:3700]),1), 
         y = Re(urea_ft[4096:3700]), 
         type = "l", lwd = 3, col = 6, 
         xlab = "time", ylab = "signal", ylim = c(-12,12),
         main = "time domain spectrum")
    grid()
    par(old.par)
  })
  
}) # close server

