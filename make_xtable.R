## MAKE xtable function
## uses any object.
## options for setting title, alignment, rotation, color, column names, and rownames
## ships with LaTeX documents
## see also make_html_tables()
#===============================================================================
#---------------------------- X TABLE CUSTOM FUNCTION -------------------------#
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