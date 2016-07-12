# Unit Conversion Script
# Instructions = simply type in a temperature and the unit of the temp you entered
# Currently the function only converts Celsius to Fahren and vice versa. More to Come!
# ====== Script Details ====== #
# Author = David Ruvolo
# file = conversion_script.R
# version = 0.0.1
# Creation Date = Friday November 14 2014 13:12
# Last Modified Date = Friday November 14 2014
# ====== Update History ====== # 
# v0.0.1:
#   - Creation, tested out individual functions of temperature conversions
#   - combined C -> F & F -> C fuctions to create a overall temp function
# ============================ #
temperature <- function(temp,temp_unit){
      # From Celcius to Fahrenheit
      if(temp_unit == "f"){
            celsius_temp = (temp-32) * 5/9
            celsius_temp <- round(celsius_temp, digits = 2)
            message("## ",temp, " degrees Fahrenheit = ", celsius_temp, " degrees Celsius.")
      } else if(temp_unit == "c") {
            # from Fahrenheit to Celsius
            fahrenheit_temp = temp * (9/5) + 32
            fahrenheit_temp <- round(fahrenheit_temp,digits = 2)  
            message ("## ",temp, " degrees Celsius = ", fahrenheit_temp," degrees Fahrenheit.") 
      }
}