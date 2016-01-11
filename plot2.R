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
png(filename = "plot2.png")
with(data, plot(Global_active_power ~ datetime, type="l", xlab = '', ylab = "Global Active Power (kilowatts)"))
dev.off()

