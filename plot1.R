library(dplyr)

#Read data from file
d<-read.table("../Data/household_power_consumption.txt",header=TRUE,sep=";",
                    colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                    na.string="?")

#Transform date column into dataformat
d<-transform(d,Date=as.Date(strptime(Date,"%d/%m/%Y")))

#Filter data
d<-filter(d,Date=="2007-02-01" | Date=="2007-02-02")

#Plot histogram 
par(mfcol=c(1,1))
hist(d$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")

#Save plot as png file
dev.copy(png,"plot1.png",width=480,height=480,units="px",type = "cairo")
dev.off()