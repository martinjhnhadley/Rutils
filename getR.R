## get series
## 
#===============================================================================
# show loaded functions from stackoverflow
#===============================================================================
get.functions <- function(type='closure'){ 
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
get.string = function(mystring, initial.character, final.character)
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