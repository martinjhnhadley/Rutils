## ##########################
## FUNCTION: random.date
## AUTHOR: David Ruvolo
## CREATED: 19 August 2016
## PURPOSE: samples dates
## ##########################
random.date<-function(year.floor, year.ceiling, reps){
    
    ## create blank matrix
    out <- matrix(nrow = 12, ncol = 1)
    colnames(out) <- c("Date")
    
    for(i in 1:reps){
        
        ## SAMPLE YR + MONTH
        yrs<-sample(year.floor:year.ceiling, 1, replace=TRUE)   ## sample year btwn limits
        mon <- sample(1:12,1,replace=TRUE)                      ## sample month
        
        # SAMPLE DAYS
        if(mon == 4 || mon == 6 || mon == 9 || mon == 11){
            
            day <- sample(1:30,1,replace = TRUE)
            
        }else if(mon == 2){
            
            day <- sample(1:28,1,replace = TRUE)
            
        }else{
            
            day <-sample(1:31,1,replace=TRUE)
            
        }
        
        
        ## BUILD DATE
        
        if(mon < 10){
            
            mon <- paste0(0,mon)
        }
        
        if(day < 10){
            
            day = paste0(0,day)
        }
        
        o.date <- paste0(yrs,"-",mon,"-",day)#, " ", format(Sys.time(),"%Z"))
        
        ## SAMPLE TIME
        time =  as.POSIXct(runif(1, 0, 24*60*60), origin = o.date)
        
        ## APPEND W/TIME
        o.date = paste0(time, " ", format(Sys.time(),"%Z"))
        
        ## ASSIGN TO MATRIX
        if( i == 1 ){
            
            out[1] <- o.date
            
        } else {
            
            out[i] <- o.date
            
        }
        
        ## CLEAR DATE
        o.date = ""
    }
    
    ## RETURN MATRIX
    data.frame(out)
}

# random.date(year.floor = 2010, year.ceiling = 2016, reps = 12)