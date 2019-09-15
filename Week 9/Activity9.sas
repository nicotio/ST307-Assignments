/*
**Nico Tio
**Activity 9
**
*/

*1. Create a new library called week9;

LIBNAME Week9 "C:\Users\nicot\Desktop\Week 9";

/*
2)Read in the bloodpressure.csv with DATA step and the following specifications:
a. Save the data set as “bloodpressure” in the Week9 library.
b. Create a new variable called “agegroup” which separates subjects into 2 age groups.
If the age is less than the median value 61 then agegroup = “0” otherwise agegroup=”1”.
c. Create labels for all variables (including the new variable you created) based on
variable information. 
*/


DATA Week9.bloodpressure;
	INFILE "C:\Users\nicot\Desktop\Week 9\bloodpressure.csv" DELIMITER = "," FIRSTOBS=2;
	INPUT Subject $ Age BaselineBP NewBP AgeGroup;
	IF Age < 61 THEN AgeGroup = "0";
	ELSE AgeGroup = "1";
RUN;


/*
3. Use PROC TTEST procedure to answer the following questions:
a. Researchers expect that the medication was effective in reducing blood pressure.
State your null and alternative hypotheses in your comment.
b. Test whether there is difference between the baseline and new blood pressure at
the 0.1 significance level.
c. Report p-value and test statistic in your comment. State your conclusion.
d. Comments on the normality assumption.
*/

PROC TTEST DATA = week9.bloodpressure SIDES = U H0 = 0 ALPHA = 0.1 ;
PAIRED BaselineBP*NewBp;
RUN;

/*
a. H0 baseline - new medication = 0. Ha = baseline bloodpressire - newBP > 0
b. P-value is <.0001 and test statistic is 8.53. We are 90% confident that the medication is statistically significant.
d. We can assume there is normality but there is some variation.
/*

/*
4. Use PROC TTEST procedure to answer the following questions:
a. We want to see if baseline blood pressure has difference between age groups. Test
the equality of average baseline blood pressure between two age groups at the 0.1
significance level.
b. Comments on whether we will be using a pooled or un-pooled variance estimate.
c. Report p-value and test statistic and state your conclusion.
*/



PROC TTEST DATA = sortedBlood;
VAR BaselineBP;
CLASS AgeGroup;
RUN;


/*
b. We will using a pooled variance estimate
c. P-value  0.4312 test statistic = -0.80, We are 90% confident that BaselineBP has no difference on AgeGroup;
*/

/*
5) 
Create a new data set called “groupbp” to library “Week9” and answer the following
questions:
a. Drop variable agegroup.
b. Create a new variable called “idgroup” that has only the first letter of subject code.
Subject code starts from alphabet “N” or “A”. If the first letter is “N”, idgroup=”N”
otherwise, idgroup=”A”. Hint: Use SUBSTR() function.
c. Sort groupbp data set by subject group.
d. Test again whether there is difference between the baseline and new blood pressure
at the 0.05 significance level by two subject groups separately.
e. Report p-value and test statistic for each subject group and state your conclusion

	P-VALUE = < .0001 Test statistic = 134.86, We are 95% confident that there is a 
difference between the baseline and the new blood pressure between subject A and B  using the medication. 
*/

DATA week9.groupbp;
SET week9.bloodpressure;
DROP agegroup;
idgroup = SUBSTR(Subject,1,1);
RUN;

PROC SORT DATA = week9.groupbp OUT = week9.groupbp;
BY idgroup;
RUN;

PROC TTEST DATA = week9.groupbp SIDES = U H0 = 0 ALPHA = 0.05 ;
BY idgroup;
RUN;

