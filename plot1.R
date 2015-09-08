library(dplyr)
d<-read.table("../Data/household_power_consumption.txt",header=TRUE,sep=";",
                    colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                    na.string="?")

d<-transform(d,Date=as.Date(strptime(Date,"%d/%m/%Y")))
d<-filter(d,Date=="2007-02-01" | Date=="2007-02-02")
hist(d$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png,"plot1.png",width=480,height=480,units="px",type = "cairo")
dev.off()