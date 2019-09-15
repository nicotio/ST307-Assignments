/*
**Nico Tio
**Activity 10
*/

*1. Create a library called Topic10;
LIBNAME Topic10 "C:\Users\nicot\Desktop\Week 10";

/*2. Read in the data with all the 6 variables, then drop the variable DBN. Here are two points you
need to pay attention to:

a. Some of the school names contain a comma in between. This will cause some trouble
since the delimiter in this data set is also comma, and SAS will break those school names
apart. To solve this issue, add a DSD option on the INFILE statement.

b. By default, SAS will treat a period (.) as missing numeric value, but not a character ‘s’.
To make this happen, try adding a MISSING statement in the DATA step.*/


DATA Topic10.SAT;
	MISSING s;
	INFILE "C:\Users\nicot\Desktop\Week 10\SAT.csv" dsd DELIMITER="," FIRSTOBS=2;
	INPUT DBN $ SchoolName :$50. NumberOfTestTakers CriticalReadingMean MathematicsMean WritingMean;
	DROP DBN;	
RUN;	


/*3. Setting aside the number of students in each high school, perform a naive correlation analysis
among the average score of three subjects.
a. Have SAS produce a scatter plot matrix with histograms along the diagonal.
b. Answer in a comment: which two of them have the strongest correlation? What is their
correlation coefficient?

The two variable with the strongest correlation are writing mean and criticla reading mean. 
They have a positive correlation coefficient of 0.97840;
*/

PROC CORR DATA=Topic10.SAT PLOTS=MATRIX(HIST);
	VAR CriticalReadingMean MathematicsMean WritingMean;
RUN; 

/*4. Taking into account the number of students this time, perform a weighted correlation analysis
among those three variables. So each data point will be treated as if they appear the number of
times equal to the number of students taking the exam in that high school. A WEIGHT statement
will help you with it.
a. Have SAS produce a scatter plot matrix with histograms along the diagonal.
b. Answer in a comment: which two of them have the strongest correlation? What is their
correlation coefficient?

The two variable with the strongest correlation are writing mean and criticla reading mean. 
They have a positive correlation coefficient of 0.99346;
*/

PROC CORR DATA=Topic10.SAT PLOT=MATRIX(HIST);
	VAR CriticalReadingMean MathematicsMean WritingMean;
	WEIGHT NumberOfTestTakers;
RUN;


/*5. Find a 95% confidence interval for the correlation between the school-average reading and
writing scores, under Fisher’s z transformation. (A weighted test will be preferred.)

The 95% confidence interval range is (0.991992,0.994628)
*/

PROC CORR DATA=Topic10.SAT FISHER;
	VAR CriticalReadingMean WritingMean;
	WEIGHT NumberOfTestTakers;
RUN;

/*6. Fit a simple linear model with the school-average reading score as predictor and writing score as
response (ignore the number of students).
a. Find the 95% confidence interval for the slope of this model. Interpret you result.
b. Have SAS produce the diagnostic plots and comment on the assumptions of this model

THe simple linear model is statistially significant with p-value < 0.05. The model has R-square of .96
which means that the critical reading mean scores explains 95.72% of the variability of the writing mea. 
The Critical Mean variable is statiscally significant with a p-value < 0.05. For every point increase in Critical Reading Mean,
There will be a .9947 point increase on the average of writing. We are 95% confident that the coefficient is in the range of (0.9736,1.0157)

Looking at the residual plot , it's a straight line on the quantile plot that show the data normality without much deviation.  

.*/

PROC GLM DATA=Topic10.SAT PLOTS=ALL;
	MODEL WritingMean = CriticalReadingMean/CLPARM;
RUN;

