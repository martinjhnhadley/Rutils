# ##############################################################################
# Title: package_checker()
# Purpose: checker to see if package is installed. If not, install. If true, load.
# Date Created: Saturday July 30, 2016
# ##############################################################################
libraryCheck <- function(package, install = TRUE){   
    
    # IS.NA MESSAGE
    ifelse(is.na(package), warning("ERROR: no input given", immediate. = T),"")
    
    ## SEARCH RESULT
    check <- package %in% rownames(installed.packages())
    
    ## CONDITIONS
    if(check == TRUE){
        
        ## ALERT ACTION
        cat("Package exists. Loading...")
        
        ## LOAD PACKAGE
        library(package, character.only = T)
        
        ## EXIT
        cat("Done!")
    }
    
    else if(check == FALSE & install == TRUE){
        
        ## ALERT ACTION
        cat("Package does not exist in your library. Downloading it for you...")
        
        ## INSTALL PACKAGE
        install.packages(package,dependencies = T)
        
        ## LOAD PACKAGE
        library(package, character.only = T)
    }
    
    else if (check == FALSE & install == FALSE){
        
        ## ALERT ACTION
        cat("Package does not exist in your library. \nIf you would like to install it, rerun with 'install = T'.")
        
    }
    
}