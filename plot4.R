## Week 1 course project
## Load packages for downloading files.  I find the `curl` pacakge to 
## be quite helpful when downloading "https" files
library(curl)


file_url <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
curl_download(file_url, destfile = "./data/hpc.zip")
data <- read.table(unzip(zipfile="./data/hpc.zip",exdir="./data"), header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
## Extract the dates from the dataset
feb_data <-subset(data,data$Date=="1/2/2007" | data$Date == "2/2/2007")
## Combine the date and time varialbes to create a date-time-group
DTG <- paste(feb_data$Date, feb_data$Time)
## use `strptime` to coerce the character value to a Date value
feb_data$DTG <- strptime(DTG, "%d/%m/%Y %H:%M:%S")

## Fourth Plot
## set the rows and columns of the plot to 2 x 2
par(mfrow=c(2,2))
## plot # 2 (top left)
with(feb_data,plot(DTG, Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)"))
## plot # 4(new) (top right)
with(feb_data, plot(DTG, Voltage, type = "l", xlab = "datetime"))
## plot # 3 (bottom left)
with(feb_data,plot(DTG, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
points(feb_data$DTG, feb_data$Sub_metering_2, type = "l", col = "red")
points(feb_data$DTG, feb_data$Sub_metering_3, type = "l", col = "blue")
## legend changes- bty to turn off legend borders; cex to adjust the size
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.6)
## plot # 5(new) (bottom right)
with(feb_data, plot(DTG, Global_reactive_power, type = "l", xlab = "datetime"))
## send to a png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()