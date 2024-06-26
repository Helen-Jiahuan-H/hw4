<<dd_version: 2>>     
<<dd_include: header.txt>>

# Data Simulation 

### Jiahuan Helen He, BS (MHS Candidate)

**Background:** 
A <u>user</u> downloads and installs a <u>system</u> of program files, mostly ado-files, which form the foundation of most of the commands 
used in Stata Programming. Using those commands and additional syntax written out sequentially in a do-file, the user creates 
well-formed instruction to Stata called a do-file script. Once the user runs this script, results are generated and displayed
in the results window, in a graph, or in a format (`.xlsx`, `.log`, `.dta`, `.docx`, `.md`, `LaTeX`, `.html`, etc). The `.html` file format is of specific 
interest since its the pathway to self-publication. To illustrate how this may be achieved in Stata, we hereby introduce the `dyndoc`
command. 

**Methods:** 
This is a uses simulated dataset. This simulation drew values for age from both normal distribution and t-distribution. 
There are 30 observations in total. 
Distribution graph is shown below. 

We created a [do-file](https://raw.githubusercontent.com/jhustata/livre/main/filename.do) and populated it with this abstract using [markdown](https://en.wikipedia.org/wiki/Markdown) language. Anything 
in this document that is not ordinary text including `<<dd_version: 2>>`, `<<dd_do:nooutput>>`, `<</dd_do>>`, `<<dd_display: c(N)>>` is a 
[markup](https://en.wikipedia.org/wiki/Markup_language#:~:text=A%20markup%20language%20is%20a,content%20to%20facilitate%20automated%20processing.). 
Input & output that might be numeric, string, alphanumeric, or formatted as macros are embeded at these markedup points. We then saved this 
document using the file extension .do; however, any text file extension will work (.txt, .md, .do, etc). To the `pwd` where we saved
this text file, we added a cascading style sheet [stmarkdown.css](https://raw.githubusercontent.com/jhustata/livre/main/stmarkdown.css) and [header.txt](https://raw.githubusercontent.com/jhustata/livre/main/header.txt) to enhance the aesthetic of our .html file. Finally, we typed the 
following command into the Stata command window:   `dyndoc filename.do, saving(filename.html) replace`. In the key analysis, $Y  = \beta_0   +  \beta_1 X$, where $Y$ is life expectancy at birth in years, the outcome or dependent variable; $X$ is the country, the predictor or independent variable being tested.     

```
<<dd_do:nooutput>>
	clear all
	
	* Initialize dataset with 30 observations
	set obs 30
		
	* Create an age variable with a mean of 57 years and a standard deviation of 15
	capture drop age age_t
	gen age = (rnormal() * 15) + 57 //Uses normal distribution
	gen age_t=(rt(_N)*15)+57 //Uses t_distribution
	
	* Plot a histogram of the age variables from both rnormal() and rt(), and overlay it with a theoretical normal distribution curve. 
	hist age, ///
		  fcolor(orange%40) /// simulated normal 
		  addplot(hist age_t, fcolor(midblue%50)) /// simulated t-distribution 
		  normal /// theoretical normal
		  legend(on ///
			 lab(1 "Sampled from Normal") ///
			 lab(2 "Theoretical Normal") ///
			 lab(3 "Sampled from t-distribution") ///
			)
	graph export hw4_hist.png, replace 
<</dd_do>>
```

<<dd_graph>>


The distribution of the data follows a normal distribution: 
$$\text{Age, years} \sim \mathcal{N}(\mu=57,\,\sigma^{2}=225)$$




```
<<dd_do>>
display c(N) 
display c(k)  
list in 1/5 
<</dd_do>>
```

**Results:** 
We identified the newly created .html file in our directory and opened it to compare its format to this markdown file. And we saw all that
we had made, and behold, it was very good. Ghastly macros in the original markdown language were now rendered as neatly formatted
results. There were  <<dd_display: c(N)>> observations and <<dd_display: c(k) >> variables in the analyzed dataset. Average life expectancy of all countries, $\beta_0$, was <<dd_display: `b0' >> years. Difference in life expectancy among <u>adjacent</u> countries, $\beta_1$, showed no trend or pattern and was <<dd_display: `b1' >> years, essentially $zero$, and $p$ = <<dd_display: `p' >>

**Conclusions:** 
In walking you through syntax, do-file creation, queued commands, generated results, through to embedding neatly formatted output in
.html, we believe you now have a sense of what that Stata might offer you. These ideas can be generalized to embedding results 
in .xlsx, .log, .dta, .docx, etc. 




