# read in the file
hpc <- read.table("./household_power_consumption.txt", header=TRUE, sep = ";", na.strings="?")

# combine the Date and Time variables in a string
dt <- paste(as.character(hpc$Date), as.character(hpc$Time))

# convert the type of the newly formed string to class Date
datetime <- strptime(dt, "%d/%m/%Y %H:%M:%S")

# strip the Date and Time variables from the original data set
mydata <- subset(hpc, select = Global_active_power:Sub_metering_3)

# add the newly formed datetime variable to the stripped data set
mydata <- data.frame(datetime, mydata)

# take the subset of the data that interests us
usedata <- subset(mydata, datetime >= "2007-02-01" & datetime < "2007-02-03")

# open the png device
png(file="plot4.png")

# decide on the geometry of the 4 plots: (2,2)- row oriented
par(mfrow=c(2,2))

# plot (1,1)
with(usedata, plot(datetime, Global_active_power, xlab="", ylab="Global Active Power", type="n"))
with(usedata, lines(datetime, Global_active_power))

# plot (1,2)
with(usedata, plot(datetime, Voltage, ylab="Voltage", type="n"))
with(usedata, lines(datetime, Voltage))

# plot (2,1)
with(usedata, plot(datetime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="n"))
with(usedata, lines(datetime, Sub_metering_1))
with(usedata, lines(datetime, Sub_metering_2, col="red"))
with(usedata, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty="n")

# plot (2,2)
with(usedata, plot(datetime, Global_reactive_power, type="n"))
with(usedata, lines(datetime, Global_reactive_power))

# close the png device
dev.off()
