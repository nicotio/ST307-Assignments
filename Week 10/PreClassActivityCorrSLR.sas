/*********************************************
**Nico TIo
**Pre-Class Activity 13 Key
**ST 307
*********************************************/

*For this activity, you should read in the chis.csv file using an INFILE statement. ;

*Description of the data: The data are observations on California High School Age students.  The variables measured are height, weight, BMI, and whether the 
student was of Asian descent.;

*Create a SAS library called ST307 that contains the data file;

LIBNAME ST307 "C:\Users\nicot\Desktop\Week 10";

*Read in CHIS.csv file into SAS with a data step.;

DATA ST307.CHIS;
	INFILE "C:\Users\nicot\Desktop\Week 10\CHIS.csv" DLM="," FIRSTOBS=2;
	INPUT Height Weight BMI Asian;
RUN; 


*Write a SAS file that will
1. find the (pearson) correlations between the height, weight, and BMI variables.  
2. produce statistical tests of whether the (pearson) correlations differ from 0.;

PROC CORR DATA= ST307.CHIS FISHER;
	VAR height weight bmi;
RUN;


*Then report the following using Pearson's correlation coefficient:
3. The estimate of the correlation between height and BMI and a p-value for testing if the correlation 0.  State a conclusion.;
/*There is a negative correlation of -0.2883 between height and BMI. P-Value of 0.1272. We can conclude that correlation 
between height and bmi is not statistically signficant*/


*4. Fit an SLR model with height as the predictor and weight as the response;

PROC GLM DATA=ST307.CHIS PLOTS=ALL;
	MODEL Weight = Height/CLPARM;
RUN;
