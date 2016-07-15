## A Variety of data/time functions
#===============================================================================
# CALENDAR SERIES
#===============================================================================
# Create MONTHS of the year list
MONTHS <- c("January","Febraury","March","April","May","June",
            "July","August","September","October","November","December")
#---------------------------
# Create DAYS of the week list
DAYS <- c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
#---------------------------
# increase date by n months
dates.add.months <- function(date,n){
    # add n to a date and keep date format
    # seq input date and increase month position
    seq(date, by = paste (n, "months"), length = 2)[2]
}
#---------------------------
# print a list based on the the number of months between two dates
# return as list formatted as "Month Year" (i.e., Febraury 2016) OR "%M %Y"
dates.print.MonthsYears <- function(start_date, end_date){
    
    # calls num.months() function written in the next section
    reps = num.months(end_date,start_date)
    
    # loop through the n months and print month/year format
    for(i in 1:reps){
        # for first case only, must initialize list
        if(i ==1 ){
            months_order = format(dates.add.months(start_date,0),"%B %Y")
        }
        # loop through the remaining cases until the end
        months_order = c(months_order,format(dates.add.months(start_date,i),"%B %Y"))
    }
    # return list
    return(months_order)
}
#===============================================================================
# NUM series
#===============================================================================
# Calculate the number of week days between two dates

num.weekdays <- function(start_date,end_date)
{
    # FORMAT: NWEEKDAYS("11/15/2015","11/24/2015")
    
    dates <- as.numeric((as.Date(start_date,"%m/%d/%y")):(as.Date(end_date,"%m/%d/%y")))
    
    dates <- dates[- c(1,length(dates))]
    
    return(sum(!dates%%7%in%c(0,6)))
    
}
# Calculate the number of dates between two dates
num.months <- function(end_date, start_date){
    
    ed <- as.POSIXlt(end_date)
    
    sd <- as.POSIXlt(start_date)
    
    12 * (ed$year - sd$year) + (ed$mon - sd$mon)
}

#===============================================================================
# Title: Month <-> Month Name Converter
# Created: July 23, 2015
# Author: David Ruvolo 
# 
# Instructions: assign function to variable than enter type
#===============================================================================
month.converter <- function(ui.month){
    if(class(ui.month) == 'numeric') {
        # -----------------------
        if(ui.month == 1){
            out <- "January" 
        } else if(ui.month == 2){
            out <- "February"
        } else if(ui.month == 3){
            out <- "March"
        } else if (ui.month == 4){
            out <- "April"
        } else if (ui.month == 5){
            out <- "May"
        } else if (ui.month == 6){
            out <- "June"
        } else if (ui.month == 7){
            out <- "July"
        } else if (ui.month == 8){
            out <- "August"
        } else if (ui.month == 9){
            out <- "September"
        } else if (ui.month == 10){
            out <- "October"
        } else if (ui.month == 11){
            out <- "November"
        } else if (ui.month == 12){
            out <- "December"
        }
        # -----------------------------------
        # --------------------------------------
    } else if (class(ui.month)== 'character'){
        if (ui.month == "January" | ui.month == "january" | ui.month == "jan" | ui.month == "Jan"){
            out <- 1
        } else if (ui.month == "February"| ui.month == "february" | ui.month == "feb" | ui.month == "Feb"){
            out <- 2
        } else if (ui.month == "March"| ui.month == "march" | ui.month == "mar" | ui.month == "Mar"){
            out <- 3
        } else if (ui.month == "April"| ui.month == "april" | ui.month == "apr" | ui.month == "Apr"){
            out <- 4
        } else if (ui.month == "May"| ui.month == "may"){
            out <- 5
        } else if (ui.month == "June"| ui.month == "june"){
            out <- 6
        } else if (ui.month == "July"| ui.month == "july"){
            out <- 7
        } else if (ui.month == "August"| ui.month == "august" | ui.month == "aug" | ui.month == "Aug"){
            out <- 8
        } else if (ui.month == "September"| ui.month == "september" | ui.month =="sept" | ui.month == "Sept"){
            out <- 9
        } else if (ui.month == "October"| ui.month == "october" | ui.month == "oct" | ui.month == "Oct"){
            out <- 10
        } else if (ui.month == "November"| ui.month == "november" | ui.month == "nov" | ui.month == "Nov"){
            out <- 11
        } else if (ui.month == "December"| ui.month == "december" | ui.month == "dec" | ui.month == "Dec"){
            out <- 12
        }
    } else {
        out <- "NA"
    }
    return(out)
}
