/*
Nico Tio
Project 3
ST 307
*/

*1. Create a library called Project3.;

LIBNAME Project3 "C:\Users\nicot\Desktop\SAS\Project 3";

/*2. Read in the cheese.csv and save it as dataset cheese in library Project3. Use correct
Informant if needed.*/

DATA Project3.cheese;
	INFILE "C:\Users\nicot\Desktop\SAS\Project 3\cheese.csv" DSD FIRSTOBS=2 DLM=',';
	INPUT date : mmddyy10. taste acetic h2s lactic missing;
	FORMAT date : mmddyy10.;
RUN;

/*
3.
a) Create a permanent dataset cheesecomplete which only contain observations with nonmissing
data (missing =0). For the rest of the questions in 3, use dataset cheesecompete.
b) Plot a histogram for the subjective taste test score using PROC SGPLOT with the bin width 4.
c) Based on b, answer the question in a comment: which bin contains the most scores?	

THe bin 20 contrains the most scores
*/

DATA Project3.cheesecomplete;
	SET Project3.cheese;
	WHERE Missing = 0;
RUN;

PROC SGPLOT DATA = Project3.cheesecomplete;
	HISTOGRAM taste / BINWIDTH = 4;
RUN;


/*
4. Create a temporary dataset cheesecomplete with all observations from the permanent
dataset cheesecomplete.
a) Format the variables Date similar to “Friday, 1 December 1995”
b) Drop variable “missing”.
c) Display the dataset in the output window.
*/


DATA cheesecomplete;
	SET Project3.cheese;
	FORMAT date : WEEKDATE.; 
	DROP Missing;
RUN;

PROC PRINT DATA = cheesecomplete;
RUN;

/*5. 
a) We want to test whether the mean test scores between two dates are different. 
Write down in a comment using equation or inequality: what is the null and alternative hypothesis.
b) Write SAS code to test the hypothesis in a using the permanent dataset cheesecomplete.
c) Report the p value in a comment. What is your conclusion given significance level 0.05?*/

PROC TTEST DATA = project3.cheesecomplete SIDES = 2 H0 = 0 ALPHA = 0.05;
	VAR taste;
	CLASS date;
RUN;

/*5. p value before alpha < 0.2183. Based on the significance level, 
there is no significant statistical anaylsis showing that the mean test scores are different from one another based on a p value of <0.2183
We failed to reject the null hypothesis*/


/*6. Use the permanent dataset cheesecomplete to answer the following questions,
a) Perform a correlation analysis among 4 variables: taste, Acetic, H2S and Lactic. Answer
this in a comment: Which variable has the highest correlation coefficient with taste?

H2S has the highest correlation coefficient with taste


b) Fit a multiple linear regression model between the response taste and the covariates
Acetic/ H2S/ Lactic with model diagnostics plots.


c) Answer this question in a comment: Write down the linear model using the estimated
value of slopes and intercept from output.

taste = 19.67054335 * (lactic) + 3.91184107 * (h2s) + 0.32774129 * (acetic)  -28.87676961

d) Comment on the assumptions of this model.
We can assume the data is normal. Lactic and h2s much more significant compares to acetic because acetic p value is greater than .05
*/


PROC CORR DATA = Project3.cheesecomplete FISHER;
	VAR taste acetic h2s lactic;
RUN;

PROC GLM DATA = Project3.cheesecomplete PLOTS = ALL;
	MODEL taste = acetic h2s lactic;
RUN;
QUIT;
