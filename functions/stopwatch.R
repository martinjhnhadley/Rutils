## Handy stopwatch function
#===============================================================================
# stopwatch: H:M:S
#===============================================================================

clear.console <- function(){
    
    cat("\014") # command to clear screen wrapped in a function
    
}

stopwatch <- function(){
    
    if(exists("value")==FALSE){
        value = 1
    }
    
    # define time units
    hour = 0
    minute = 0
    second = 0
    
    cat("Welcome to StopwatchR!\n\n",
        "\tTime elapsed: ",
        ifelse(hour < 10, paste0(0,hour), hour),
        ":",
        ifelse(minute < 10, paste0(0,minute),minute),
        ":",
        ifelse(second < 10, paste0(0, second), second),
        "\n\nPress ESC to stop."
    )
    
    while(value == 1){
        
        clear.console()
        
        second = second + 1
        
        if(second == 60){
            
            minute = minute + 1
            
            second = 0
            
        } else if(minute == 60){
            
            hour = hour + 1
            
            minute = 00
            
            second = 00
        }
        
        cat("Welcome to StopwatchR!\n\n",
            "\tTime elapsed: ",
            ifelse(hour < 10, paste0(0,hour), hour),
            ":",
            ifelse(minute < 10, paste0(0,minute),minute),
            ":",
            ifelse(second < 10, paste0(0, second), second),
            "\n\nPress ESC to stop."
        )
        
        Sys.sleep(1)
    }
}



timer <- function(interval = 10){
    ## https://stackoverflow.com/questions/4853596/how-to-best-create-a-timer-function-in-r
    ## =============================
    ## Print greeting
    cat("Welcome to timeR!\n\n")
    total = readline(prompt = "How long would you like to set in seconds?")
    
    interval = 1    
    t0 <- Sys.time()

    seconds <- round(as.double( difftime(Sys.time(), t0, u = 'secs')))
    if(seconds > total)
    return(-1) else
    return(trunc( 1 + (seconds / interval ) ) %% 2)
}