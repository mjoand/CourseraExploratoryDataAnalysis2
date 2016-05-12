###Second Project: Question 1

###Downloading the data and reading it into a data table

#auxiliarUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(auxiliarUrl, destfile="auxiliarZip.zip")
#unzip("auxiliarZip.zip")
NEI<-readRDS("summarySCC_PM25.rds")

#Aggregating the data in order to evaluate the total number of tons of PM2.5
#emmited
NEI<-aggregate(Emissions~year,data=NEI,FUN=sum)

#Generationg and annotating the plot
png(file="plot1.png")
barplot(NEI$Emissions,names.arg=NEI$year,col="orange",ylab="Total PM2.5 Emissions (Tons)",
xlab="Year", main="Total PM2.5 Emissions for all US Sources")
dev.off()