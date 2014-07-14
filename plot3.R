## first, read the file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE)

## select target dates and load into dataFeb
dataFeb <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

## create a new column that merges date and time data
dateNew <- paste(dataFeb$Time, dataFeb$Date, sep=" ")
dateNew <- strptime(dateNew, "%H:%M:%S %d/%m/%Y")
dataFeb <- cbind(dataFeb, dateNew)

## save to a PNG file
png(filename = "plot3.png", width = 480, height = 480)

## constructing the plot with 3 points and legend
with(dataFeb, plot(dateNew, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(dataFeb, points(dateNew, Sub_metering_1, type="l"))
with(dataFeb, points(dateNew, Sub_metering_2, col = "red", type="l"))
with(dataFeb, points(dateNew, Sub_metering_3, col = "blue", type="l"))
legend("topright", lty=1, lwd=1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off()