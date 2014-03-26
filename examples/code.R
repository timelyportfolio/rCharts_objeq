#if you have not installed the newest dev branch of rCharts
#require(devtools)
#install_github("rCharts","timelyportfolio",ref="objeq")
#setwd("C:/Users/Kent.TLEAVELL_NT/Dropbox/development/r/rCharts")
#install()

library(rCharts)
library(jsonlite)  #explicitly require this to use jsonlite toJSON
options(viewer=NULL)
#override read_template to avoid whole reinstall of rCharts
#looks like it will not be this simple
#read_template <- function( template ){
#  read_file( template )
#}

hairEye <- as.data.frame(HairEyeColor)

rChartsObjeq <- setRefClass(
  "rChartsObjeq",
  contains = "Dimple",
  methods = list(
    initialize = function(){
      callSuper(); 
    },
    render = function(chartId = NULL, cdn = F, static = T){
      params$dom <<- chartId %||% params$dom
      template = read_file(getOption('RCHART_TEMPLATE', templates$page))
      assets = Map("c", get_assets(LIB, static = static, cdn = cdn), html_assets)
      html = render_template(template, list(
        params = params,
        assets = assets,
        chartId = params$dom,
        script = .self$html(params$dom),
        CODE = srccode,
        lib = LIB$name,
        tObj = tObj,
        container = container
      ))
    }
))

objeqPlot <- function(x, data, ...){
  myChart <- rChartsObjeq$new()
  myChart$getChartParams(x, data, ...)
  return(myChart$copy())
}

d1 <- objeqPlot(
  Freq ~ Sex,
  groups = "Hair",
  data = hairEye,
  type = "bar"
)
#d1$set(defaultColors=c())
d1$setLib(".")


d1$templates$page = "rCharts_objeq.html"
d1$templates$script = "./chart_objeq.html"
d1$setTemplate( afterScript = "<script></script>" )
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
  query = NULL,
  margins = list( bottom = 0, left = 60, top = 50, right = 0),
  height = 450
)
d3

#d3$save("rCharts_objeq_example3.html",cdn=T)

d4 <- d2
d4$templates$script = "./chart_objeq_facet.html"
d4$set(facet = list(x=NULL,y=NULL))
d4







##do it with data from research affiliates JOF article
#<blockquote>
#  <small><em style = "background-color:#E7E4E4;">data source:</em></small><br>
#  Arnott, Robert D., et al.<br>
#  <strong>The Surprising Alpha from Malkiel's Monkey and Upside-Down Strategies</strong><br>
#  The Journal of Portfolio Management 39.4 (2013): 91-105.
#</blockquote>
#read in the csv version of data
rebalStats <- read.csv(
  "../../research_researchaffiliates/global rebalance allocation stats.csv",
  stringsAsFactors = F
)

#make long form
rebalStats.melt <- reshape2::melt(
  rebalStats,
  id.vars = 1:3,
  variable.name = "Statistic",
  value.name = "Value"
)
rebalStats.melt$Value = as.numeric(rebalStats.melt$Value)

d5 <- objeqPlot(
  x = "Value",
  y = c("Strategy","Geography"),
  groups = c("Statistic","Geography","StrategyType","Strategy"),
  data = rebalStats.melt,
  type = "bubble",
  facet = list( y = "Statistic" ),
  query = 
  "Statistic IN ['Return','CAPMBeta','CAPMAlpha'] && (StrategyType == 'Averages' ||  '.*Weight' =~ StrategyType )",
  defaultColors = "d3.scale.category20()",
  height = 800,
  width = 800,
  margins = list( bottom = 10, left = 300, top = 30, right = 0)
)
d5$xAxis (
  type = "addMeasureAxis",
  outputFormat = ".2%" 
)
d5$yAxis ( type = "addCategoryAxis" )
d5$setLib(".")
d5$templates$page = "rCharts_objeq.html"
d5$templates$script = "./chart_objeq_facet.html"
d5

#d5$save( "rCharts_objeq_researchaffiliates.html", cdn = T)