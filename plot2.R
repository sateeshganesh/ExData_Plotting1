# Set the working directory in your machine with setwd() function

# Include libraries for this project:
library(downloader) # Used to download and open a zip file
library(data.table)
library(plyr)           
library(dplyr)
library(grDevices)

# Step 1: Download and unzip the Electric Power Consumption dataset:
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest = "household_power_consumption.zip", mode = "wb")
unzip("household_power_consumption.zip",exdir = "./")

# Step 2: Read the household_power_consumption.txt file into a data frame:
hpc <- tbl_df(read.table("./household_power_consumption.txt",sep = ";",header = TRUE))

# Step 3: Extract the household power consumption data only for the dates "2007-02-01" and "2007-02-02":
hpcdata <- hpc %>% mutate(DateTime = as.POSIXct(strptime(paste(Date,Time),format = "%d/%m/%Y %T")),Day = weekdays(DateTime,abbreviate = TRUE)) %>% select(DateTime,Day, Global_active_power:Sub_metering_3) %>% filter(date(DateTime) >= "2007-02-01" & date(DateTime) <= "2007-02-02")

# Step 4: Create Plot 2: Global Active Power line plot and store it in PNG file:
png(filename = "./plot2.png", width = 480,height = 480, units = "px")
plot(hpcdata$DateTime, as.numeric(as.character(hpcdata$Global_active_power)), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
