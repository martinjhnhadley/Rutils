## get series
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