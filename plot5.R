################################################################################
#### Exploratory Analysis 
#### Project 2
#### plot 5
################################################################################

## Library
library(data.table)

## working directory
setwd('C:/Users/dpanova/Documents/Resources/DataScienceSpecialization/ExplaratoryAnalysis')


## read in the data
NEI = readRDS('summarySCC_PM25.rds') 
SCC = readRDS('Source_Classification_Code.rds')


## Question
# How have emissions from motor vehicle sources changed 
#from 1999-2008 in Baltimore City?

#Merge the two files 
SCC$SCC = as.factor(SCC$SCC)
NEI$SCC = as.factor(NEI$SCC)
data = merge(NEI,SCC,by.x = 'SCC', by.y = 'SCC', all.x = TRUE)
#isolate the coal emissions
data = as.data.table(data[data$SCC.Level.One == 'Mobile Sources' & data$fips == '24510',])
vehicle_emissions = data[,all_emissions := sum(Emissions,na.rm = TRUE),by = year]
vehicle_emissions = unique(vehicle_emissions[,.(year,all_emissions)]) 



## plot it 
png("plot5.png", width=4, height=4, units="in", res=300)
plot(vehicle_emissions,main = 'Vehicle Emissions by Year',
     ylab = 'Total Emissions',type = 'b')

dev.off()
