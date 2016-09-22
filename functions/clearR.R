#' =============================================================================
#' File: clearR.R
#' Author: David Ruvolo
#' Created: 15 July 2016
#' Modified: 22 September 2016
#' Purpose: Basic clearing functions
#' Use: source this file, and then run: clear.console() or clear.environment()
#' Notes: NA
#' =============================================================================
#' FUNCTIONS

#' clear console screen    

clear.console <- function(){
    
    cat("\014") # command to clear screen wrapped in a function
    
}

#' clear global env minus functions

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
    ll <- subset(ll, ll != "multi.ggplot")
    ll <- subset(ll, ll != "load.utils")
    ll <- subset(ll, ll != "make_it_shiny")
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