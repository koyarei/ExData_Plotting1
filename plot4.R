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
png(filename = "plot4.png", width = 480, height = 480)


par(mfrow = c(2, 2))
with(dataFeb, {
    ## graph 1
    plot(dataFeb$dateNew, dataFeb$Global_active_power, xlab="", ylab="Global Active Power", type="l")
    ## graph 2
    plot(dataFeb$dateNew, dataFeb$Voltage, xlab="datetime", ylab="Voltage", type="l")
    ## graph 3
    with(dataFeb, plot(dateNew, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
    with(dataFeb, points(dateNew, Sub_metering_1, type="l"))
    with(dataFeb, points(dateNew, Sub_metering_2, col = "red", type="l"))
    with(dataFeb, points(dateNew, Sub_metering_3, col = "blue", type="l"))
    legend("topright", lty=1, lwd=1, bty="n", col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    ## graph 4
    plot(dataFeb$dateNew, dataFeb$Global_reactive_power, xlab="datetime", ylab="Globa_reactive_power", type="l")
 
})


dev.off()