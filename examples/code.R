#if you have not installed the newest dev branch of rCharts
#require(devtools)
#install_github("rCharts","ramnathv",ref="dev")

library(rCharts)

hairEye <- as.data.frame(HairEyeColor)

d1 <- dPlot(
  Freq ~ Sex,
  groups = "Hair",
  data = hairEye,
  type = "bar"
)
d1$setLib(".")
d1$templates$page = paste0(getwd(),"/rCharts_objeq.html")
d1$templates$script = paste0(getwd(),"/chart_objeq.html")
d1
