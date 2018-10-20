# read in the file
hpc <- read.table("./household_power_consumption.txt", header=TRUE, sep = ";", na.strings="?")

# convert variable Date to date class
hpc$Date <- as.Date(as.character(hpc$Date), format="%d/%m/%Y")

# take the subset of the data that interests us
mydata <- subset(hpc, Date >= "2007-02-01" & Date < "2007-02-03")

# open the png device
png(file="plot1.png")

# plot
with(mydata, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power"))

# close the png device
dev.off()


