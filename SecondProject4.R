###Second Project: Question 4

###Downloading the data and reading it into a data table

auxiliarUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(auxiliarUrl, destfile="auxiliarZip.zip")
unzip("auxiliarZip.zip")
NEI<-readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#identifying the SCC's correspondind to combustion
combust<-grepl(pattern="combust",x=SCC$SCC.Level.One,ignore.case=TRUE)
SCCcombust<-SCC[combust,]

#identifying the SCC's correspondng to coal combustion
coal<-grepl(pattern="coal",x=SCCcombust$SCC.Level.Four,ignore.case=TRUE)
SCCcombustcoal<-SCCcombust[coal,]

#subsetting the data corresponding to coal combustion
CoalCombust<-subset(NEI,SCC %in% SCCcombustcoal$SCC)
 
#loading ggplot2
library(ggplot2)

#Creating and annotating the plot
png(file="plot4.png",height=800,width=400,units="px")
plot4<-ggplot(data=CoalCombust, aes(year, Emissions))
plot4+geom_point(color="green",alpha=0.15,size=3)+geom_smooth(method="lm")+
  labs(x="year",y="Recorded PM2.5 Emissions (Tons)")+
  labs(title=expression("PM2.5 Coal Combustion Source Emissions for the US"))
dev.off()