#' =========================================================
#' File: describeDF.R
#' Author: David Ruvolo
#' Created: 18 August 2016
#' Modified: 22 September 2016
#' Purpose: quick and dirty way to describe DF
#' Use: source file and then call function
#' Notes: NA
#' =========================================================
#' BEGIN FUNCTIONS
describeDF <- function(dataframe){
    
    #' essentially builds DF output inline
    data.frame(
        
        #' col 1: Measure
        "Measure" = c(
                    "Columns",                  ## number of columns
                    "Rows",                     ## number of rows
                    "Num Cols Characters",      ## cols whose class = character
                    "Num Cols Factors",         ## cols whose class = factors
                    "Num Cols Numeric",         ## cols whose class = numeric
                    "Num Cols Integer"          ## cols whose class = integer
                     ),
        
        #' col 2: count
        "Count" = c(
                    NCOL(dataframe),                                              ## cols count
                    NROW(dataframe),                                              ## row count
                    length(dataframe[,sapply(dataframe, class) == 'character']),  ## char count
                    length(dataframe[, sapply(dataframe, class) == 'factor']),    ## factor count
                    length(dataframe[, sapply(dataframe, class) == 'numeric']),   ## numeric count
                    length(dataframe[, sapply(dataframe, class) == 'integer'])    ## integer count 
                    )
    )
}