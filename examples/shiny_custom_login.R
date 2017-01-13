#'=====================================
#' FILE: shiny_custom_login.R
#' AUTHOR: David Ruvolo
#' CREATED: July 2016
#' PURPOSE: Quick and dirty login screen
#'          for non-shiny pro users
#' REFS: Adapted from https://stackoverflow.com/questions/28987622/starting-shiny-app-after-password-input
#'=====================================
library(shiny)
#===========
## FUNCTIONS
#===========
## SIMPLE GREETING
good_time <- function(){
    
    ## LOAD PACKAGE
    require(lubridate, quietly = T)
    
    ## ISOLATE currHour
    currhour = hour(now())
    
    ## RUN LOGIC
    if(currhour < 12){
        return("good morning")
    } 
    else if(currhour >= 12 & currhour < 17){
        return("good afternoon")
    }
    else if( currhour >= 17){
        return("good evening")
    }
}

#==============
## DEFINE USERS
#==============
## Insert googlesheets reference here, if applicable
users <- data.frame("User" = c("user1", "user2", "admin"),
                    "Password" = c("user1_password", "user2_password", "admin_password"))

## STARTING LOGGED VALUE; LET'S CHANGE THAT!
Logged = FALSE;

#====
# UI
#====
## make login screen
ui1 <- function(){
    tagList(
        div(id="container",
            div(id = "login",
                # make login panel
                wellPanel(
                    HTML(paste0('
                                <div id="welcome-text">
                                Hello, ', good_time(),"!",
                                '</div>',
                                '<div class="prompt">
                                <br>Please login.
                                </div>')
                    ),
                    br(),
                    textInput("userName", "Username"),
                    passwordInput("passwd", "Password")
                ),
                # button
                actionButton("Login", "Log in"),
                # login error message
                uiOutput("message")
            )
        ),
        # css for container
        tags$style(type = "text/css", 
                   "#container{
                   display: flex;
                   justify-content: center;
                   margin-top: 150px;
                   }"),
        # css for login well panel
        tags$style(type="text/css", "
                   #login{
                   position: relative;
                   font-size:14px; 
                   width: 300px;
                   }"),
        # welcome text css
        tags$style(type = 'text/css',
                   "#welcome-text{
                   font-size:21px;
                   text-align: center;
                   }"),
        tags$style(type = 'text/css',
                   ".prompt{
                   font-size:18px;
                   }"),
        # button css
        tags$style(type='text/css',
                   "#Login{
                   position: relative;
                   margin-left: 200px;
                   width: 100px;
                   font-size: 12pt;
                   background-color: #f7fbff;
                   }"),
        # error box
        tags$style(type="text/css",
                   "#error-box{
                   margin-top: 20px;
                   padding: 5px 10px 5px 10px;
                   text-align: center;
                   width: 300px;
                   color: #ef3b2c;
                   background-color: #fee5d9;
                   border: 1px solid #ef3b2c;
                   border-radius: 5px;
                   }")
    )
}

#=========
# PRINT UI
#=========
ui = (uiOutput("page"))

#========
# SERVER
#========
server = shinyServer(function(input, output,session){
    
    ## BEGIN BUILD LOG IN SCREEN
    USER <- reactiveValues(Logged = Logged)
    
    ## ERROR CHECKING
    output$message <- renderUI({
        if(!is.null(input$Login)){
            my_username <- length(users$User[grep(pattern = input$userName, x = users$User)])
            my_password <- length(users$User[grep(pattern = input$passwd, x = users$Password)])
            if(input$Login > 0){
                if(my_username < 1 ||  my_password < 1){
                    HTML("<div id='error-box'>
                         Sorry, that's not the right username or password. Please, 
                         try again. If you continue to have problems, contact
                         <a href='#'>
                         <u>helpdesk@yoursupport.com</u></a>
                         </div>")
                }
            }
        }
    })
    
    ## CHECK INPUT
    observe({ 
        if (USER$Logged == FALSE) {
            if (!is.null(input$Login)) {
                if (input$Login > 0) {
                    Username <- isolate(input$userName)
                    Password <- isolate(input$passwd)
                    Id.username <- which(users$User == Username)
                    Id.password <- which(users$Password == Password)
                    if (length(Id.username) > 0 & length(Id.password) > 0) {
                        if (Id.username %in% Id.password) {
                            USER$Logged <- TRUE
                        }
                    }
                } 
            }
        }    
    })
    
    ## Make UI
    observe({
        # What to do when logged = F
        if (USER$Logged == FALSE) {
            
            output$page <- renderUI({
                div(class="outer",do.call(bootstrapPage,c("",ui1())))
            })
        }
        
        # Render UI when logged = T
        if (USER$Logged == TRUE) 
        {
            ## get the current user's authorization level 
            user_log <- toupper(input$userName)
            
            # if admin
            if(user_log == "ADMIN"){
                output$page <- renderUI({
                    fluidPage(
                        # title
                        titlePanel(HTML("<h2 align='center'>Welcome!</h2>")),
                        br(),
                        ## text
                        HTML("You've made it, congrats! If you are seeing this page, you are an admin")
                    )
                })
            }
            
            # if not admin
            else{
                output$page <- renderUI({
                    fluidPage(
                        # title
                        titlePanel(HTML("<h2 align='center'>Welcome!</h2>")),
                        br(),
                        ## text
                        HTML("You've made it, congrats! If you are seeing this page, you are a regular user")
                    )
                })
            }
        }
    })
}) # END SHINYAPP

#======
# RUN
#======
runApp(list(ui = ui, server = server))


