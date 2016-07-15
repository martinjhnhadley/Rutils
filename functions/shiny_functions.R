# SHINY APPS
# SAVE, LOAD, and TIMESTOP FUNCTIONS
# ==============================================================================
# --- This is one of the two functions we will change for every storage type ---
epochTime <- function() {
    return(as.integer(Sys.time()))
}

saveData <- function(data) {
    
    if (exists("responses")) {
        responses <<- rbind(responses, data)
    } else {
        responses <<- data
    }
}

# Load all previous responses
loadData <- function() {
    if (exists("responses")) {
        responses
    }
}