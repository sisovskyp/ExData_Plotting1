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

##create plot1
png(file = "plot1.png")
hist(chosen$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power", yaxt = "n")
axis(side=2, at=c(0, 200, 400, 600, 800, 1000, 1200), labels=c("0","200", "400", "600", "800", "1000", "1200"))
dev.off()
