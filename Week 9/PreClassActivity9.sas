/*********************************************
** Nico Tio
**Pre-Class Activity 9 
**ST 307
*********************************************/

*For this activity, you should download the data file for the assigment and place it in a folder you will use as a library.;  

*Description of the data:
The data give observations on test scores and math SAT scores for two different groups of people.  
One group received a study skills class (A) and the other did not (B).;

*1. Create a SAS library called ST307 that contains the data file;

LIBNAME ST307 "C:\Users\nicot\Desktop\Week 9";

*2. read the data into SAS;

DATA ST307.class;
	INFILE "C:\Users\nicot\Desktop\Week 9\Class.csv" FIRSTOBS=2 DELIMITER=',';
	INPUT Cond $ test msat;
RUN;


*3. Conduct the appropriate ttest using the TEST scores (not the math SAT scores)
and answer the questions below;

PROC TTEST DATA = ST307.class;
CLASS cond;
VAR test;
RUN;

*4. Use a significance level of 0.05.  From the output, report the appropriate 95% confidence interval.  
Interpret the interval in the context of the question.;

*Since the confidence interval contains 0, there is no significant difference between someone who received a study skill class vs who didn't;
