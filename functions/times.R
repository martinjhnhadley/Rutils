## ############################
## File: times.R
## Author: David Ruvolo
## Purpose: get greeting 
##          based on curr time
## Version: 1.0
## ############################

## good_time()

good_time <- function(){

    ## LOAD PACKAGE
    require(lubridate, quietly = T)

    ## ISOLATE currHour
    currhour = hour(now())

    ## RUN LOGIC
    
    if(currhour < 12){

        return("good morning")
    
    } 
    
    else if(currhour >= 12 & currhour < 17){

        return("good afternoon")

   }

   else if( currhour >= 17){

        return("good evening")

   }

}

