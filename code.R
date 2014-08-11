nei.list <- split(NEI,NEI$year)

sapply(nei.list,nrow)
emi.data <- lapply(nei.list, function(x)x$Emissions)
sapply(emi.data,summary)
logged.emi.data <- lapply(emi.data,log10)
boxplot(logged.emi.data,main="Global emissions of PM2.5 from 1999 to 2008",xlab="year",
        ylab="log10(Emission)")

nei.baltimore <-  subset(NEI, fips=="24510")
nei.baltimore.list <- split(nei.baltimore,nei.baltimore$year)
nei.baltimore.data <- lapply(nei.baltimore.list,function(x)x$Emissions)
logged.nei.baltimore.data <- lapply(nei.baltimore.data,log10)
boxplot(logged.nei.baltimore.data,main="Baltimore emissions of PM2.5 from 1999 to 2008",xlab="year",
        ylab="log10(Emission)")

library(ggplot2)

ggplot(nei.baltimore,aes(x=factor(year),y=log10(Emissions)))  + geom_boxplot() +
 facet_grid(. ~ type) + xlab("year") + ggtitle("Baltimore emissions of PM2.5 from 1999 to 2008 by type")

coal.comb.short.names  <- grep("[Cc]omb.*[Cc]oal",unique(as.character(SCC$Short.Name)),value=T,perl=T)
coal.comb.scc <-  as.character(subset(SCC,Short.Name %in% coal.comb.short.names)$SCC)

nei.coal.comb <- subset(nei.baltimore, SCC %in% coal.comb.scc)
ggplot(nei.coal.comb, aes(x=factor(year),y=log10(Emissions))) + geom_boxplot() + xlab("year") + 
  ggtitle("Coal Combustion related PM25 emissions from 1999 to 2008")
ggplot(nei.coal.comb, aes(x=factor(year),y=Emissions)) + geom_boxplot() + xlab("year")

nei.baltimore.road <- subset(nei.baltimore,type=="ON-ROAD")

ggplot(nei.baltimore.road, aes(x=factor(year),y=log10(Emissions))) + geom_boxplot() + xlab("year") + 
  ggtitle("PM25 emissions from motor vehicle sources in Baltimore City from 1999 to 2008")


nei.road.baltimore.and.la <- subset(NEI, type == "ON-ROAD" & (fips == "24510" | fips == "06037"))
place <- as.factor(ifelse(nei.road.baltimore.and.la$fips=="24510","Baltimore City",
                          "Los Angeles County"))
nei.road.baltimore.and.la$place <- place

ggplot(nei.road.baltimore.and.la, aes(x=factor(year),y=log10(Emissions))) + geom_boxplot() + xlab("year") + 
  facet_grid(. ~ place) + 
  ggtitle("PM25 emissions from motor vehicle sources from 1999 to 2008")
