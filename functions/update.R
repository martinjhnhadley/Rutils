# ##############################################################################
# Title: Script for Updating R in Windows (not mac)
# Created: 3/20/2014 @ 8:44 AM CST
# Author: David
# Source: http://www.r-statistics.com/2013/03/updating-r-from-r-on-windows-using-the-installr-package/
# ##############################################################################
#Tell R to check for updates and if there is a newer version, install and keep packages.

# CODE
# installing/loading the package:

# 1
# if(!require(installr)) { 
#    install.packages("installr") 
#    require(installr)} #load / install+load installr
# 2
# updateR(F, T, T, F, T, F, T) 
# install, move, update.package, quit R. 
# Follow the on screen instructions and you may have to hit next, okay, etc.
# Program will exit once updates are installed and packages are moved back to the library().  


#progBar <- function(x = sort(runif(20)), ...)
#{
#    pb <- txtProgressBar(char=".",...)
#    for(i in c(0, x, 1)) {Sys.sleep(0.5); setTxtProgressBar(pb, i)}
#    Sys.sleep(1)
#    close(pb)
#}
#testit()
#testit(runif(10))
#testit(style = 3)
