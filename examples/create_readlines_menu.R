# ######################################
# File: create_readlines_menu.R
# Date: 27 July 2016
# Author: David Ruvolo
# Purpose: Testing readline command for
#          creatings an input menu in R
# Packages: cowsay
# ######################################

# set 'exit'
exit = FALSE

# loop: while
while(!exit){
    
    # MAKE MENU -----------------------
cat("Which animal would you like to see?

\t01 = 'Chicken'
\t02 = 'Cat'
\t03 = 'Ghost'
\t99 = 'Exit'
")
    
    # SET INPUT VAR --------------------
    choice = readline(prompt = "Enter your selection: ")
    
    # MAKE OUTPUTS ---------------------
    if(choice == "01"){
        cowsay::say("Cluck Cluck",'chicken')
    }else if(choice == "02"){
        cowsay::say('catfact', 'cat')
    } else if(choice == "03"){
        cowsay::say('Spooky Scary!','ghost')
    }
    else if(choice == "99"){
        exit = T            # exit menu
        cowsay::say(what = "Goodbye!", 
                    by = 'signbunny')
    }
    # --------------------------------
} 

## END