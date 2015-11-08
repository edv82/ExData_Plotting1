#Download file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              temp)
data01 <- read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";", na.strings = "?")
unlink(temp)
rm(temp)

#Convert data variable into date format
library(lubridate)
data01$Date <- dmy_hms(paste(data01$Date, data01$Time))

#Filter data of the required days
library(dplyr)
data01 <- filter(data01, year(Date)==2007, month(Date)==02, day(Date)==01|day(Date)==02)

#Create the graph
plot(data01$Date, data01$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data01$Date, data01$Sub_metering_2, col = "red")
lines(data01$Date, data01$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1),
       col = c("black", "red", "blue"))
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()