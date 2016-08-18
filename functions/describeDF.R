## ################################
## File: describeDF.R
## Author: David Ruvolo
## Created: 18 August 2016
## Purpose: describe DF
## Main Call: describeDF(dataframe)
## ################################

describeDF <- function(dataframe){
    data.frame(
        "Measure" = c(
                    "Columns",                  ## number of columns
                    "Rows",                     ## number of rows
                    "Num Cols Characters",      ## cols whose class = character
                    "Num Cols Factors",         ## cols whose class = factors
                    "Num Cols Numeric",         ## cols whose class = numeric
                    "Num Cols Integer"          ## cols whose class = integer
                     ),
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