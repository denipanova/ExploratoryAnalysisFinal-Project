################################################################################
#### Exploratory Analysis 
#### Project 2
#### plot 2
################################################################################

## Library
library(data.table)

## working directory
setwd('C:/Users/dpanova/Documents/Resources/DataScienceSpecialization/ExplaratoryAnalysis')


## read in the data
NEI = readRDS('summarySCC_PM25.rds') 
SCC = readRDS('Source_Classification_Code.rds')


## Question
#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
#to make a plot answering this question.
baltimore = as.data.table(NEI[NEI$fips == '24510',])
baltimore = baltimore[,all_emissions := sum(Emissions,na.rm = TRUE),by = year]
baltimore = unique(baltimore[,.(year,all_emissions)]) 

## plot it 
png("plot2.png", width=4, height=4, units="in", res=300)
plot(baltimore,main = 'Total Baltimore Emissions by Year',
     ylab = 'Total Emissions',type = 'b')

dev.off()
