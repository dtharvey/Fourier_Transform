x = seq(1,512,1)
position = 75
width = 10
area = 10
height = area/width
y = rep(0,512)
y[(position - width/2):(position + width/2)] = height
plot(x = x, y = y, type = "l", xlim = c(0,150), ylim = c(0,2))
yfft = fft(y)
old.par = par(mfrow = c(2,1))
plot(x = x[1:256], y = y[1:256], type = "l", 
     lwd = 4, col = 6, ylim = c(0,2), xlim = c(0,150),
     xlab = "frequency", ylab = "signal",
     main = "frequency domain spectrum")
abline(v = seq(0,150,10), lwd = 1, lty = 3, col = 3)
abline(h = seq(0,2,0.4), lwd = 2, lty = 3, col = 3)
plot(x = x[1:256], y = Re(yfft[1:256]), type = "l",
     lwd = 4, col = 6, ylim = c(-10,10), xlim = c(0,150),
     xlab = "time", ylab = "signal",
     main = "time domain spectrum")
abline(v = seq(0,150,10), lwd = 1, lty = 3, col = 3)
abline(h = seq(-10,10,5), lwd = 2, lty = 3, col = 3)
par(old.par)

# voigt
x = seq(1,512,1)
position = 75
width = 10
area = 10
yg = area * dnorm(x, position, width/2.35)
yl = area * (1/pi * (0.5*width)/((x-position)^2 + (0.5*width)^2))
yv = 0.5 * yg + 0.5 * yl


yfft = fft(yl)

old.par = par(mfrow = c(2,1))
plot(x = x[1:256], y = y[1:256], type = "l", 
     lwd = 4, col = 6, ylim = c(0,2), xlim = c(0,150),
     xlab = "frequency", ylab = "signal",
     main = "frequency domain spectrum")
abline(v = seq(0,150,10), lwd = 1, lty = 3, col = 3)
abline(h = seq(0,2,0.4), lwd = 2, lty = 3, col = 3)
plot(x = x[1:256], y = Re(yfft[1:256]), type = "l",
     lwd = 4, col = 6, ylim = c(-10,10), xlim = c(0,150),
     xlab = "time", ylab = "signal",
     main = "time domain spectrum")
abline(v = seq(0,150,10), lwd = 1, lty = 3, col = 3)
abline(h = seq(-10,10,5), lwd = 2, lty = 3, col = 3)
par(old.par)

# wrapup figure

library(readJDX)

drift = readJDX(file = "urea_drift.jdx", SOFC = TRUE, debug = 0)

plot(x = drift$Urea$x, y = drift$Urea$y,
     type = "l", lwd = 4, col = 6)

urea_x = drift$Urea$x[-(1:3057)]
urea_y = drift$Urea$y[-(1:3057)]
plot(x = urea_x, y = urea_y, type = "l", lwd = 4, col = 6)

urea_ft = fft(urea_y)
           
plot(x = seq(1,length(urea_x[4096:3700]),1), y = Re(urea_ft[4096:3700]), 
     type = "l", lwd = 2, col = 6, 
     xlab = "time", ylab = "signal",
     main = "time domain spectrum")

plot(x = urea_x, y = urea_y,
     type = "l", lwd = 2, col = 6,
     xlab = "wavenumbers", ylab = "absorbance",
     main = "frequency domain spectrum")



urea_data = data.frame(urea_x, urea_y)
write.csv(urea_data, file = "urea.csv")
urea = read.csv(file = "urea.csv")

plot(x = urea_x[4096:3700], y = Re(urea_ft[4096:3700]), type = "l", lwd = 2, col = 6)
