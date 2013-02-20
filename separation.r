# these two libraries are necessary
library("tuneR")    # to deal with .WAV file
library("fastICA")  # to use fastICA algorithm

# input files
wave1 <- readWave("wave1.wav")
wave2 <- readWave("wave2.wav")

#plot(wave1@left, type="l")
#plot(wave2@left, type="l")

# extracting the source signals using fastICA
X <- t(rbind(wave1@left, wave2@left))
result <- fastICA(X, 2)
wave1@left <- as(10000*result$S[,1], "integer")
wave2@left <- as(10000*result$S[,2], "integer")
newwave1 <- normalize(wave1, unit="8", center=TRUE)
newwave2 <- normalize(wave2, unit="8", center=TRUE)

# output files
writeWave(newwave1, "result1.wav")
writeWave(newwave2, "result2.wav")