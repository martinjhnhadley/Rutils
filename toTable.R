## to.table series
#===============================================================================
# Send a header to a .csv file to organize describeBy calculatiions. 
# Saves to pwd by default
#===============================================================================
title.to.table<-function(header,filename = NULL, replace = TRUE){
    # conditional statement for filename
    if(is.null(filename)){
        # create default filename
        path.filename = paste0(getwd(),"/outputs_",format(Sys.Date(),"%Y%m%d"),".csv") 
    } 
    else if(!is.null(filename)){
        # take user input
        path.filname = filename
    }
    # save outputs
    write.table(header,file=path.filename, append = replace, 
                sep = ",", col.names = F, row.names = F)
    
    # output message
    message(paste0("Your file is located in the following directory: ~",path.filename))
    
}
#===============================================================================
# Send desribeBy calculations to a .csv file. 
# Saves to pwd, file name is always "parameters.csv"
#===============================================================================
summary.to.table<-function(totable, filename = NULL, replace = TRUE){
    # conditional statement for filename
    if(is.null(filename)){
        # create default filename
        path.filename = paste0(getwd(),"/outputs_",format(Sys.Date(),"%Y%m%d"),".csv") 
    } 
    else if(!is.null(filename)){
        # take user input
        path.filname = filename
    }
    
    # save outputs
    write.table(totable,file=path.filename, append = replace, sep=",",row.names = FALSE)
    
    # output message
    message(paste0("Your file is located in the following directory: ~",path.filename))
    
} 