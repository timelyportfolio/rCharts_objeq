#if you have not installed the newest dev branch of rCharts
#require(devtools)
#install_github("rCharts","timelyportfolio",ref="objeq")
#setwd("C:/Users/Kent.TLEAVELL_NT/Dropbox/development/r/rCharts")
#install()

library(rCharts)
options(viewer=NULL)

hairEye <- as.data.frame(HairEyeColor)

d1 <- dPlot(
  Freq ~ Sex,
  groups = "Hair",
  data = hairEye,
  type = "bar"
)
#d1$set(defaultColors=c())
d1$setLib(".")
d1$templates$page = "rCharts_objeq.html"
d1$templates$script = paste0("./chart_objeq.html")
d1

d1$save("rCharts_objeq_example.html",cdn=F)


#get data used by dimple for all of its examples as a first test
data <- read.delim(
  "http://pmsi-alignalytics.github.io/dimple/data/example_data.tsv"
)

### eliminate . to avoid confusion in javascript
colnames(data) <- gsub("[.]","",colnames(data))

### example 16 Scatter
d2 <- dPlot(
  OperatingProfit~UnitSales,
  groups = c("SKU","Channel"),
  data = subset(data, Date == "01/12/2012"),
  type = "bubble"
)
d2$xAxis( type = "addMeasureAxis" )
d2$yAxis( type = "addMeasureAxis" )
d2$legend(
  x = 200,
  y = 10,
  width = 500,
  height = 20,
  horizontalAlign = "right"
)
d2
d2$setLib(".")
d2$templates$page = "rCharts_objeq.html"
d2$templates$script = paste0(getwd(),"/chart_objeq.html")
d2


d2$save("rCharts_objeq_example2.html",cdn=F)
