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
d1$templates$script = "./chart_objeq.html"
d1$set(
  query = "Eye == 'Brown'  && '^B' =~ Hair"
)
d1

d1$save("rCharts_objeq_example.html",cdn=T)


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
d2$setLib(".")
d2$templates$page = "rCharts_objeq.html"
d2$templates$script = paste0(getwd(),"/chart_objeq.html")
d2


d2$save("rCharts_objeq_example2.html",cdn=T)

#try the facets
d3 <- d1
d3$templates$script = "./chart_objeq_facet.html"
d3$set(facet = list(x=NULL,y=NULL))
d3

#try the colors and add some options and remove query
d3$set(
  defaultColors = "d3.scale.category10()",
  type = "line",
  yAxis = list(type = "addPctAxis" ),
  groups = c("Eye", "Hair"),
  facet = list( x = "Eye", removeAxes = TRUE ),
  query = NULL
)
d3

#d3$save("rCharts_objeq_example3.html",cdn=T)

d4 <- d2
d4$templates$script = "./chart_objeq_facet.html"
d4$set(facet = list(x=NULL,y=NULL))
d4
