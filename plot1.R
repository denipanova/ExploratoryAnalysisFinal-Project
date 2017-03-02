################################################################################
#### Exploratory Analysis 
#### Project 2
#### plot 1
################################################################################

## Library
library(data.table)

## working directory
setwd('C:/Users/dpanova/Documents/Resources/DataScienceSpecialization/ExplaratoryAnalysis')


## read in the data
NEI = readRDS('summarySCC_PM25.rds') 
SCC = readRDS('Source_Classification_Code.rds')


## Question
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 
#emission from all sources for each of the years 1999, 2002, 2005, and 2008.

usa = as.data.table(NEI)
usa = usa[,all_emissions := sum(Emissions,na.rm = TRUE),by = year]
usa = unique(usa[,.(year,all_emissions)]) 

## plot it 
png("plot1.png", width=4, height=4, units="in", res=300)
plot(usa,main = 'Total USA Emissions by Year',
     ylab = 'Total Emissions',type = 'b')

dev.off()



