#Download file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              temp)
data01 <- read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";", na.strings = "?")
unlink(temp)
rm(temp)

#Convert data variable into date format
library(lubridate)
data01$Date <- dmy(data01$Date)

#Filter data of the required days
library(dplyr)
data01 <- filter(data01, year(Date)==2007, month(Date)==02, day(Date)==01|day(Date)==02)

#Create the graph
hist(data01$Global_active_power, col = "red", breaks = 12, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()