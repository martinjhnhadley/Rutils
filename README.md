# Rutils
<i>A Collection of R functions that I frequently use.</i>

## Functions

##### Primary funtions

<ol>
    <li><i>load_utils:</i> The primary function for loading all functions. Sets to default directory (github/Rutils)</li><br>
    <li><i>clearR.R:</i> clear series - includes clear.console (wipes the console down) and clear.environment (removes all non-functions)</li><br>
</ol>


#### System Functions

<ol>
    <li>dirInfo():</i> An expansion on dir(). This function provides a summary of getwd() i.e. total number of files, approx. size 
        of pwd, date created, date modified, and list of file types. A table summary is also provided with a boolean var for if the item
        is a directory. Sorting options are available. See below, <br>
        <code> dirInfo(path= getwd(),sort = c("name","type", "created", "modified","isDir"))</code>.<br><br>
        <i>Note:</i>The R package <i>tools</i> is required for extracting file properties.</li>
</ol>

#### Data Transformation

<ol>
    <li><i> date_series:</i> useful functions relating to dates (i.e., data conversion, adding dates, difference between dates, etc.)</li><br>
    <li><i> getR:</i> get series (includes get loaded functions, get a string from an object)</li><br>
    <li><i> toTable:</i> series of functions that send summary stats to csv file (handy with psych package)</li><br>
</ol>

#### Shiny

<ol>
    <li><i> make_it_shiny:</i> function for creating a shiny directory and initial files</li><br>
    <li><i> shiny_functions:</i> useful shiny functions for data entry based apps (save, load, timestamp)</li><br> 
</ol>

#### Tables and Figures

Some of the functions in the ggplot_tools.R file are from online forums, wheras
the <i>make</i> functions were written to automate table making. 
The <code>make_xtable()</code> is one of my favorites as it creates a \LaTeX 
friendly table for inclusion into pdf documents. I will explain the usage of the make_..table() series below.

<ol>
    <li><i> ggplot_tools:</i> function for combining multiple ggplot objects and custom themes!</li><br>
    <li><i> make_HTMLtable:</i> auto generates an HTML friendly table with alt row/col colors, other features included</li><br>
    <li><i> make_xtable:</i> auto generates a latex friendly table</li><br>
</ol>

<i>How to use the make table functions</i>

1) <b>make_xtable()</b>

The <code>make_xtable()</code> takes the following parameters:

<code>make_xtable(mydata, title = NULL, alignment = NULL, rotate = NULL, color = NULL, cnames = TRUE, rnames = FALSE)</code>

Where....

<ul>
    <li><code>mydata</code> = the dataset you want to make a table for. Currently
        the function does not handle inline subsets i.e. <code>mydata[c(1:5),]</code>, 
        future builds will likely address this issue.
    </li><br>
    <li><code>title</code> = the title you would like to place over the table. The 
        default title position is above the table.
    </li><br>
    <li><code>alignment</code> = horizontal position of table contents. Default is 'center'.
        To add custom alignment you would need to something like this:<br><br>
        <pre><code>
        # build df
        df <- data.frame("col1" = c("a","b"),"col2" = c(1,2))
    
        # set alignment
        my_alignment <- c("c","r","l") # alignment must have +1 entry to offset for rownames(?)
        make_xtable(df, alignment = my_alignment)
        
        # if you wanted to apply left alignment for all cols you would do something like this
        
        alignment <- rep("l",ncol(mydata)+1) 
        make_xtable(df, alignment = my_alignment)
        
        # OR
        
        alignment <- rep("r",ncol(mydata)+1) # for all cols right alignment
        make_xtable(df, alignment = my_alignment)
        
        </code></pre>
    </li><br>
    <li><code>rotate</code> = Print table as portrait or landscape. Default is FALSE.</li><br>
    <li><code>color</code> = Specify colors for color for alternative rows. Default is gray95. 
        This one is a little tricky as your custom color must be defined in the YAML/preamble.
        You can do this by adding the color like this:<br><br>
        <pre><code>
        # example YAML in Rmarkdown
        
        ---
        output: 
            pdf_document:
                latex_engine: xelatex
        header-includes:
        # load packages
        - \usepackage{colortbl,xcolor, color}           # call packages
        - \definecolor{Darkgreen}{rgb}{0,0.4,0}         # for Dark green using rgb
        - \definecolor{LightBlue}{RGB}{222,235,247}     # for LightBlue using RGB
        - \definecolor{Orange}{HTML}{DE2D26}            # for Red using HEX
        ---
        
        # add block here for loading data, etc.
        ```
        my_data <- data.frame("x" = c("A","B","C"), "y" = c(1:3))
        make_xtable(my_data, color = "LightBlue")
        ```
        
        </code></pre>
    </li><br>
    <li><code>cnames</code> = Display column names. Default is TRUE</li><br><br>
    <li><code>rnames</code> = Display row names. Default is FALSE</li><br><br>
</ul>


2) <b>make_html_table()</b>

The <code>make_html_table()</code> takes the following inputs:

<code>make_html_table(mydata,title = NULL,alignment=NULL,altRowColor = FALSE,altColColor = FALSE,rnames = FALSE)</code>

Where...
<ul>
    <li><code>mydata</code> = the dataset you wish to use for generating a table. Currently, the function does not handle
        inline subsets i.e. <code>make_html_table(df[,1])</code>. 
    </li><br>
    <li><code>title</code> = the title you would like to place over the table. The 
        default title position is above the table.
    </li><br>
    <li><code>alignment</code> = horizontal position of table contents. Default is 'center'.
        To add custom alignment you would need to something like this:<br><br>
        <pre><code>
        # build df
        df <- data.frame("col1" = c("a","b"),"col2" = c(1,2))
    
        # set alignment
        
        alignment = rep("c",ncol(mydata))
        make_html_table(df,alignment = alignment)
        
        # if you wanted to apply left alignment for all cols you would do something like this
        
        alignment <- rep("l",ncol(mydata)) 
        make_html_table(df,alignment = alignment)
        
        # OR
        
        alignment <- rep("r",ncol(mydata)+1) # for all cols right alignment
        make_html_table(df,alignment = alignment)
            
        </code></pre>
    </li><br>
    <li><code>altColColor</code> = Specify colors for color for alternative columns. Default is gray95.</li><br>
    <li><code>altRowColor</code> = Specify colors for color for alternative rowss. Default is gray95.</li><br>
    <li><code>rnames</code> = Display row names. Default is FALSE</li><br><br>
</ul>

## Useful Converters

<ol>
    <li><i> conversion_script.R:</i> useful conversion functions</li><br>
    <li><i> lipid_conversion:</i> handy function for converting lipid panel from US to UK by gender. Includes flags!!</li><br>
</ol>


## Misc.

<ol>
    <li><i> stopwatch:</i> fun stopwatch function.</li> <br>
</ol>

## OLD

<ol>
    <li><i> mainFunc:</i> *OLD: main script that includes everything - outdated </li><br>
    <li><i> R_ProgramUpdate:</i> <i>deactivated</i></li><br>

</ol>

## Use

To use these functions, load them into your R environment by using the load_utils.R file, and then
load all of the functions using the <code>load.utils()</code> function.

<ol>
    <li><code>source("~/.../load_utils.R")</code>*</li>
    <li><code>load.utils()</code></li>
</ol>

*<i>Note</i>: You will need to adjust the default directory accordingly.

## Notes

<ul>
    <li>The <code>make_it_shiny()</code> is my new favorite function. I use shiny a lot 
    and creating directories and necessary files can be tiring. Previous routines via the 
    terminal using the <code>mkdir</code> and <code>touch</code> commands helped speed up the initial
    setup, but I wanted something that was faster. The latest commit (July 15, 2016) incorporated
    a secondary function <code>make_my_text_shiny</code> uses the <code>write()</code> function
    to input the starting text in each file. This includes:<br>
        <ul>
            <li>Creating Text to load commonly used pacakges</li>
            <li>Creating the framework for the ui and server</li>
            <li>Linking the UI with external scripts (i.e., css, tracker, etc.)</li>
        </ul>
    <br>
    Use the function in the following way...<br><br>
    &nbsp;&nbsp;<code>make_my_text_shiny(file_path = "/path/to/file", file_type = "ui")</code><br><br>
    <i>file_type</i> takes the following inputs: ui, server, global.
    </li>
    <li>Function <code>dirInfo()</code> gets a list of all of the files in your working directory
    and presents summary information as a table. This includes file type, size, dates (created and modified), and
    flag for if the item is a directory. This only works when you want to get information on your current working directory.
    Ideally it should work for using specific paths (i.e., <code>.../.../this directory</code>, but it does not. Set the directory first, 
    and then execute. Any feedback on this would be appreciated.</li>
</ul>

Any feedback and comments are greatly appreciated. 

Visit <a href="www.davidcruvolo.com" target="_blank">www.davidcruvolo.com</a> for my contact details.<br><br>
