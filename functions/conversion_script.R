#' =============================================================================
#' File: conversion_script.R
#' Author: David Ruvolo
#' Created: 14 November 2014
#' Modified: 22 September 2016
#' Purpose: Useful conversions
#' Use: source this file, and then run: temperature()
#' Notes: simply type in a temperature and the unit of the temp you entered
#' =============================================================================
#' FUNCTION
temperature <- function(temp,temp_unit){
    
    #' manipulate temp_unit
    tu <- toupper(temp_unit)
    
    #' From Fahrenheit to Celsius
    if(tu == "F" | tu == "FAHRENHEIT"){
        
        #' convert + round    
        celsius_temp = (temp-32) * 5/9
        celsius_temp <- round(celsius_temp, digits = 2)
        
        #' output answer
        cat("##",temp, " degrees F = ", celsius_temp, "degrees Celsius.")
        
    } 
    
    #' From Celcius to Fahrenheit
    else if(tu == "C" | tu == "CELSIUS") {
        
        #' convert + round
        fahrenheit_temp = temp * (9/5) + 32
        fahrenheit_temp <- round(fahrenheit_temp,digits = 2)  
        
        # output answer
        cat("##",temp, "degrees C =", fahrenheit_temp,"degrees Fahrenheit.") 
        
    }
}