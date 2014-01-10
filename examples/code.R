#if you have not installed the newest dev branch of rCharts
#require(devtools)
#install_github("rCharts","timelyportfolio",ref="objeq")
#setwd("C:/Users/Kent.TLEAVELL_NT/Dropbox/development/r/rCharts")
#install()

library(rCharts)

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
d1$templates$script = paste0(getwd(),"/chart_objeq.html")
d1
