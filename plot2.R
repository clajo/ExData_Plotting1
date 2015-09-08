library(dplyr)

#Read data from file
d<-read.table("../Data/household_power_consumption.txt",header=TRUE,sep=";",
              colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
              na.string="?")

#Transform date column into dataformat
d<-transform(d,Date=as.Date(strptime(Date,"%d/%m/%Y")))
#Filter data
d<-filter(d,Date=="2007-02-01" | Date=="2007-02-02")
#Add new column with Date and time as POSIXct
d<-transform(d,DateTime=as.POSIXct(paste(d$Date, d$Time), format="%Y-%m-%d %H:%M:%S"))

#Change system time setting, to get english names
curr_locale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")

#Plot line chart
par(mfcol=c(1,1))
with(d,plot(d$DateTime,d$Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab=""))
lines(d$DateTime,d$Global_active_power)


#Save plot as png file
dev.copy(png,"plot2.png",width=480,height=480,units="px",type = "cairo")
dev.off()

#Set the system time back to original setting
Sys.setlocale("LC_TIME",curr_locale)