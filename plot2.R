## first, read the file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE)

## select target dates and load into dataFeb
dataFeb <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

## merge time and date column to create a new column
dateNew <- paste(dataFeb$Time, dataFeb$Date, sep=" ")
dateNew <- strptime(dateNew, "%H:%M:%S %d/%m/%Y")
dataFeb <- cbind(dataFeb, dateNew)

## save to a PNG file
png(filename = "plot2.png", width = 480, height = 480)

## constructing the plot
x <- dataFeb$Global_active_power
y <- dataFeb$dateNew
plot(y, x, xlab="", ylab="Global Active Power (kilowatts)", type="l")

dev.off()