## Clear Series
#===============================================================================
# clear console screen    
#===============================================================================
clear.console <- function(){
    
    cat("\014") # command to clear screen wrapped in a function
    
}
#===============================================================================
# clear ls() minus functions
#===============================================================================
clear.environment <- function(){
    ENV <- globalenv()
    ll <- ls(envir = ENV)
    ll <- subset(ll, ll != "load.utils")
    ll <- subset(ll, ll != "clear.console")
    ll <- subset(ll, ll != "clear.environment")
    ll <- subset(ll, ll != "custom.ggplot.themes.nl")
    ll <- subset(ll, ll != "custom.ggplot.themes.wl")
    ll <- subset(ll, ll != "dates.add.months")
    ll <- subset(ll, ll != "dates.print.MonthsYears")
    ll <- subset(ll, ll != "DAYS")
    ll <- subset(ll, ll != "get.filesize")
    ll <- subset(ll, ll != "get.string")
    ll <- subset(ll, ll != "get.functions")
    ll <- subset(ll, ll != "knot.ggplots")
    ll <- subset(ll, ll != "multi.ggplot")
    ll <- subset(ll, ll != "make_html_table")
    ll <- subset(ll, ll != "make_xtable")
    ll <- subset(ll, ll != "month.converter")
    ll <- subset(ll, ll != "MONTHS")
    ll <- subset(ll, ll != "num.months")
    ll <- subset(ll, ll != "num.weekdays")
    ll <- subset(ll, ll != "stopwatch")
    ll <- subset(ll, ll != "summary.to.table")
    ll <- subset(ll, ll != "title.to.table")
    rm(list = ll, envir = ENV)
}