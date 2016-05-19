##Second Project: Question 5

###Downloading the data and reading it into a data table

#auxiliarUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(auxiliarUrl, destfile="auxiliarZip.zip")
#unzip("auxiliarZip.zip")
NEI<-readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#identifying the SCC's correspondind to motor vehicles
vehicles<-grepl(pattern="vehicles",x=SCC$EI.Sector,ignore.case = TRUE)
SCCvehicles<-SCC[vehicles,]

#subsetting the data corresponding to motor vehicle readings from Baltimore
Baltimore<-subset(NEI, SCC %in% SCCvehicle$SCC & fips=="24510")

#Creating and annotating the plot
png(file="plot5.png",height=600, width=600,units="px")
plot(Baltimore$year,Baltimore$Emissions,xlab="Year",ylab="Recorded PM2.5 Emissions (Tons)",
     main="PM2.5 Vehicle Source Emissions for Baltimore")
regr<-lm(Baltimore$Emissions~Baltimore$year)
abline(regr,lty=3, col="orange",lwd=3)
legend("topright","regression line",lty=3, col="orange",lwd=3)
dev.off()