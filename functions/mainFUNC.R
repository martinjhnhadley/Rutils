## file: mainFunc.R
## author: David Ruvolo
## date modified: 2016-01-11 
## summary: collection of commonly used functions
## Location: "~/Github/Rutils/mainFUNC.R"
#===============================================================================
#---------------------------- X TABLE CUSTOM FUNCTION -------------------------#
# Two main commands: make_xtable() & make_html_table()
# 
#===============================================================================
make_xtable <- function(mydata, title = NULL, alignment = NULL,
                        rotate = NULL, color = NULL, cnames = TRUE, rnames = FALSE){
    
    # ====================== 
    # check library() for xtables if not, install, otherwise load xtables
    
    if("xtable" %in% rownames(installed.packages()) == FALSE){ # search package names
        
        install.packages("xtables",dependencies = T) # otherwise install w/dependencies
        
    } else {
        
            require(xtable, quietly = T) # else load quietly 
    }
    
    # ======================
    if (is.null(mydata)){
        
        print("ERROR: Input data not found. Check for valid dataset.")
   
    # ======================
        
    } else if (!is.null(mydata)){

        # ================================
        # if ncol = 1

        if (NCOL(mydata) == 1){
            
            # create color per row (default is grey95)
            
            rws <- seq(1, nrow(mydata) - 1, by = 2)
            
            if(!is.null(color)){
                
                col <- rep(paste0("\\rowcolor{",color,"}"),length(rws))  
                
            } else{ 
                
                col <- rep("\\rowcolor[gray]{0.95}", length(rws))
                
            }
            
            # -----------------------------------------------
            # create loop for centering all columns when NULL
            
            if (is.null(alignment)){
                
                alignment <- rep("c",ncol(mydata)+1)
                
            }
            
            print(xtable(x = mydata,align = alignment,caption = title), 
                  
                  type="latex",booktabs = TRUE,
                  
                  include.rownames = rnames, include.colnames = cnames, 
                  
                  caption.placement = "top",
                  
                  sanitize.colnames.function = identity, 
                  
                  comment = FALSE,
                  
                  add.to.row = list(pos=as.list(rws),command = col))
            
            # -----------------------------------------------    
            # if data contains more than one column
            # for alternating color across all rows
        
        } else {
            
            # create color per row (default is grey95)
            
            rws <- seq(1, nrow(mydata) - 1, by = 2)
            
            # if color is specified -- needs to be defined in YAML/Preamble
            if(!is.null(color)){
                
                col <- rep(paste0("\\rowcolor{",color,"}"),length(rws))   
                
            } else{
                
                col <- rep("\\rowcolor[gray]{0.95}", length(rws))
                
            }
            # -----------------------------------------------
            # create loop for centering all columns when NULL
            if (is.null(alignment)){
                
                alignment <- rep("c",ncol(mydata)+1)
                
            }
            # -----------------------------------------------
            # if/then statement for rotating the table or not
            
            if (is.null(rotate)){
                
                # print non-rotated table
                
                print(xtable(x = mydata,align = alignment,caption = title),
                      
                      type="latex",booktabs = TRUE,
                      
                      include.rownames = rnames, include.colnames = cnames, 
                      
                      caption.placement = "top",
                      
                      sanitize.colnames.function = identity, 
                      
                      comment = FALSE,
                      
                      add.to.row = list(pos=as.list(rws),command = col))
            } else {
                
                # print rotated table
                
                print(xtable(x = mydata,align = alignment,caption = title),
                      
                      type="latex",booktabs = TRUE,
                      
                      include.rownames = rnames, include.colnames = cnames,
                      
                      caption.placement = "top", 
                      
                      floating.environment="sidewaystable",
                      
                      sanitize.colnames.function = identity, comment = FALSE,
                      
                      add.to.row = list(pos=as.list(rws),command = col))
                
            }
            
        } 
        
    } else {
        
        # fatal flaw msg - this should never happen!
        
        print("ERROR: Fatal error. Consult source code.")
        
    }
    
}

#===============================================================================
#------------------------------ MAKE HTML TABLE -------------------------------#
# function for xtable formatting; type = html
#===============================================================================
make_html_table <- function(mydata,title = NULL,alignment=NULL,altRowColor = FALSE,altColColor = FALSE,rnames = FALSE){
    
    # load package
    # ====================== 
    # check library() for xtables if not, install, otherwise load xtables
    
    if("htmlTable" %in% rownames(installed.packages()) == FALSE){ # search package names
        
        install.packages("htmlTable",dependencies = T) # otherwise install w/dependencies
        
    } else {
        
        require(htmlTable, quietly = T) # else load quietly 
    }

    if (is.null(mydata)){
        
        print("ERROR: Input data not found. Check for valid dataset.")
        
    # ======================
    # if mydata is not missing then make table
    } else if (!is.null(mydata)){    
        # make default alignment = center all columns
        if(is.null(alignment)){
            alignment = rep("c",ncol(mydata))
        }
        # make defaut row color when set to TRUE (color is gray)
        if(altRowColor == T){
             rowcolor = rep(c("none","#F2F2F2"),NROW(mydata))
        }
        else{
            rowcolor = "none"
        }
        # make default column when set to TRUE (color is gray)
        if(altColColor == T){
            colcolor = rep(c("none","#F2F2F2"),NROW(mydata))
        }
        else{
            colcolor = "none"
        }
        #print htmlTable
        htmlTable(mydata,
                  
                  align = alignment,
                  
                  #cgroup = c("","Testing The Code"),
                  
                  #n.cgroup = c(1,3),
                  
                  # htmlTable caption 
                  pos.caption = "top",
                  caption=title,
                  
                  # ROWS
                  col.rgroup = rowcolor, # row color
                  rnames = rnames, # row names shown?
                  
                  # column color 
                  col.columns = colcolor,
                  
                  # padding 
                  css.cell = "padding-left: .5em; padding-right: .2em;")
        
    }
    
    # ======================
    
    else {
        
        # fatal flaw msg - this should never happen!
        
        print("ERROR: Fatal error. Consult source code.")
        
    }
}
#===============================================================================
# CALENDAR SERIES
#===============================================================================
# Create MONTHS of the year list
MONTHS <- c("January","Febraury","March","April","May","June",
               "July","August","September","October","November","December")
#---------------------------
# Create DAYS of the week list
DAYS <- c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
#---------------------------
# increase date by n months
dates.add.months <- function(date,n){
    # add n to a date and keep date format
    # seq input date and increase month position
    seq(date, by = paste (n, "months"), length = 2)[2]
}
#---------------------------
# print a list based on the the number of months between two dates
# return as list formatted as "Month Year" (i.e., Febraury 2016) OR "%M %Y"
dates.print.MonthsYears <- function(start_date, end_date){
    
    # calls num.months() function written in the next section
    reps = num.months(end_date,start_date)
    
    # loop through the n months and print month/year format
    for(i in 1:reps){
        # for first case only, must initialize list
        if(i ==1 ){
            months_order = format(dates.add.months(start_date,0),"%B %Y")
        }
        # loop through the remaining cases until the end
        months_order = c(months_order,format(dates.add.months(start_date,i),"%B %Y"))
    }
    # return list
    return(months_order)
}
#===============================================================================
# NUM series
#===============================================================================
# Calculate the number of week days between two dates

num.weekdays <- function(start_date,end_date)
{
    # FORMAT: NWEEKDAYS("11/15/2015","11/24/2015")
    
    dates <- as.numeric((as.Date(start_date,"%m/%d/%y")):(as.Date(end_date,"%m/%d/%y")))
    
    dates <- dates[- c(1,length(dates))]
    
    return(sum(!dates%%7%in%c(0,6)))
    
}
# Calculate the number of dates between two dates
num.months <- function(end_date, start_date){
    
    ed <- as.POSIXlt(end_date)
    
    sd <- as.POSIXlt(start_date)
    
    12 * (ed$year - sd$year) + (ed$mon - sd$mon)
}

#===============================================================================
# Send a header to a .csv file to organize describeBy calculatiions. 
# Saves to pwd by default
#===============================================================================
title.to.table<-function(header,filename = NULL, replace = TRUE){
    # conditional statement for filename
    if(is.null(filename)){
        # create default filename
        path.filename = paste0(getwd(),"/outputs_",format(Sys.Date(),"%Y%m%d"),".csv") 
    } 
    else if(!is.null(filename)){
        # take user input
        path.filname = filename
    }
    # save outputs
    write.table(header,file=path.filename, append = replace, 
                sep = ",", col.names = F, row.names = F)
    
    # output message
    message(paste0("Your file is located in the following directory: ~",path.filename))

}
#===============================================================================
# Send desribeBy calculations to a .csv file. 
# Saves to pwd, file name is always "parameters.csv"
#===============================================================================
summary.to.table<-function(totable, filename = NULL, replace = TRUE){
    # conditional statement for filename
    if(is.null(filename)){
        # create default filename
        path.filename = paste0(getwd(),"/outputs_",format(Sys.Date(),"%Y%m%d"),".csv") 
    } 
    else if(!is.null(filename)){
        # take user input
        path.filname = filename
    }
    
    # save outputs
    write.table(totable,file=path.filename, append = replace, sep=",",row.names = FALSE)
    
    # output message
    message(paste0("Your file is located in the following directory: ~",path.filename))
    
} 
#===============================================================================
# GGPLOT + RCOLORBREWER STUFF
#===============================================================================
# Save multiple ggplot graphs into a single pdf
# packages: gridExtra and ggplot2
# specify columns, 

knot.ggplots<-function(gg1,gg2, cols = 1, rows = 2){
    
    # check library() for ggplot2 if not, install, otherwise load xtables
    # -------------------------------------------------------------------
    if("ggplot2" %in% rownames(installed.packages()) == FALSE){ # search package names
        
        install.packages("ggplot2",dependencies = T) # otherwise install w/dependencies
        
    } else {
        
        require(ggplot2, quietly = T) # else load quietly 
    }
    # check library() for gridextra. If not, install, otherwise load
    # -------------------------------------------------------------------
    if("gridExtra" %in% rownames(installed.packages()) == FALSE){ # search package names
        
        install.packages("gridExtra",dependencies = T) # otherwise install w/dependencies
        
    } else {
        
        require(gridExtra, quietly = T) # else load quietly 
    }
    # -------------------------------------------------------------------
    
    plot1 <- ggplotGrob(gg1)
    
    plot2 <- ggplotGrob(gg2)
    
    maxWidth = grid::unit.pmax(plot1$widths[2:5], plot2$widths[2:5])
    plot1$widths[2:5] <- as.list(maxWidth)
    plot2$widths[2:5] <- as.list(maxWidth)
    grid.arrange(plot1, plot2, ncol=1)
    
}
#===============================================================================
# multiple plots 
#===============================================================================
# from: https://github.com/ateucher/useful_code/blob/master/R/multiplot.r
multi.ggplot <- function(..., plotlist=NULL, cols=1, layout=NULL, widths=NULL, heights=NULL, 
                      title=NULL, titlefont = "", titleface = 1, titlesize = 16) {
    
    # Make a list from the ... arguments and plotlist
    plots <- c(list(...), plotlist)
    
    numPlots = length(plots)
    
    # If layout is NULL, then use 'cols' to determine layout
    if (is.null(layout)) {
        # Make the panel
        # ncol: Number of columns of plots
        # nrow: Number of rows needed, calculated from # of cols
        layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                         ncol = cols, nrow = ceiling(numPlots/cols))
    }
    
    if (!is.null(title)) { # Add a narrow row at the top for the title
        layout <- rbind(rep(0,ncol(layout)),layout)
        if (is.null(heights)) {
            plotrows <- nrow(layout)-1
            rowheights <- c(0.1, rep(1,plotrows)/plotrows)
        } else {
            rowheights <- c(0.1, heights/sum(heights))
        }
    } else {
        if (is.null(heights)) {
            rowheights <- rep(1,nrow(layout))  
        } else {
            rowheights <- heights
        }
    }
    
    if (is.null(widths)) {
        colwidths <- rep(1, cols)
    } else {
        colwidths <- widths
    }
    
    if (numPlots==1) {
        
        return(plots[[1]] + labs(title=title))
        
    } else {
        # Set up the page
        grid.newpage()
        pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout), 
                                                   widths=colwidths, 
                                                   heights=rowheights)))
        
        # Make each plot, in the correct location
        for (i in 1:numPlots) {
            # Get the i,j matrix positions of the regions that contain this subplot
            matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
            
            print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                            layout.pos.col = matchidx$col))
        }
        
        if (!is.null(title)) {
            grid.text(title, vp = viewport(layout.pos.row = 1
                                           , layout.pos.col = 1:ncol(layout)), 
                      gp = gpar(fontfamily = titlefont, fontface = titleface, 
                                fontsize = titlesize))
        }
        
    }
    return(invisible(NULL))
}
#===============================================================================
# clear console screen    
#===============================================================================
clear.console <- function(){
    
    cat("\014") # command to clear screen wrapped in a function
    
}
#===============================================================================
# clear ls() minus functions
#===============================================================================
clear.environment <- function(){
    ENV <- globalenv()
    ll <- ls(envir = ENV)
    ll <- subset(ll, ll != "clear.console")
    ll <- subset(ll, ll != "clear.environment")
    ll <- subset(ll, ll != "custom.ggplot.themes.nl")
    ll <- subset(ll, ll != "custom.ggplot.themes.wl")
    ll <- subset(ll, ll != "dates.add.months")
    ll <- subset(ll, ll != "dates.print.MonthsYears")
    ll <- subset(ll, ll != "DAYS")
    ll <- subset(ll, ll != "get.filesize")
    ll <- subset(ll, ll != "getstr")
    ll <- subset(ll, ll != "knot.ggplots")
    ll <- subset(ll, ll != "multi.ggplot")
    ll <- subset(ll, ll != "make_html_table")
    ll <- subset(ll, ll != "make_xtable")
    ll <- subset(ll, ll != "month.converter")
    ll <- subset(ll, ll != "MONTHS")
    ll <- subset(ll, ll != "num.months")
    ll <- subset(ll, ll != "num.weekdays")
    ll <- subset(ll, ll != "show.functions")
    ll <- subset(ll, ll != "stopwatch")
    ll <- subset(ll, ll != "summary.to.table")
    ll <- subset(ll, ll != "title.to.table")
    rm(list = ll, envir = ENV)
}
#===============================================================================
# show loaded functions from stackoverflow
#===============================================================================
show.functions <- function(type='closure'){ 
    inlist<-ls(.GlobalEnv)
    
    if (type=='function') type <-'closure'
    
    typelist<-sapply(sapply(inlist,get),typeof)
    
    return(names(typelist[typelist==type]))
}
#===============================================================================
# FUNCTION: Get file/directory size in MBs - default is dir()
#===============================================================================
get.filesize <- function(x = dir(), sort = "name"){
    # load package
    require(tools, quietly = T)
    # get file name, type, size
    for (i in 1:length(x)){
        if(i == 1){
            name <- as.character(x[i])
            type <- file_ext(x[i])
            size <- as.numeric(round(file.size(x[i]) / 1048576, 2))
        }
        else{
        name <- rbind(name, x[i])
        type <- rbind(type, file_ext(x[i]))
        size <- rbind(size, as.numeric(round(file.size(x[i])/1048576, 2)))
        }
    }
    
    # make df
    df <- cbind(name, type, size)
    df <- data.frame(df, stringsAsFactors = F, row.names = 1:length(x))
    colnames(df) <- c("Name","Type", "Size")
    df$Size <- as.numeric(df$Size)
    
    # load message
    cat(paste0("\nHere's what I found: \n",
               "\tFile(s): ",length(df$Name), "\t", "Total Size (MB): ", sum(df$Size),
               "\n\n", 
               "Overview:\n\n"))
    
    # recode
    df$Type[df$Type==""] <- "NA"
    df$Size[df$Size == 0] <- "< 0.5 MB"
    
    # sorting & print
    if(sort == "name"){
        df[order(df$Name),]
    }
    else if(sort == "type"){
        df[order(df$Type),]
    }
    else if(sort == "size"){
        df[order(df$Size),]
    }
}
#===============================================================================
# get string functions
# REF: GitHub user ...
#===============================================================================
getstr = function(mystring, initial.character, final.character)
{
    
    # check that all 3 inputs are character variables
    if (!is.character(mystring))
    {
        stop('The parent string must be a character variable.')
    }
    
    if (!is.character(initial.character))
    {
        stop('The initial character must be a character variable.')
    }
    
    
    if (!is.character(final.character))
    {
        stop('The final character must be a character variable.')
    }
    
    # pre-allocate a vector to store the extracted strings
    snippet = rep(0, length(mystring))
    
    for (i in 1:length(mystring))
    {
        # extract the initial position
        initial.position = gregexpr(initial.character, mystring[i])[[1]][1] + 1
        
        # extract the final position
        final.position = gregexpr(final.character, mystring[i])[[1]][1] - 1
        
        # extract the substring between the initial and final positions, inclusively
        snippet[i] = substr(mystring[i], initial.position, final.position)
    }
    
    return(snippet)
}
#===============================================================================
# stopwatch: H:M:S
#===============================================================================
stopwatch <- function(){
    
    if(exists("value")==FALSE){
        value = 1
    }
    
    # define time units
    hour = 0
    minute = 0
    second = 0
    
    cat("Welcome to StopwatchR!\n\n",
        "\tTime elapsed: ",
        ifelse(hour < 10, paste0(0,hour), hour),
        ":",
        ifelse(minute < 10, paste0(0,minute),minute),
        ":",
        ifelse(second < 10, paste0(0, second), second),
        "\n\nPress ESC to stop."
    )
    
    while(value == 1){
        
        clear.console()
        
        second = second + 1
        
        if(second == 60){
            
            minute = minute + 1
            
            second = 0
            
        } else if(minute == 60){
            
            hour = hour + 1
            
            minute = 00
            
            second = 00
        }
        
        cat("Welcome to StopwatchR!\n\n",
                    "\tTime elapsed: ",
                     ifelse(hour < 10, paste0(0,hour), hour),
                     ":",
                     ifelse(minute < 10, paste0(0,minute),minute),
                     ":",
                     ifelse(second < 10, paste0(0, second), second),
                     "\n\nPress ESC to stop."
        )
        
        Sys.sleep(1)
    }
}
#===============================================================================
# Title: Month <-> Month Name Converter
# Created: July 23, 2015
# Author: David Ruvolo 
# 
# Instructions: assign function to variable than enter type
#===============================================================================
month.converter <- function(ui.month){
    if(class(ui.month) == 'numeric') {
        # -----------------------
        if(ui.month == 1){
            out <- "January" 
        } else if(ui.month == 2){
            out <- "February"
        } else if(ui.month == 3){
            out <- "March"
        } else if (ui.month == 4){
            out <- "April"
        } else if (ui.month == 5){
            out <- "May"
        } else if (ui.month == 6){
            out <- "June"
        } else if (ui.month == 7){
            out <- "July"
        } else if (ui.month == 8){
            out <- "August"
        } else if (ui.month == 9){
            out <- "September"
        } else if (ui.month == 10){
            out <- "October"
        } else if (ui.month == 11){
            out <- "November"
        } else if (ui.month == 12){
            out <- "December"
        }
        # -----------------------------------
        # --------------------------------------
    } else if (class(ui.month)== 'character'){
        if (ui.month == "January" | ui.month == "january" | ui.month == "jan" | ui.month == "Jan"){
            out <- 1
        } else if (ui.month == "February"| ui.month == "february" | ui.month == "feb" | ui.month == "Feb"){
            out <- 2
        } else if (ui.month == "March"| ui.month == "march" | ui.month == "mar" | ui.month == "Mar"){
            out <- 3
        } else if (ui.month == "April"| ui.month == "april" | ui.month == "apr" | ui.month == "Apr"){
            out <- 4
        } else if (ui.month == "May"| ui.month == "may"){
            out <- 5
        } else if (ui.month == "June"| ui.month == "june"){
            out <- 6
        } else if (ui.month == "July"| ui.month == "july"){
            out <- 7
        } else if (ui.month == "August"| ui.month == "august" | ui.month == "aug" | ui.month == "Aug"){
            out <- 8
        } else if (ui.month == "September"| ui.month == "september" | ui.month =="sept" | ui.month == "Sept"){
            out <- 9
        } else if (ui.month == "October"| ui.month == "october" | ui.month == "oct" | ui.month == "Oct"){
            out <- 10
        } else if (ui.month == "November"| ui.month == "november" | ui.month == "nov" | ui.month == "Nov"){
            out <- 11
        } else if (ui.month == "December"| ui.month == "december" | ui.month == "dec" | ui.month == "Dec"){
            out <- 12
        }
    } else {
        out <- "NA"
    }
    return(out)
}
#===============================================================================
# standard ggplot themes 
# to call after geoms and titles
#===============================================================================
require(ggplot2, quietly = T)
# -------- no legend -------- #
custom.ggplot.themes.nl <- theme(panel.background = element_blank(),
                                 
                panel.grid.major = element_blank(), # eliminate background lines
                            
                panel.grid.minor = element_blank(), # eliminate background lines
                            
                plot.title=element_text(size=18,vjust=1.25), # ggtitle parameters
                            
                axis.title.y = element_text(colour="black",size=12,vjust = 1.5), #  y axis title
                            
                axis.text.x = element_text(colour="black", size = 14,vjust = -0.1), # xaxis text
                            
                axis.text.y = element_text(colour="black", size = 14, vjust = 0.8), # yaxis text
                            
                axis.line = element_line(colour = "black"), # plot frame (i.e., axes)
                            
                legend.position = c(""), # legend parameters
                            
                legend.background = element_rect(colour = "black"), # legend aesthetics
                            
                legend.text = element_text(size = 11), # legend text
                            
                legend.title = element_text(size = 12), # legend title
                
                # Specift the Facet Panel Text Style
                
                strip.text.x = element_text(size = 16, colour = "black"), 
                      
                      # Set the facet panel fill colour and border colour
                      
                      strip.background = element_rect(fill ="#F2F2F2",colour="grey")
                            
                )

# -------- with legend -------- #
custom.ggplot.themes.wl <- theme(panel.background = element_blank(),
                                 
                panel.grid.major = element_blank(), # eliminate background lines
                              
                panel.grid.minor = element_blank(), # eliminate background lines
                              
                plot.title=element_text(size=18,vjust=1.25), # ggtitle parameters
                              
                axis.title.y = element_text(colour="black",size=12,vjust = 1.5), #  y axis title
                              
                axis.text.x = element_text(colour="black", size = 14,vjust = -0.1), # xaxis text
                              
                axis.text.y = element_text(colour="black", size = 14, vjust = 0.8), # yaxis text
                              
                axis.line = element_line(colour = "black"), # plot frame (i.e., axes)
                              
                legend.position = c("right"), # legend parameters
                              
                legend.background = element_rect(colour = "black"), # legend aesthetics
                              
                legend.text = element_text(size = 11), # legend text
                              
                legend.title = element_text(size = 12), # legend title)
                
                # Specify the Facet Panel Text Style
                
                strip.text.x = element_text(size = 16, colour = "black"), 
                      
                      # Set the facet panel fill colour and border colour
                      
                      strip.background = element_rect(fill ="#F2F2F2",colour="grey")
                              
                )
#===============================================================================
