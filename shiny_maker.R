## function: create shiny directory and make required files
make_it_shiny <- function(directory_name = "myshinyapp", default_directory = "~/Dropbox/Programming/R/R_Shiny/"){
    
    #  set dir_path
    dir_path = paste0(default_directory, directory_name)
    
    # check to see if dir_path exists
    if(dir.exists(dir_path)){
        warning("Directory already exists. Appending the directory name slightly.", immediate. = T)
        Sys.sleep(1)
        dir_path = paste0(dir_path,sample(1:99,size = 1))
    }
    
    # mkdir main dir
    dir.create(dir_path)
    
    # touch: ui, server, global
    file.create(paste0(dir_path, "/","ui.R"),showWarnings = F)
    file.create(paste0(dir_path, "/", "server.R"), showWarnings = F)
    file.create(paste0(dir_path, "/", "global.R"), showWarnings = F)
    
    # touch: google-analytics.js
    file.create(paste0(dir_path,"/","google-analytics.js"),showWarnings = F)
    
    # echo "default text" >> ...R file (ui, server, global)
    make_my_text_shiny(paste0(dir_path, "/","ui.R"), file_type = "ui")
    make_my_text_shiny(paste0(dir_path, "/","server.R"), file_type = "server")
    make_my_text_shiny(paste0(dir_path, "/","global.R"), file_type = "global")
    
    
    # mkdir: external
    dir.create(paste0(dir_path,"/","external"), showWarnings = F)
    
    # mkdir: data
    dir.create(paste0(dir_path,"/","data"), showWarnings = F)
    
    # mkdir: utilities
    dir.create(paste0(dir_path,"/","utilities"), showWarnings = F)
    
    # mkdir: www
    dir.create(paste0(dir_path,"/","www"), showWarnings = F)
    
    # touch /www/style.css
    file.create(paste0(dir_path,"/","www","/", "style.css"), showWarnings = F)
    
    # end message
    cat(paste0("New shiny project created! \nYou can find it here: ", dir_path))
    
}

make_my_text_shiny <- function(file_path, file_type){
    
    # TEXT----------------
    if(file_type == "ui"){
        # header
        text <- paste0("# ================", "\n",
                        "# Shiny: ui.R     ", "\n",
                        "# ================", "\n",
                        "\n",
                        "\n",
                        "shinyUI(fluidPage(", "\n",
                        "\t# MAIN PARAMETERS-----------------------------------", "\n",
                        "\n",
                        "\ttheme = shinytheme('journal'), # set theme", "\n",
                        "\ttitle = 'myshinyapp', # set title", "\n",
                        "\ttags$head(includeScript('google-analytics.js')), # include GA tracker", "\n",
                        "\ttags$link(rel='stylesheet', type='text/css', href='style.css'), # css file","\n",  
                        "\n",
                        "\t# UI-------------------------------------------------", "\n",
                        "\n",
                        "\n",
                        "\n",
                        ")) # END UI")
    }
    else if(file_type == "server"){
        text <- paste0("# ================", "\n",
                        "# Shiny: server.R     ", "\n",
                        "# ================", "\n",
                        "\n",
                       "shinyServer(function(input,output, session){","\n",
                       "\n",
                       "\n",
                       "}) # END SERVER")
    }
    else if(file_type == "global"){
        text <- paste0("# ================", "\n",
                       "# Shiny: global.R     ", "\n",
                       "# ================", "\n",
                       "\n",
                       "# LOAD PACKAGES","\n",
                       "library(shiny, quietly = T)","\n",
                       "library(shinythemes,quietly = T)","\n",
                       "library(shinyjs,quietly = T)","\n",
                       "library(shinyBS,quietly = T)","\n",
                       "\n",
                       "# LOAD FUNCTIONS","\n",
                       "\n",
                       "\n",
                       "\n",
                       "# LOAD DATA")
    }
    
    # OUTPUT
    write(text, file = file_path, append = T)
    
}