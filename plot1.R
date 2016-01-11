# load required libraries
library(lubridate)
library(dplyr)
# create data table from txt file
fdata = read.table("household_power_consumption.txt", sep=";", header=T, na.strings = "?")
# filter the table for dates between 2007-02-01 and 2007-02-02
data = fdata %>% 
  mutate(Date = dmy(Date), Global_active_power = as.numeric(Global_active_power)) %>% 
  filter(between(Date, ymd('2007-02-01'), ymd('2007-02-02')))
#plot to png
png(filename = "plot1.png")
with(data, hist(Global_active_power, col='red', xlab = "Global Active Power (kilowatts)", ylab = "Frequency", ylim=c(0,1200), main = "Global Active Power", yaxp = c(0, 1200, 6)))
dev.off()
