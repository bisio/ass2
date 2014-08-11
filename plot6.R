SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

nei.road.baltimore.and.la <- subset(NEI, type == "ON-ROAD" & (fips == "24510" | fips == "06037"))
place <- as.factor(ifelse(nei.road.baltimore.and.la$fips=="24510","Baltimore City",
                          "Los Angeles County"))
nei.road.baltimore.and.la$place <- place

title = expression(paste( PM[25]," emissions from motor vehicle sources from 1999 to 2008"))
ggplot(nei.road.baltimore.and.la, aes(x=factor(year),y=log10(Emissions))) + geom_boxplot() + xlab("year") + 
  facet_grid(. ~ place) + 
  ggtitle(title) +
  ylab(expression(log[10](Emissions)))

ggsave("plot6.png")
