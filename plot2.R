# read in the file
hpc <- read.table("./household_power_consumption.txt", header=TRUE, sep = ";", na.strings="?")

# combine the Date and Time variables in a string
dt <- paste(as.character(hpc$Date), as.character(hpc$Time))

# convert the type of the newly formed string to class Date
datetime <- strptime(dt,"%d/%m/%Y %H:%M:%S")

# strip the Date and Time variables from the original data set
mydata <- subset(hpc, select=Global_active_power:Sub_metering_3)

# add the newly formed datetime variable to the stripped data set
mydata <- data.frame(datetime, mydata)

# take the subset of the data that interests us
usedata <- subset(mydata, datetime >= "2007-02-01" & datetime < "2007-02-03")

# open the png device
png(file="plot2.png")

# prepare the plotting area with the correct axis labels
with(usedata, plot(datetime, Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="n"))

# plot
with(usedata, lines(datetime, Global_active_power))

# close the png device
dev.off()
