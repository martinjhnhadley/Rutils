\name{navbarMaker}
\alias{shinymaker}
\title{navbarMaker}
\usage{
param directory_name The name of the directory where the shiny app files will be sent to.
param dir_path Specfiy the path for the shiny app directory. The default is your desktop.
}
\description{
shinyMaker was built to create a standard setup for shiny apps. Generating
and setting up initial shiny files (i.e., server, ui, global, css, external, assets,
etc.) can be tedious and take a while to setup. In the first instance, this script
will generate navbarPages with default starter text. You can find the source code
on github at
\href{https://github.com/davidruvolo51/Rutils/blob/master/functions/shiny_maker.R}{github/davidruvolo51/.../shiny_makerR.}
See below for further usage.
}
\examples{
source("shiny_maker.R")

# run with defaults
navbarMaker()


# set directory name
navbarMaker(directory_name = "project_analysis_tool")

# set dir name and path
navbarMaker(directory_name = "cognitive_data_visualization",
            dir_path = "~/Documents/Anlysis")

}
