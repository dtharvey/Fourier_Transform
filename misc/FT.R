# fourier transform figures
t = seq(1,256,1)
x = seq(1,512,1)
yt1 = 1*exp(-0.1*t)*cos(pi*t)
yt2 = 1*exp(-1*t)*cos(pi*t)
yt3 = 5*exp(-0.1*t)*cos(pi*t)
yt4 = 5*exp(-1*t)*cos(pi*t)
ynew1 = c(yt1,rev(yt1))
ynew2 = c(yt2,rev(yt2))
ynew3 = c(yt3,rev(yt3))
ynew4 = c(yt4,rev(yt4))
y.ft1 = fft(ynew1)
y.ft2 = fft(ynew2)
y.ft3 = fft(ynew3)
y.ft4 = fft(ynew4)
old.par = par(mfrow = c(2,2))
plot(x,Re(y.ft1), type = "l", col = "blue",lwd = 2, xlab = "", ylab = "")
plot(x,Re(y.ft2), type = "l", col = "blue",lwd = 2, xlab = "", ylab = "")
plot(x,Re(y.ft3), type = "l", col = "blue",lwd = 2, xlab = "", ylab = "")
plot(x,Re(y.ft4), type = "l", col = "blue",lwd = 2, xlab = "", ylab = "")
par(old.par)

old.par = par(mfrow = c(2,2))
plot(x = 1:256, y = yt1, type = "l")
plot(x = 1:256, y = yt2, type = "l")
plot(x = 1:256, y = yt3, type = "l")
plot(x = 1:256, y = yt4, type = "l")
par(old.par)

plot(x,Re(y.ft1), type = "l", col = "blue",lwd = 2, xlab = "", ylab = "")
legend(x = "topright", legend = "(a)", bty = "n")

plot(x[1:64],ynew[1:64],type = "l", col = "blue", lwd = 2, xlab = "", ylab = "", xaxt = "n", yaxt = "n")

legend(x = "topright", legend = "(b)", bty = "n")

curve(dnorm(x,mean = 250, sd = 20),from = 0, to = 512)

# test code for use in shiny app
x = seq(1,512,1)
position = 50
width = 10
amplitude = 2
y = amplitude * dnorm(x, position, width)
# y = curve(dnorm(x, mean = position, sd = width),from = 1, to = 512, n = 512)
yfft = fft(y)
# yfft = fft(2*y$y)
old.par = par(mfrow = c(2,1))
plot(x = x[1:256], y = y[1:256], type = "l", lwd = 2, col = "blue")
plot(x = x[1:256], y = Re(yfft[1:256]), type = "l", lwd = 2, col = "blue")
# plot(x = x[1:256], y = y$y[1:256], type = "l", lwd = 2, col = "blue")
# plot(x = x[1:256], y = Re(yfft[1:256]), type = "l", lwd = 2, col = "blue")
par(old.par)


#square wave

x_s = seq(1,512,1)
amplitude_s = 10
position_s = 70
width_s = 20
y_s = amplitude_s * dunif(x_s, min = position_s - 0.5 * width_s,
                         max = position_s + 0.5 * width_s)
plot(x = x_s, y = y_s, type ="l")
yfft_s = fft(y_s)
old.par = par(mfrow = c(2,1))
plot(x = x_s[1:256], y = y_s[1:256], type = "l", lwd = 2, col = "blue")
plot(x = x_s[1:256], y = Re(yfft_s[1:256]), type = "l", lwd = 2, col = "blue")
par(old.par)


# square wave
t = seq(0,0.5,0.5/511)
f = 1
yt = sign(sin(2*pi*f*t))
yt[1] = 0
yt[length(yt)] = 0
plot(x = t, 
     y = yt, 
     type = "l", xlab = "time", ylab = "amplitude",
     lwd = 4, col = 6, cex.axis = 1.5, cex.lab = 1.5, 
     ylim = c(0,1.5), cex.main = 1.5,
     main = "time domain")
yfft = fft(yt)
