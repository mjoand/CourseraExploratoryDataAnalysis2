##Second Project: Plot 6

###Downloading the data and reading it into a data table

auxiliarUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(auxiliarUrl, destfile="auxiliarZip.zip")
unzip("auxiliarZip.zip")
NEI<-readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#identifying the SCC's correspondind to motor vehicles
vehicles<-grepl(pattern="vehicles",x=SCC$EI.Sector,ignore.case = TRUE)
SCCvehicles<-SCC[vehicles,]

#subseting the data corresponding to motor vehicles emissions in Baltimore and LA
NEI<-subset(NEI,SCC%in%SCCvehicles$SCC)
BaltLA<-subset(NEI,fips == "24510" | fips == "06037")
BaltLA<-aggregate(Emissions~year+fips,data=BaltLA,FUN=sum)

BaltLA$fips<-as.factor(BaltLA$fips)
levels(BaltLA$fips)[1]<-"LA"
levels(BaltLA$fips)[2]<-"Baltimore"

#loading ggplot2
library(ggplot2)

png(file="plot6.png")
plot6<-ggplot(data=BaltLA, aes(year,Emissions,fill=fips))
plot6+geom_bar(stat="identity",width=1.5)+
  facet_grid(facets =.~fips,scales = "free",space = "free")+
  geom_smooth(method="lm",se=FALSE)+
  labs(x="Year",y="Total PM2.5 Emissions (Tons)")+
  labs(title="Total PM2.5 Vehicle Emissions for LA and Baltimore")
dev.off()
