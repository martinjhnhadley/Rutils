## load functions
# ====================
# loadR
# ====================
load.utils <- function(directory = "~/Github/Rutils/functions/", sort = "name"){
    
    # load package
    require(tools, quietly = T)
    
    # create file list
    filelist <- dir(directory)
    
    # message 1
    cat(paste0("I found: ", length(filelist), " packages. Loading...\n"))
    Sys.sleep(1)
        
    # load files
    for(i in 1:length(filelist)){
        if(file_ext(filelist[i]) == "R"){
            source(paste0(directory, filelist[i]))
        }
    }
    
    # message
    cat("Your functions located in '~/Github/Rutils/functions/' were loaded successfully!")
}