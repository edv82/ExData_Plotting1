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
par(mfrow = c(2,2), mar = c(4,4,2,2))#, oma = c(0, 0, 2, 0))
with(data01, {
  plot(Date, Global_active_power, type = "l",
       ylab = "Global Active Power", xlab = "")
  plot(Date, Voltage, type = "l",
       ylab = "Voltage", xlab = "datetime")
  plot(Date, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(Date, Sub_metering_2, col = "red")
  lines(Date, Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1),
         col = c("black", "red", "blue"), cex = 0.75, bty = "n")
  plot(Date, Global_reactive_power, type = "l",
       ylab = "Global_reactive_power", xlab = "datetime",
       yaxp = c(0.0, 0.5, 5), cex.axis = 0.75)
})

dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()