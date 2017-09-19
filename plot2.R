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

par(mfrow = c(1,1))
## Second Plot
with(feb_data,plot(DTG, Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()