##unzip the data
unzip ("exdata-data-household_power_consumption.zip")

##read the data
data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings="?")

##subset the data
chosen <- subset(data, Date=="1/2/2007" | Date=="2/2/2007")

##adjust time and date to posixlt form
prepareddata <- strptime(paste(chosen$Date, chosen$Time, sep = " "),"%d/%m/%Y %H:%M:%S", tz = "")

##change posixlt to posixct (mutate cannot work with posixlt)
prepareddata <- as.POSIXct(prepareddata)

##add column datetime with mutate function
library(dplyr)
finaldata <- mutate(chosen, DateTime = prepareddata)

##create plot4
png(file = "plot4.png")
par(mfrow = c(2,2))

plot(finaldata$DateTime, finaldata$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(finaldata$DateTime, finaldata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(finaldata$DateTime,finaldata$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(finaldata$DateTime, finaldata$Sub_metering_2, col = "red")
lines(finaldata$DateTime, finaldata$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty = 1, bty = "n")

plot(finaldata$DateTime, finaldata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
