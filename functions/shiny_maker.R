## function: create shiny directory and make required files
shinyMaker <- function(directory_name = "myshinyapp"){
    
    ## DETECT OS
    os <- .Platform$OS.type
    if(os == "unix"){
        default_directory = "~/Desktop/"
    } else if(x == "windows"){
        default_directory = "C:/Desktop/"
    }
    
    #  set dir_path
    dir_path = paste0(default_directory, directory_name)
    
    # check to see if dir_path exists
    if(dir.exists(dir_path)){
        cat("\nQuick Note: Directory already exists. Appending the directory name with a random number.\n\n")
        Sys.sleep(1)
        cat("shinyMaker()\n")
        cat("==================================================\n");Sys.sleep(0.75)
        Sys.sleep(1)
        dir_path = paste0(dir_path,sample(1:1000,size = 1))
    }else{
        cat("shinyMaker()\n")
        cat("==================================================\n");Sys.sleep(0.75)
    }
    
    
    # mkdir main dir
    cat("1. Making parent directory...")
    dir.create(dir_path)
    Sys.sleep(1.5)
    cat("Done!\n")
    Sys.sleep(1.5)
    
    # mkdir: external
    cat("2. Making sub directories...")
    dir.create(paste0(dir_path,"/","external"), showWarnings = F)
    dir.create(paste0(dir_path,"/","data"), showWarnings = F)
    dir.create(paste0(dir_path,"/","utilities"), showWarnings = F)
    dir.create(paste0(dir_path,"/","www"), showWarnings = F)
    Sys.sleep(2)
    cat("Done!\n")
    Sys.sleep(1.5)
    
    # touch: ui, server, global
    cat("3. Creating primary shiny files...")
    file.create(paste0(dir_path, "/","ui.R"),showWarnings = F)
    file.create(paste0(dir_path, "/", "server.R"), showWarnings = F)
    file.create(paste0(dir_path, "/", "global.R"), showWarnings = F)
    Sys.sleep(2)
    cat("Done!\n")
    Sys.sleep(1.5)
    
    # echo: "default text" >> ...R file (ui, server, global, main)
    cat("4. Write default text to primary shiny files...")
    make_my_text_shiny(paste0(dir_path, "/","ui.R"), file_type = "ui")
    make_my_text_shiny(paste0(dir_path, "/","server.R"), file_type = "server")
    make_my_text_shiny(paste0(dir_path, "/","global.R"), file_type = "global")
    make_my_text_shiny(paste0(dir_path, "/external/", "main.R"), file_type = "main")
    Sys.sleep(2)
    cat("Done!\n")
    Sys.sleep(1.5)
    
    # touch: google-analytics.js
    cat("5. Creating blank google analytics file...")
    file.create(paste0(dir_path,"/utilities/","google-analytics.js"),showWarnings = F)
    Sys.sleep(1)
    cat("Done!\n")
    Sys.sleep(1.5)
    
    # touch: /www/style.css + echo "default text" >> style.css
    cat("6. Creating style.css and writing base css...")
    file.create(paste0(dir_path,"/","www","/", "style.css"), showWarnings = F)
    make_my_text_shiny(paste0(dir_path,"/www/", "style.css"), file_type = "css")
    Sys.sleep(2)
    cat("Done!\n")
    Sys.sleep(1.5)
    
    # CAT: Build Complete!
    cat("6. Creating style.css and writing base css...Done!\n")
    cat("==================================================\n");Sys.sleep(0.75)
    cat("Status: COMPLETE\n")
    Sys.sleep(1.5)
    cat(paste0("You can find your shiny app here: ", dir_path,"\n"))
}

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
    
}