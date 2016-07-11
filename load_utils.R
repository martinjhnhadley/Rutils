## load functions
# ====================
# loadR
# ====================
#setwd("~/Github/Rutils/")
load.utils <- function(x = dir("~/Github/Rutils/"), sort = "name"){
    
    # load package
    require(tools, quietly = T)
    
    # message 1
    cat("Getting your functions...")
    Sys.sleep(1)
    
    # get file name, type, size
    for (i in 1:length(x)){
        if(i == 1){
            name <- as.character(x[i])
            type <- file_ext(x[i])
            size <- as.numeric(round(file.size(x[i]) / 1048576, 2))
        }
        else{
            name <- rbind(name, x[i])
            type <- rbind(type, file_ext(x[i]))
            size <- rbind(size, as.numeric(round(file.size(x[i])/1048576, 2)))
        }
    }
    
    # make df
    df <- cbind(name, type, size)
    df <- data.frame(df, stringsAsFactors = F, row.names = 1:length(x))
    colnames(df) <- c("Name","Type", "Size")
    df$Size <- as.numeric(df$Size)
    
    # message 2
    cat("\nLoading them for your viewing pleasure...")
    Sys.sleep(1)
    
    # load files
    for(i in 1:length(df$Name)){
        if(df$Type[i] == "R"){
            source(df$Name[i])   
        }
    }
    
    # message 3
    cat("\nDone!")
}