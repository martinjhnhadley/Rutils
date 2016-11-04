#'==============================================================================
#' FILE: Timestamp printer
#' DATE CREATED: 04 november 2016
#' LAST MODIFIED: 04 november 2016
#' AUTHOR: david c ruvolo
#' USAGE: simple call to printTimestamp
#' NOTES: must have lubridate
#'==============================================================================
printTimestamp <- function(docType = NULL){
    
    # LOAD PACKAGE
    require(lubridate, quietly = T)
    
    # GET NOW
    now <- as.POSIXct(Sys.time())
    
    ## OUTPUT
    paste0(
        # PRINT TEXT
        "This ", 
        ifelse(is.null(docType), "document", docType),
        " was generated on ", 
        # PRINT DATE
        format(now, "%A, %d %B %Y at %T %p %Z")
    )
}
