## MAKE HTML TABLE
## SHIPS WITH html documents and shiny apps(?)
## OPTIONS for: title, alignment, alternating row/col color, and row names
## see also make_xtable()
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