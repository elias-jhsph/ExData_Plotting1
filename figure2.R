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
png("plot2.png",width=480,height=480)

# Make Plot
with(data, plot(datetime, Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab=""))
with(data, lines(datetime, Global_active_power))




