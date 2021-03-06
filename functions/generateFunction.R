#' =============================================================================
#' File: template_funcs.R
#' Author: David Ruvolo
#' Created: 22 September 2016
#' Modified: 22 September 2016
#' Purpose: Quick and dirty function boiler plate
#' Use: source this file, and then run generateFunction
#' =============================================================================
#' FUNCTION
generateFunction <- function(filename, dir_path = NULL){
    
    #' prompt for filename if NULL
    if(is.null(filename)){
        warning("ERROR: File name is missing.", immediate. = TRUE)
    } else {
        filename = paste0(filename, ".R")
    }
    
    #' DETECT OS & SET DIR
    #' default will be github/rutils/functions
    os <- toupper(.Platform$OS.type)
    if(os == "UNIX" & is.null(dir_path)){
        user = Sys.getenv("USER")
        default_directory = paste0("/Users/",user,"/Github/Rutils/functions/")
        dir_path = paste0(default_directory, filename)
    }
    else if(os == "UNIX" & !is.null(dir_path)){
        user = Sys.getenv("USER")
        default_directory = paste0(dir_path)
        dir_path = paste0(default_directory, filename)
    }    
    else if(os == "WINDOWS" & is.null(dir_path)){
        user = Sys.getenv("USERNAME")
        default_directory = paste0("C:/Users/",user,"/Github/Rutils/functions/")
        dir_path = paste0(default_directory, filename)
    }
    else if(os == "WINDOWS" & !is.null(dir_path)){
        user = Sys.getenv("USERNAME")
        default_directory = paste0(dir_path)
        dir_path = paste0(default_directory, filename)
    }
    
    #' Begin building and sending outputs
    #' template will consist of:
    #'      --- a header
    #'      --- function
    #'      --- output display/message
    cat(paste0("Writing to: ", dir_path,"\n"))
    cat("=======================================================================\n")
    Sys.sleep(1)
    
    #' generate body
    #'      --- header
    #'      --- function shell
    
    cat("1. Generate Header")
    makeTemplateText(file_path = dir_path, text_type = "header")
    Sys.sleep(0.75)
    cat(".............Done!\n")
    Sys.sleep(0.75)
    
    cat("2. Make func shell")
    makeTemplateText(file_path = dir_path, text_type = "func")
    Sys.sleep(0.75)
    cat(".............Done!\n")
    Sys.sleep(0.75)
    
    cat("=======================================================================\n")
    Sys.sleep(0.75)
    cat("Status: COMPLETE")
    
    #' END
}


makeTemplateText <- function(file_path, text_type){
    
    #' manipulate text_type
    tt <- toupper(text_type)
    
    #' set type 1: file header
    if(tt == "HEADER" | tt == "HEAD"){
        text <- paste0(
            "#' =========================================================","\n",
            "#' File: ","\n",
            "#' Author: ","\n",
            "#' Created:", format(Sys.Date(),'%d %B %Y'),"\n",
            "#' Modified:","\n",
            "#' Purpose:","\n",
            "#' Use:","\n",
            "#' Notes:","\n",
            "#' ========================================================="
        )
    }
    
    #' set type 2: function shell
    if(tt == "FUNCTION" | tt == "FUNC"){
        text <- paste0(
            "#' BEGIN FUNCTION","\n",
            "funcion_name <- function(){","\n",
            "\n",
            "\n",
            "}"
        )
    }
    
    #' output text to file
    write(text, file = file_path, append = T)
    
}