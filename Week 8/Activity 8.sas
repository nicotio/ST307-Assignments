/*********************************************
**Nico Tio
**Activity 8
**ST 307
*********************************************/

/*1. Create a new library called "topic8". And copy the following code to do a simple
random sampling of the data. Then print out the output data set to see what it looks
like. The rest of the questions will be based on the sampled observations.*/


LIBNAME topic8 "C:\Users\nicot\Desktop\Week 8";

PROC SURVEYSELECT DATA=sashelp.bweight METHOD=SRS N=200 OUT=infants SEED=12345;
RUN;


/*2. Use PROC TTEST to do the following t-tests for the mean weight. In the
comment, give the conclusion of each test.
a. One-sided t-test H0: mean weight < 3000, at significance level of 0.1;
  
b. Two-sided t-test H0: mean weight = 3300, at significance level of 0.05,
report the 95% confidence interval of mean weight;

c. Answer in comments: Does the data seem to be normal? What kind of plot
do you use to draw the conclusion?

THe data seems to be normal. Looking at the QQ plot, it matches almost perfectly.
*/


PROC TTEST DATA = infants SIDES = U H0 = 3000 ALPHA = 0.1;
	VAR weight;
RUN;

PROC TTEST DATA = infants SIDES = 2 H0 = 3300 ALPHA = 0.05;
	VAR weight;
RUN;

/*3. Use PROC FREQ to do a proportion test of infants’ sex (1 stands for boys):
a. H0: proportion of boys = 0.4, at significance level of 0.1. (Hint: check the
binomial option of TABLE statement)
b. In the comment, report the 90% confidence limits for boys’ proportion (use
Exact CL, note that the default output for CL is for level=0), and make a
conclusion of the test.
We are  90% confidents that the true proportion for the variable boy is between the range (0.4644,0.5850 )
*/

PROC FREQ DATA = infants;
	TABLES boy / Binomial (LEVEL = "1" P = 0.4) ALPHA = 0.1;
RUN;

/*
4. Use PROC TTEST to test for whether the mean of MomWtGain equals 0, at
significance level of 0.05, by MomEdLevel. In comments, make conclusion for
each group.
(Hint: you must sort the data first and output it to a new data set, then use the
sorted data to do TTEST for each group)
*/

PROC SORT DATA = infants OUT = sortedInfants;
	BY MomEdLevel;
RUN;

PROC TTEST DATA = sortedInfants SIDE = U H0 = 0 ALPHA = 0.05;
	VAR MomWtGain;
	BY MomEdLevel;
RUN;	

* We failed to reject null hypothesis on a 95% confidence level. The data doesn't support that there a change in weight;


/*
5. Do the followings:
a. Select the girl infants (0 stands for girls) with smoking mother (1 stands for
smoker), store the data permanently in the topic8 library.
b. Two-sided t-test H0: mean weight = 4000, at significance level of 0.05, 
c. Make a conclusion, and report a 95% confidence interval.*/



DATA topic8.girlsmoke;
SET infants;
WHERE boy = 0 & MomSmoke = 1;
RUN; 


PROC TTEST DATA = topic8.girlsmoke SIDES = 2 H0 = 4000 ALPHA = 0.05;
	VAR weight;
RUN;	

* We are 95% confident that the true mean weight is between (2864.2,3445.1 )























