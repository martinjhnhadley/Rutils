# Rutils

Collection of R functions that I use.

### Primary funtions

<ol>
    <li><b>load_utils:</b> The primary function for loading all functions. Sets to default directory (github/Rutils)</li><br>
    <li><b> clearR.R:</b> clear series - includes clear.console (wipes the console down) and clear.environment (removes all non-functions)</li><br>
</ol>

### Data Transformation

<ol>
    <li><b> date_series:</b> useful functions relating to dates (i.e., data conversion, adding dates, difference between dates, etc.)</li><br>
    <li><b> getR:</b> get series (includes get loaded functions, get file list/size of a directory, get a string from an object)</li><br>
    <li><b> toTable:</b> series of functions that send summary stats to csv file (handy with psych package)</li><br>
</ol>

### Shiny

<ol>
    <li><b> make_it_shiny:</b> function for creating a shiny directory and initial files</li><br>
    <li><b> shiny_functions:</b> useful shiny functions for data entry based apps (save, load, timestamp)</li><br> 
</ol>

### Tables and Figures

<ol>
    <li><b> ggplot_tools:</b> function for combining multiple ggplot objects and custom themes!</li><br>
    <li><b> make_HTMLtable:</b> auto generates an HTML friendly table with alt row/col colors, other features included</li><br>
    <li><b> make_xtable:</b> auto generates a latex friendly table</li><br>
</ol>

### Useful Converters

<ol>
    <li><b> conversion_script.R:</b> useful conversion functions</li><br>
    <li><b> lipid_conversion:</b> handy function for converting lipid panel from US to UK by gender. Includes flags!!</li><br>
</ol>


### Misc.

<ol>
    <li><b> stopwatch:</b> fun stopwatch function.</li> <br>
</ol>

### OLD

<ol>
    <li><b> mainFunc:</b> *OLD: main script that includes everything - outdated </li><br>
    <li><b> R_ProgramUpdate:</b> <i>deactivated</i></li><br>

</ol>

## Use

To use these functions, load them into your R environment by using the load_utils.R file, and then
load all of the functions using the <code>load.utils()</code> function.

<ol>
    <li><code>source("~/.../load_utils.R")</code></li>
    <li><code>load.utils()</code></li>
</ol>

*<i>Note</i>: You will need to adjust the default directory accordingly.


