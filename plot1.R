## download and unzip data

if(!file.exists("data")) dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")

## read relevant data into R
files <- file("./data/household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

## Plot 1

if(!file.exists("plots")) dir.create("plots")
png(filename = "./plots/plot1.png", width = 480, height = 480, units="px")
with(data, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red"))
dev.off()

## Plot 2
## convert data and time to specific format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time))
if(!file.exists("plots")) dir.create("plots")
png(filename = "./plots/plot2.png", width = 480, height = 480, units="px")
Sys.setlocale(category = "LC_ALL", locale = "english")
plot(data$DateTime, data$Global_active_power, xlab = '', ylab = "Global Active Power (kilowatt)", type = "l")
dev.off()

## Plot 3

if(!file.exists("plots")) dir.create("plots")
png(filename = "./plots/plot3.png", width = 480, height = 480, units="px")
Sys.setlocale(category = "LC_ALL", locale = "english")
plot(data$DateTime, data$Sub_metering_1, xlab = '', ylab = "Energy sub metering", type = "l")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
dev.off()

## Plot 4

if(!file.exists("plots")) dir.create("plots")
png(filename = "./plots/plot4.png", width = 480, height = 480, units="px")
Sys.setlocale(category = "LC_ALL", locale = "english")
par(mfrow = c(2, 2))
plot(data$DateTime, data$Global_active_power, xlab = '', ylab = "Global Active Power (kilowatts)", type = "l")
plot(data$DateTime, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
plot(data$DateTime, data$Sub_metering_1, xlab = '', ylab = "Energy sub metering", type = "l")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
plot(data$DateTime, data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.off()
