## first, read the file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE)


## select target dates and load into dataFeb
dataFeb <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

## save to a PNG file
png(filename = "plot1.png", width = 480, height = 480)

## construct a histogram with x lable, title, and red color
hist(dataFeb$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

dev.off()