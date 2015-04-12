#download, unzip and read the data
file.url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
file.dest <- 'power.consumption.zip'
download.file( file.url, file.dest )
unzip( file.dest )
file <- file("household_power_consumption.txt", "r")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(file), value = TRUE), 
                   sep = ";", skip = 0, na.strings = "?", stringsAsFactors = FALSE)

#data[1:2,] #to see the variable names

#change time format
data$newtime <- strptime(paste(data$V1, data$V2), format = "%d/%m/%Y %H:%M:%S")

#PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot4.png", width = 480, height = 480)

#plot the data
par(mfrow = c(2, 2))
plot(data$newtime, data$V3, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" )
plot(data$newtime, data$V5, type = "l", xlab = "datetime", ylab = "Voltage")
plot(data$newtime, data$V7, type = "l", xlab = "", ylab = "Energy sub metering")
      lines(data$newtime, data$V8, col = "red")
      lines(data$newtime, data$V9, col = "blue")
      legend("topright", col = c("black", "red", "blue"), cex = 0.8, lty = 1,
             legend = c("Sub_metering_1    ", 
                        "Sub_metering_2    ",
                        "Sub_metering_3    "))
plot(data$newtime, data$V4, type = "l", xlab = "datetime", ylab = "Global_reactive_power" )
dev.off()
#system language should be English