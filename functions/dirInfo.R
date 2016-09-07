#===============================================================================
# FUNCTION: Get file/directory size in MBs - default is dir()
#===============================================================================
dirInfo <- function(dir_path = NULL,sort = c("name","type", "created", "modified","isDir")){
    
    # SET 'DIR'-------------------------------------------------
    if(is.null(dir_path)){
        dir_path = getwd()
    }
    ## set path still doesn't work
    dir = list.files(dir_path)
    
    # LOAD PACKAGE--------------------------------------------
    require(tools, quietly = T)
    
    # BUILD MAIN DIRECTORIES DF-------------------------------
    for (i in 1:length(dir)){
        if(i == 1){ #first iteration: initiate df
            name <- as.character(dir[i])
            type <- file_ext(dir[i])
            size <- as.numeric(round(file.size(dir[i]) / 1048576, 2))
            create <- format(as.Date(file.info(dir[i])$ctime),"%Y-%m-%d")
            mod <- format(as.Date(file.info(dir[i])$mtime),"%Y-%m-%d")
            fDir <- file.info(dir[1])$isdir
        } else{ # all subsequent loops append df
            name <- rbind(name, dir[i])
            type <- rbind(type, file_ext(dir[i]))
            size <- rbind(size, as.numeric(round(file.size(dir[i])/1048576, 2)))
            create <- rbind(create , format(as.Date(file.info(dir[i])$ctime),"%Y-%m-%d"))
            mod <- rbind(mod, format(as.Date(file.info(dir[i])$mtime),"%Y-%m-%d"))
            fDir <- rbind(fDir, file.info(dir[i])$isdir)
        }
    }
    
    # MAKE DF------------------------------------------
    df <- cbind(name, type, size, create, mod, fDir)                            ## cbind()
    df <- data.frame(df, stringsAsFactors = F, row.names = 1:length(dir))       ## data.frame()
    colnames(df) <- c("Name","Type", "Size", "Created", "LastModified", "Dir")  ## set col names
    fileTypeList <- toString(unique(df$Type[df$Type != "----"]))                ## extract file type(s)
    
    
    ## CAT OUTPUTS------------------------------------
    cat(paste0("LOC: ",dir_path,"\n"))
    cat("============================================================\n")
    cat(paste0("SUMMARY: \n",
               "\tFile(s): ",sum(df$Type !="----"), "\n",
              # "\t", "Total Size (MB): ",as.numeric(df$Size[df$Dir == F & df$Size !="< 0.5 MB"]),"\n",
               "\tSub Directories: ", sum(df$Dir == T), "\n",
               "\tDate Created Range: ",min(df$Created)," to ", max(df$Created), "\n",
               "\tDate Modified Range: ", min(df$LastModified)," to ", max(df$LastModified), "\n",
               "\tFile Types: ",fileTypeList,
               "\n\n"))
    cat("============================================================\n")
    cat("OVERVIEW:\n\n")
    
    ## RECODE--------------------------------------
    df$Type[df$Type==""] <- "----"
    df$Size[df$Size == 0] <- "< 0.5 MB"
    
    ## SORTING & PRINT-----------------------------
    sort <- ifelse(length(sort != 1), "name",sort)
    
    if(sort == "name"){
        df <- df[order(df$Name),]
    }
    else if(sort == "type"){
        df <- df[order(df$Type),]
    }
    else if(sort == "size"){
        df <- df[order(df$Size),]
    }
    else if(sort == "created"){
        df <- df[order(df$Created),]
    }
    else if(sort == "modified"){
        df <- df[order(df$LastModified),]
    }
    else if(sort == "isDir"){
        df <- df[order(df$Dir),]
    }
    
    ## PRINT DF------------------------------------
    return(df)
}