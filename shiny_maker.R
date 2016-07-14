## function: create shiny directory and make required files
make_it_shiny <- function(directory_name = "myshinyapp", default_directory = "~/Dropbox/Programming/R/R_Shiny/"){
    
    #  combined dir path
    dir_path = paste0(default_directory, directory_name)
    
    # mkdir
    dir.create(dir_path)
    
    # touch: ui, server, global
    file.create(paste0(dir_path, "/","ui.R"))
    file.create(paste0(dir_path, "/", "server.R"))
    file.create(paste0(dir_path, "/", "global.R"))
    
}