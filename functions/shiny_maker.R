#' Shiny Maker
#'
#' \code{shinyMaker} was built to create a standard setup for shiny apps. Generating
#' and setting up initial shiny files (i.e., server, ui, global, css, external, assets,
#' etc.) can be tedious and take a while to setup. In the first instance, this script
#' will generate navbarPages with default starter text. You can find the source code 
#' on github at 
#' \href{https://github.com/davidruvolo51/Rutils/blob/master/functions/shiny_maker.R}{github/davidruvolo51/.../shiny_makerR.}
#' See below for further usage.
#'
#'@param directory_name The name of the directory where the shiny app files will be sent to. 
#'@param dir_path Specfiy the path for the shiny app directory. The default is your desktop.
#'
#'@examples
#' 
#' source("shiny_maker.R")
#' 
#' # run with defaults
#' navbarMaker()
#' 
#' 
#' # set directory name
#' navbarMaker(directory_name = "project_analysis_tool")
#' 
#' # set dir name and path
#' navbarMaker(directory_name = "cognitive_data_visualization", dir_path = "~/Documents/Anlysis")
#' 
#' 
## DEFINE FUNCTIONS-------------------------------------------------------------
## C++ equiv increment funct; from = https://stackoverflow.com/questions/5738831/r-plus-equals-and-plus-plus-equivalent-from-c-c-java-etc
`%+=%` = function(e1,e2) eval.parent(substitute(e1 <- e1 + e2))

## navbarMaker------------------------------------------------------------------

navbarMaker <- function(directory_name = "Shiny App", dir_path = NULL){
    
    ## DETECT OS & SET DIR------------------------------------------------------
    os <- toupper(.Platform$OS.type)
    if(os == "UNIX" & is.null(dir_path)){
        user = Sys.getenv("USER")
        default_directory = paste0("/Users/",user,"/Desktop/")
        dir_path = paste0(default_directory, directory_name)
    }
    else if(os == "UNIX" & !is.null(dir_path)){
        user = Sys.getenv("USER")
        default_directory = paste0(dir_path)
        dir_path = paste0(default_directory, directory_name)
    }    
    else if(os == "WINDOWS" & is.null(dir_path)){
        user = Sys.getenv("USERNAME")
        default_directory = paste0("C:/Users/",user,"/Desktop/")
        dir_path = paste0(default_directory, directory_name)
    }
    else if(os == "WINDOWS" & !is.null(dir_path)){
        user = Sys.getenv("USERNAME")
        default_directory = paste0(dir_path)
        dir_path = paste0(default_directory, directory_name)
    }
    
    ## DOES DIR EXIST?----------------------------------------------------------
    if(dir.exists(dir_path)){
        cat("Quick Note: Directory already exists. Appending the directory name with a random number.\n\n")
        dir_path = paste0(dir_path,sample(1:1000,size = 1)); 
        Sys.sleep(1)
    }
    
    ## BEGIN OUTPUTS------------------------------------------------------------
    cat(paste0("Writing to: ", dir_path,"\n"))
    cat("=======================================================================\n")
    Sys.sleep(1)
    
    ## set counters
    status = 0 ## init sum counter
    tally = 0 # init section counter
    error = NA
    
    # mkdir main dir------------------------------------------------------------
    cat("1. Making parent directory...................")
    dir.create(dir_path)
    
    # logic
    ifelse(dir.exists(dir_path), tally %+=% 1, "")
    
    ## send status
    Sys.sleep(1)
    if(tally == 1){
        cat("Done!\n")
    } else {
        cat("Oops! Something isn't right.\n")
        error = "List of Error(s)"
        error = rbind(error,"ERROR: Parent Directory not created.")
    }
    
    ## update counters
    status = status + tally
    tally = 0
    
    # mkdir: external-----------------------------------------------------------
    cat("2. Making sub directories....................")
    dir.create(paste0(dir_path,"/","external"), showWarnings = F)
    dir.create(paste0(dir_path,"/","data"), showWarnings = F)
    dir.create(paste0(dir_path,"/","utilities"), showWarnings = F)
    dir.create(paste0(dir_path,"/","www"), showWarnings = F)
    
    ## logic
    ifelse(dir.exists(paste0(dir_path,"/","external")), tally %+=% 1, "")
    ifelse(dir.exists(paste0(dir_path,"/","data")), tally %+=% 1, "")
    ifelse(dir.exists(paste0(dir_path,"/","utilities")), tally %+=% 1, "")
    ifelse(dir.exists(paste0(dir_path,"/","www")), tally %+=% 1, "")
    
    ## send status
    Sys.sleep(1)
    if(tally == 4 ){
        cat("Done!\n")    
    } else {
        cat("Oops! Something isn't right.\n")
        error = rbind(error, "ERROR in mkdir child directories.")
    }
    Sys.sleep(1)
    
    ## update counters
    status = status + tally 
    tally = 0
    
    # touch: ui, server, global-------------------------------------------------
    cat("3. Creating primary shiny files..............")
    file.create(paste0(dir_path, "/","ui.R"),showWarnings = F)
    file.create(paste0(dir_path, "/", "server.R"), showWarnings = F)
    file.create(paste0(dir_path, "/", "global.R"), showWarnings = F)
    
    ## logic
    ifelse(file.exists(paste0(dir_path, "/","ui.R")), tally %+=% 1, "" )
    ifelse(file.exists(paste0(dir_path, "/", "server.R")), tally %+=% 1, "" )
    ifelse(file.exists(paste0(dir_path, "/", "global.R")), tally %+=% 1, "" )
    
    ## send status
    Sys.sleep(1)
    if(tally == 3 ){
        cat("Done!\n")    
    } else {
        cat("Oops! Something isn't right.\n")
        error = rbind(error, "ERROR in touch ui, server, or global.R files.")
    }
    Sys.sleep(1)
    
    ## update counters
    status = status + tally 
    tally = 0
    
    # echo: "default text" >> ...R file (ui, server, global, main)--------------
    cat("4. Echo text to primary shiny files..........")
    make_my_text_shiny(paste0(dir_path, "/","ui.R"), file_type = "ui")
    make_my_text_shiny(paste0(dir_path, "/","server.R"), file_type = "server")
    make_my_text_shiny(paste0(dir_path, "/","global.R"), file_type = "global")
    make_my_text_shiny(paste0(dir_path, "/external/", "main.R"), file_type = "main")
    
    ## logic
    ifelse(length(readLines(con = paste0(dir_path, "/", "ui.R"), warn = F)) > 0, tally %+=% 1, "")
    ifelse(length(readLines(con = paste0(dir_path, "/", "server.R"), warn = F)) > 0, tally %+=% 1, "")
    ifelse(length(readLines(con = paste0(dir_path, "/", "global.R"), warn = F)) > 0, tally %+=% 1, "")
    
    ## send status
    Sys.sleep(1)
    if(tally == 3 ){
        cat("Done!\n")    
    } else {
        cat("Oops! Something isn't right.\n")
        error = rbind(error, "ERROR in echo text to shiny files.")
    }
    Sys.sleep(1)
    
    ## update counters
    status = status + tally 
    tally = 0
    
    # touch: google-analytics.js------------------------------------------------
    cat("5. Creating blank google analytics file......")
    file.create(paste0(dir_path,"/utilities/","google-analytics.js"),showWarnings = F)
    
    ## logic
    ifelse(file.exists(paste0(dir_path,"/utilities/","google-analytics.js")), tally %+=% 1, "")
    
    ## send status
    Sys.sleep(1)
    if(tally == 1 ){
        cat("Done!\n")    
    } else {
        cat("Oops! Something isn't right.\n")
        error = rbind(error, "ERROR in touch google-analytics.js")
    }
    Sys.sleep(1)
    
    ## update counters
    status = status + tally 
    tally = 0
    
    # touch: /www/style.css + echo "default text" >> style.css------------------
    cat("6. Creating style.css and writing base css...")
    file.create(paste0(dir_path,"/","www","/", "style.css"), showWarnings = F)
    make_my_text_shiny(paste0(dir_path,"/www/", "style.css"), file_type = "css")
    
    ## logic
    ifelse(file.exists(paste0(dir_path , "/", "www", "/", "style.css")), tally %+=% 1, "")
    ifelse(length(readLines(paste0(dir_path, "/","www","/", "style.css"))) > 1, tally %+=% 1, "")
    
    ## send status
    Sys.sleep(1)
    if(tally == 2 ){
        cat("Done!\n")    
    } else {
        cat("Oops! Something isn't right.\n")
        error =  rbind(error, "ERROR in style.css: touch + echo failed.")
    }
    Sys.sleep(1)
    
    ## update counters
    status = status + tally 
    tally = 0
    
    # CAT: Build Complete!------------------------------------------------------
    cat("=======================================================================\n");
    Sys.sleep(0.75)
        if(status == 14){
            cat("Status: COMPLETE "); cat(paste0("with success code: ", status)) 
        } else {
            cat("Status: Uh oh, something didn't go right.\n")
            cat("Errors: \n")
            data.frame(error)
        }

    ## END
}


# MAKE_MY_TEXT_SHINY------------------------------------------------------------
# function that echos starting code to shiny files (ui, server, global, main tab 
# panel, and custom css)
make_my_text_shiny <- function(file_path, file_type){
    
    # TEXT----------------
        # header
    if(file_type == "ui"){
        text <- paste0("# ================", "\n",
                        "# Shiny: ui.R     ", "\n",
                        "# ================", "\n",
                        "shinyUI(fluidPage(", "\n",
                        "\t## MAIN PARAMETERS-----------------------------------", "\n",
                        "\ttheme = shinytheme('flatly'), # set theme", "\n",
                        "\ttitle = 'myshinyapp', # set title","\n",
                        "\t## LINK EXTERNAL-------------------------------------","\n",
                        '\ttags$link(rel="stylesheet", type="text/css",href = "style.css"), # css',"\n",
                       '\t#tags$head(includeScript("google-analytics.js")),',"\n",
                        "\t## UI-------------------------------------------------", "\n",
                        "\tuiOutput('page')",
                        "\n",
                        ")) # END UI")
    }
    else if(file_type == "server"){
        text <- paste0("# ================", "\n",
                        "# Shiny: server.R     ", "\n",
                        "# ================", "\n",
                       "shinyServer(function(input,output, session){","\n",
                       "\n",
                       "\t## Source External","\n",
                       "\tsource('external/main.R', local = T)",
                       "\t## source other elements here","\n",
                       "\n",
                       "\t## BUILD UI PAGE","\n",
                       "\toutput$page <- renderUI({", "\n",
                       "\t\tnavbarPage(","\n",
                       "\t\t\t","title = 'My Shiny App',","\n",
                       "\t\t\t# LOAD UI ELEMENTS [insert additional panels below]","\n",
                       '\t\t\ttabPanel("Main", uiOutput("main"), icon = icon("home"))',"\n",
                       "\t\t)","\n",
                       "\t})","\n",
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
                       "#library(shinyjs,quietly = T)","\n",
                       "#library(shinyBS,quietly = T)","\n",
                       "\n",
                       "# LOAD FUNCTIONS","\n",
                       "\n",
                       "\n",
                       "\n",
                       "# LOAD DATA")
    }
    else if(file_type == "main"){
        text <- paste0("# ================", "\n",
                       "# MAIN UI PAGE     ", "\n",
                       "# ================", "\n",
                       "\n",
                       "output$main <- renderUI({","\n",
                       '\ttabPanel("",', "\n",
                       "\t\tbr(), # add space","\n",
                       '\t\t## MAIN TITLE-------------',"\n",
                       "\t\tfluidRow(","\n",
                       "\t\t\tcolumn(6, offset = 3,","\n",
                       "\t\t\t\tHTML(",'"',"<div class=","'pageHeader'",">My Shiny App</div>",'"))',"\n",
                       "\t\t),","\n",
                       "\t\t## INTRO TEXT--------------","\n",
                       "\t\tfluidRow(","\n",
                       "\t\t\tcolumn(6, offset = 3,","\n",
                       "\t\t\t\t","HTML(",'"',"<div class='welcome-text'>","\n",
                       "\t\t\t\t\t\tWelcome to your very own shiny app generated using the","\n",
                       "\t\t\t\t\t\tshinyMaker() via shiny_maker.R.","\n",
                       "\t\t\t\t\t\t<div class='p-spacers'/>","\n",
                       "\t\t\t\t\t\tVisit the my github repo: 
                       <a href='https://github.com/davidruvolo51/Rutils'>github/davidruvolo51/Rutils/</a>
                       for more info.","\n", 
                       "Or see the documentation: 
                       <a href='http://www.davidcruvolo.com/external/shinyMaker_Documentation.pdf'>shinyMaker doc</a>",
                       "\t\t\t\t<div class='pageBottomBorder'/>","\n",
                       "\t\t\t\t</div>",'"',")","\n",
                       "\t\t\t)","\n",
                       "\t\t)","\n",
                       "\t)","\n",
                       "})")
    }
    else if(file_type == "css"){
        text <- paste0("\n",
                       "/* ---------- TEXT ----------*/","\n",
                       ".pageHeader{","\n",
                       "\ttext-align: center;","\n",
                       "\tborder-bottom: 1px solid #bdbdbd;","\n",
                       "\tpadding: 5px 0 5px 25px;","\n",
                       "\tfont-size: 32pt;","\n",
                       "\tfont-weight: 100;","\n",
                       "\tcolor: #969696;","\n",
                       "}","\n",
                       "\n",
                       
                       ".welcome-text{","\n",
                       "\tpadding: 15px 0 15px 0;","\n",
                       "\tfont-size: 16pt;","\n",
                       "\tfont-weight: 300;","\n",
                       "\tcolor: #969696;","\n",
                       "}","\n",
                       "\n",
                       "/*---------- SPACERS ----------*/","\n",
                       ".p-spacers{","\n",
                       "\theight: 20px;","\n",
                       "}","\n",
                       "\n",
                       "/*---------- CONTAINERS ----------*/","\n",
                       "\n",
                       "\n",
                       "/*---------- BORDERS ----------*/","\n",
                       ".pageBottomBorder{","\n",
                       "\tpadding: 10px 0 10px 0;","\n",
                       "\tborder-bottom: 1px solid #969696;","\n",
                       "}")
    }
    
    # OUTPUT
    write(text, file = file_path, append = T)
    
    ## END
}
