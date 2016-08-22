## Collection of useful ggplot tools
#===============================================================================
# GGPLOT + RCOLORBREWER STUFF
#===============================================================================
# Save multiple ggplot graphs into a single pdf
# packages: gridExtra and ggplot2
# specify columns, 

knot.ggplots<-function(gg1,gg2, cols = 1, rows = 2){
    
    # check library() for ggplot2 if not, install, otherwise load xtables
    # -------------------------------------------------------------------
    if("ggplot2" %in% rownames(installed.packages()) == FALSE){ # search package names
        
        install.packages("ggplot2",dependencies = T) # otherwise install w/dependencies
        
    } else {
        
        require(ggplot2, quietly = T) # else load quietly 
    }
    # check library() for gridextra. If not, install, otherwise load
    # -------------------------------------------------------------------
    if("gridExtra" %in% rownames(installed.packages()) == FALSE){ # search package names
        
        install.packages("gridExtra",dependencies = T) # otherwise install w/dependencies
        
    } else {
        
        require(gridExtra, quietly = T) # else load quietly 
    }
    # -------------------------------------------------------------------
    
    plot1 <- ggplotGrob(gg1)
    
    plot2 <- ggplotGrob(gg2)
    
    maxWidth = grid::unit.pmax(plot1$widths[2:5], plot2$widths[2:5])
    plot1$widths[2:5] <- as.list(maxWidth)
    plot2$widths[2:5] <- as.list(maxWidth)
    grid.arrange(plot1, plot2, ncol=1)
    
}
#===============================================================================
# multiple plots 
#===============================================================================
# from: https://github.com/ateucher/useful_code/blob/master/R/multiplot.r
multi.ggplot <- function(..., plotlist=NULL, cols=1, layout=NULL, widths=NULL, heights=NULL, 
                         title=NULL, titlefont = "", titleface = 1, titlesize = 16) {
    
    # Make a list from the ... arguments and plotlist
    plots <- c(list(...), plotlist)
    
    numPlots = length(plots)
    
    # If layout is NULL, then use 'cols' to determine layout
    if (is.null(layout)) {
        # Make the panel
        # ncol: Number of columns of plots
        # nrow: Number of rows needed, calculated from # of cols
        layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                         ncol = cols, nrow = ceiling(numPlots/cols))
    }
    
    if (!is.null(title)) { # Add a narrow row at the top for the title
        layout <- rbind(rep(0,ncol(layout)),layout)
        if (is.null(heights)) {
            plotrows <- nrow(layout)-1
            rowheights <- c(0.1, rep(1,plotrows)/plotrows)
        } else {
            rowheights <- c(0.1, heights/sum(heights))
        }
    } else {
        if (is.null(heights)) {
            rowheights <- rep(1,nrow(layout))  
        } else {
            rowheights <- heights
        }
    }
    
    if (is.null(widths)) {
        colwidths <- rep(1, cols)
    } else {
        colwidths <- widths
    }
    
    if (numPlots==1) {
        
        return(plots[[1]] + labs(title=title))
        
    } else {
        # Set up the page
        grid.newpage()
        pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout), 
                                                   widths=colwidths, 
                                                   heights=rowheights)))
        
        # Make each plot, in the correct location
        for (i in 1:numPlots) {
            # Get the i,j matrix positions of the regions that contain this subplot
            matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
            
            print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                            layout.pos.col = matchidx$col))
        }
        
        if (!is.null(title)) {
            grid.text(title, vp = viewport(layout.pos.row = 1
                                           , layout.pos.col = 1:ncol(layout)), 
                      gp = gpar(fontfamily = titlefont, fontface = titleface, 
                                fontsize = titlesize))
        }
        
    }
    return(invisible(NULL))
}
#===============================================================================
# my standard ggplot themes 
# to call after geoms and titles
#===============================================================================
require(ggplot2, quietly = T)
# -------- no legend -------- #
custom.ggplot.themes.nl <- theme(panel.background = element_blank(),
                                 
                                 panel.grid.major = element_blank(), # eliminate background lines
                                 
                                 panel.grid.minor = element_blank(), # eliminate background lines
                                 
                                 plot.title=element_text(size=18,vjust=1.25), # ggtitle parameters
                                 
                                 axis.title.y = element_text(colour="black",size=12,vjust = 1.5), #  y axis title
                                 
                                 axis.text.x = element_text(colour="black", size = 14,vjust = -0.1), # xaxis text
                                 
                                 axis.text.y = element_text(colour="black", size = 14, vjust = 0.8), # yaxis text
                                 
                                 axis.line = element_line(colour = "black"), # plot frame (i.e., axes)
                                 
                                 legend.position = c(""), # legend parameters
                                 
                                 legend.background = element_rect(colour = "black"), # legend aesthetics
                                 
                                 legend.text = element_text(size = 11), # legend text
                                 
                                 legend.title = element_text(size = 12), # legend title
                                 
                                 # Specift the Facet Panel Text Style
                                 
                                 strip.text.x = element_text(size = 16, colour = "black"), 
                                 
                                 # Set the facet panel fill colour and border colour
                                 
                                 strip.background = element_rect(fill ="#F2F2F2",colour="grey")
                                 
)

# -------- with legend -------- #
custom.ggplot.themes.wl <- theme(panel.background = element_blank(),
                                 
                                 panel.grid.major = element_blank(), # eliminate background lines
                                 
                                 panel.grid.minor = element_blank(), # eliminate background lines
                                 
                                 plot.title=element_text(size=18,vjust=1.25), # ggtitle parameters
                                 
                                 axis.title.y = element_text(colour="black",size=12,vjust = 1.5), #  y axis title
                                 
                                 axis.text.x = element_text(colour="black", size = 14,vjust = -0.1), # xaxis text
                                 
                                 axis.text.y = element_text(colour="black", size = 14, vjust = 0.8), # yaxis text
                                 
                                 axis.line = element_line(colour = "black"), # plot frame (i.e., axes)
                                 
                                 legend.position = c("right"), # legend parameters
                                 
                                 legend.background = element_rect(colour = "black"), # legend aesthetics
                                 
                                 legend.text = element_text(size = 11), # legend text
                                 
                                 legend.title = element_text(size = 12), # legend title)
                                 
                                 # Specify the Facet Panel Text Style
                                 
                                 strip.text.x = element_text(size = 16, colour = "black"), 
                                 
                                 # Set the facet panel fill colour and border colour
                                 
                                 strip.background = element_rect(fill ="#F2F2F2",colour="grey")
                                 
)

ggTimeThemes <- theme(panel.background = element_blank(),
                      panel.grid.major = element_line(color = "grey80"),
                      panel.grid.minor = element_line(color = "grey92"),
                      axis.text.x = element_text(colour="black", size = 11,vjust = 0.5), 
                      axis.text.y = element_text(colour="black", size = 11, vjust = 0.5, hjust = 1),
                      axis.ticks.x = element_blank(),
                      axis.ticks.y = element_blank()
)

#===============================================================================