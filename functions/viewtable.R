#'=============================================================================
#' Title: view.table()
#' Author: Ramnath
#' Source: https://stackoverflow.com/questions/22863771/is-it-possible-to-view-an-html-table-in-the-viewer-pane
#' Purpose: Tired of viewing outputs in the console, better in the viewer
#' Revised: 09 September 2016 by David Ruvolo
#' Notes: added attr to internal capture.output to cleanup execution
#' =============================================================================
#' MAKE FUNCTION:
viewTable <- function(x, ...){
    
    ## require packages
    require(knitr, quietly = T)
    
    ## get ouput and send to temp
    tab <- paste(capture.output(kable(x,format = "html", table.attr = "class=nofluid", ...)), collapse = '\n')
    tf <- tempfile(fileext = ".html")
    writeLines(tab, tf)
    
    # print
    rstudio::viewer(tf)
}
#' EXAMPLES
#' viewTable(mtcars[1:10,])
#' viewTable(mtcars[1:10,], caption = paste0("Hello, World! ", Sys.Date()))
#' viewTable(mtcars[1:10,], caption = paste0("mtcars Dataset"), row.names = F)
#' ??kable  # for additional options
