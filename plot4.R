# load required libraries
library(lubridate)
library(dplyr)
# create data table from txt file
fdata = read.table("household_power_consumption.txt", sep=";", header=T, na.strings = "?")
# filter the table for dates between 2007-02-01 and 2007-02-02
data = fdata %>% 
  mutate(Date = dmy(Date), Global_active_power = as.numeric(Global_active_power)) %>% 
  filter(between(Date, ymd('2007-02-01'), ymd('2007-02-02')))
# merge the date and time into a new variable called datetime
data = mutate(data, datetime = ymd_hms(paste(Date, Time)))
#plot to png
png(filename = "plot4.png")
par(mfrow = c(2,2))
#plot Global_active_power vs datetime
with(data, plot(Global_active_power ~ datetime, type="l", xlab = '', ylab = "Global Active Power"))
#plot Voltage vs datetime
with(data, plot(Voltage ~ datetime, type="l", xlab = 'datetime', ylab = "Voltage"))
#plot Energy sub metering vs datetime
with(data, {
  plot(Sub_metering_1 ~ datetime, col = 'black', type = "l", xlab = '', ylab = "Energy sub metering")
  lines(Sub_metering_2 ~ datetime, col = 'red', type = "l")
  lines(Sub_metering_3 ~ datetime, col = 'blue', type = "l")
})
legend('topright', bty = "n", legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = c(1,1,1), col = c("black","red","blue" ))
#plot Global_reactive_power vs datetime
with(data, plot(Global_reactive_power ~ datetime, type="l"))
dev.off()

