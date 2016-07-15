# Rutils
<i>A Collection of R functions</i>

## Functions

### Primary funtions

<ol>
    <li><i>load_utils:</i> The primary function for loading all functions. Sets to default directory (github/Rutils)</li><br>
    <li><i> clearR.R:</i> clear series - includes clear.console (wipes the console down) and clear.environment (removes all non-functions)</li><br>
</ol>

### Data Transformation

<ol>
    <li><i> date_series:</i> useful functions relating to dates (i.e., data conversion, adding dates, difference between dates, etc.)</li><br>
    <li><i> getR:</i> get series (includes get loaded functions, get file list/size of a directory, get a string from an object)</li><br>
    <li><i> toTable:</i> series of functions that send summary stats to csv file (handy with psych package)</li><br>
</ol>

### Shiny

<ol>
    <li><i> make_it_shiny:</i> function for creating a shiny directory and initial files</li><br>
    <li><i> shiny_functions:</i> useful shiny functions for data entry based apps (save, load, timestamp)</li><br> 
</ol>

### Tables and Figures

<ol>
    <li><i> ggplot_tools:</i> function for combining multiple ggplot objects and custom themes!</li><br>
    <li><i> make_HTMLtable:</i> auto generates an HTML friendly table with alt row/col colors, other features included</li><br>
    <li><i> make_xtable:</i> auto generates a latex friendly table</li><br>
</ol>

### Useful Converters

<ol>
    <li><i> conversion_script.R:</i> useful conversion functions</li><br>
    <li><i> lipid_conversion:</i> handy function for converting lipid panel from US to UK by gender. Includes flags!!</li><br>
</ol>


### Misc.

<ol>
    <li><i> stopwatch:</i> fun stopwatch function.</li> <br>
</ol>

### OLD

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
</ul>
