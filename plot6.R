################################################################################
#### Exploratory Analysis 
#### Project 2
#### plot 6
################################################################################

## Library
library(data.table)
library(ggplot2)

## working directory
setwd('C:/Users/dpanova/Documents/Resources/DataScienceSpecialization/ExplaratoryAnalysis')


## read in the data
NEI = readRDS('summarySCC_PM25.rds') 
SCC = readRDS('Source_Classification_Code.rds')


## Question
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

#Merge the two files 
SCC$SCC = as.factor(SCC$SCC)
NEI$SCC = as.factor(NEI$SCC)
data = merge(NEI,SCC,by.x = 'SCC', by.y = 'SCC', all.x = TRUE)
#isolate the coal emissions
data = as.data.table(data[data$SCC.Level.One == 'Mobile Sources' 
                          & data$fips %in% c('24510','06037'),])
data$city = ifelse(data$fips == '06037', 'Los Angeles' , 'Baltimore')
vehicle_emissions = data[,all_emissions := sum(Emissions,na.rm = TRUE),by = .(year,city)]
vehicle_emissions = unique(vehicle_emissions[,.(year,all_emissions,city)]) 



## plot it 
png("plot6.png", width=4, height=4, units="in", res=300)
ggplot(data=vehicle_emissions,
       aes(x=year, y=all_emissions, colour=city)) +
  geom_line(size = 1) + 
  labs(title = 'Vehicle Emissons by City',
       y = 'Emissions')

dev.off()
