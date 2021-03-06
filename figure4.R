library(tidyverse)

# Download and unzip data
data_path <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
temp <- tempfile()
download.file(data_path,temp)
data <- read_delim(unz(temp, "household_power_consumption.txt"), delim=";")
unlink(temp)

# Make correct data frame
ok_dates <- as.Date(c("1/2/2007","2/2/2007"),"%d/%m/%Y")
data['Date'] <- as.Date(data$Date,"%d/%m/%Y")
data <- data %>% filter(Date %in% ok_dates)
data <- data %>% mutate(datetime = as.POSIXct(paste(Date, Time)))

# Make Image
png("plot4.png",width=480,height=480)

# Make Plot
par(mfcol=c(2,2), mar=c(4,4,2,1))
with(data, plot(datetime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))
with(data, lines(datetime, Sub_metering_1))
with(data, lines(datetime, Sub_metering_2, col="red"))
with(data, lines(datetime, Sub_metering_3, col="blue"))
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1:3, cex = 0.65)

with(data, plot(datetime, Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab=""))
with(data, lines(datetime, Global_active_power))

with(data, plot(datetime, Voltage, type="n"))
with(data, lines(datetime, Voltage))

with(data, plot(datetime, Global_reactive_power, type="n"))
with(data, lines(datetime, Global_reactive_power))


