#'==============================================================================
#' FILE: funcs.R
#' DIR: ukb_preprocessing/scripts/utils/...
#' AUTHOR: David C Ruvolo
#' DATE CREATED: 17 NOVEMBER 2016
#' DATE MODIFIED: 17 NOVEMBER 2016
#' PURPOSE: functions for ukb data extraction
#'==============================================================================

#' DETECT OPERATING SYSTEM
myOS <- function(){
    # detect os and return as upper
    toupper(.Platform$OS.type)
}
