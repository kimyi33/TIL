# 12-1 Making `interactive graph` using `plotly` package
install.packages("plotly")
library(plotly)
library(ggplot2)
p <- ggplot(data = mpg, aes(x=displ, y=hwy, col = drv)) + geom_point()
ggplotly(p)

p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) + geom_bar(position = "dodge")
ggplotly(p)

# 12-2 Making interactive time series graph using `dygraphs`
install.packages("dygraphs")
library(dygraphs)
head(economics)

# To make interactive time series grph using `dygraphs`,
# the data type must be `xts` which has time series property.
library(xts)
eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)
dygraph(eco)

# available to set date interval
dygraph(eco) %>% dyRangeSelector()

# Pushing multiple values
eco_a <- xts(economics$psavert, order.by = economics$date)
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

# Binding data
eco2 <- cbind(eco_a, eco_b)
head(eco2)

# Changing column names
colnames(eco2) <- c("psvert", "unemployment")
head(eco2)

# Generating dygraph
dygraph(eco2) %>% dyRangeSelector()
