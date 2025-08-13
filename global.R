# global.R file for Fourier transform learning module

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
