SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

nei.list <- split(NEI,NEI$year)

sapply(nei.list,nrow)
emi.data <- lapply(nei.list, function(x)x$Emissions)
logged.emi.data <- lapply(emi.data,log10)

png("plot1.png")
title = expression(paste("Global emissions of ",PM[2.5]," from 1999 to 2008"))
boxplot(logged.emi.data,main=title,xlab="year",
        ylab=expression(log[10](Emissions)),outline=FALSE)
dev.off()


