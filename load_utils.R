## load functions
# ====================
# loadR
# ====================
load.utils <- function(directory = "~/Github/mygithub/Rutils/functions/", sort = "name"){
    
    # load package
    require(tools, quietly = T)
    
    # create file list
    filelist <- dir(directory)
    
    # message 1
    cat(paste0(length(filelist), " files found. Loading..."))
    Sys.sleep(1.5)
        
    # load files
    for(i in 1:length(filelist)){
        if(file_ext(filelist[i]) == "R"){
            source(paste0(directory, filelist[i]))
        }
    }
    cat("Done!\n")
    Sys.sleep(0.75)
    
    # message
    cat(paste0("Your functions located in ",directory," were loaded successfully!"))
}