#' =============================================================================
#' File: load_utils.R
#' Created: 11 July 2016
#' Modified: 21 September 2016
#' Purpose: Quick and dirty file loader for functions
#' Use: source this file, and then run load.utils
#' =============================================================================
#' FUNCTION
load.utils <- function(directory = NULL){
    
    #' Read directory 
    #' set default directory to Rutils
    if(is.null(directory)){
        directory <- "~/Github/Rutils/functions/"
    }
    
    #' load package or install if not found
    if("tools" %in% rownames(installed.packages()) == FALSE){ # search package names
    
        install.packages("tools",dependencies = T) # otherwise install w/dependencies
    
    } else {
    
        require(tools, quietly = T) # else load quietly 
        
    }
    
    #' create file list in directory
    filelist <- dir(directory)
    
    #' message 1
    cat(paste0("Loading from: ", directory,"\n"))
    cat("=======================================================================\n")
    cat(paste0("Files found: ", length(filelist), "\n"))
        
    #' load files and message user
    for(i in 1:length(filelist)){
        if(file_ext(filelist[i]) == "R"){
            cat(paste0(i,". ", "Load: ", filelist[i]))
            source(paste0(directory, filelist[i]))
            Sys.sleep(0.75)
            cat(".....................Complete!\n")
            Sys.sleep(1)
        }
    }
    
    #' complete display
    cat("=======================================================================\n")
    cat("Status: Done!\n")
}