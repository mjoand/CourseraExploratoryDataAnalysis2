###Second Project: Question 2
###Downloading the data and reading it into a data table

auxiliarUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(auxiliarUrl, destfile="auxiliarZip.zip")
unzip("auxiliarZip.zip")

NEI<-readRDS("summarySCC_PM25.rds")

#Aggregating the data in order to evaluate the total number of tons of PM2.5
#emmited
Baltimore<-subset(NEI,fips=="24510")
Baltimore<-aggregate(Emissions~year,data=Baltimore,FUN=sum)

#Generationg and annotating the plot
png(file="plot2.png",width=600, height=400,units="px")
plot(Baltimore, type="line",ylab="Total PM2.5 Emissions (Tons)",
     xlab="Year", main="Total PM2.5 Emissions for Baltimore",col="blue",bty="l")
regr<-lm(Baltimore$Emissions~Baltimore$year)
abline(regr,lty=3, col="orange",lwd=2)
legend("topright","regression line",lty=3, col="orange",lwd=2)
dev.off()