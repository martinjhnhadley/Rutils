# Unit Conversion Script
# Instructions = simply type in a temperature and the unit of the temp you entered
# Currently the function only converts Celsius to Fahren and vice versa. More to Come!
# ====== Script Details ====== #
# Author = David Ruvolo
# file = conversion_script.R
# Creation Date = Friday November 14 2014 13:12
# Last Modified Date = 12 August 2016
# ============================ #
temperature <- function(temp,temp_unit){
        # From Fahrenheit to Celsius
      if(temp_unit == "f" | temp_unit == "F" | temp_unit == "fahrenheit" | temp_unit == "Fahrenheit"){
            celsius_temp = (temp-32) * 5/9
            celsius_temp <- round(celsius_temp, digits = 2)
            cat("##",temp, " degrees F = ", celsius_temp, "degrees Celsius.")
      # From Celcius to Fahrenheit
      } else if(temp_unit == "c" | temp_unit == "C" | temp_unit == "celsius" | temp_unit == "Celsius") {
            fahrenheit_temp = temp * (9/5) + 32
            fahrenheit_temp <- round(fahrenheit_temp,digits = 2)  
            cat("##",temp, "degrees C =", fahrenheit_temp,"degrees Fahrenheit.") 
      }
}