###Second Project: Question 3
###Downloading the data and reading it into a data table

#auxiliarUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(auxiliarUrl, destfile="auxiliarZip.zip")
#unzip("auxiliarZip.zip")
NEI<-readRDS("summarySCC_PM25.rds")

#Aggregating the data in order to evaluate the total number of tons of PM2.5
#emmited in terms of year and type
Baltimore<-subset(NEI,fips=="24510")
Baltimore<-aggregate(Emissions~year+type,data=Baltimore,FUN=sum)

#loading ggplot2
library(ggplot2)

#Creating and annotating the plot
png(file="plot3.png",width=800, height=400,units="px")
plot3<-ggplot(data=Baltimore, aes(year,Emissions,fill=type))
plot3+geom_bar(stat="identity",width=1.5)+
  facet_grid(facets =.~type,scales = "free",space = "free") +
  geom_smooth(method="lm",se=FALSE)+
  labs(x="Year",y="Total PM2.5 Emissions (Tons)")+
  labs(title="Total PM2.5 Vehicle Emissions for Baltimore by Source Type")
dev.off()
