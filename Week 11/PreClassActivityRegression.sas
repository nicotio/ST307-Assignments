/*********************************************
**Pre-Class Activity Regression 
**NICO TIO
**ST 307
*********************************************/

*For this activity, you should read in the chis.csv file using an INFILE statement.  Note: This data was read in previously;

*Description of the data: The data are observations on California High School Age students.  
The variables measured are height, weight, BMI, and whether the student was of Asian descent.;

*1. Create a SAS library called ST307 that contains the data file and read in CHIS.csv file into SAS with a data step.;

LIBNAME ST307 "C:\Users\nicot\Desktop\SAS\Week 11";

DATA ST307.CHIS;
	INFILE "C:\Users\nicot\Desktop\SAS\Week 11\CHIS.csv" DELIMITER="," FIRSTOBS=2;
	INPUT height weight bmi asian;
RUN;

/*Write SAS code to
2. fit a multiple linear regression model between the response BMI and the covariates weight, height, and 
their interaction that includes model diagnostics.*/

PROC GLM DATA=ST307.CHIS PLOTS=ALL;
	MODEL BMI = height weight;
RUN;
QUIT;


/*Then report the following:
3. The p-value for testing the slope on the interaction of weight and height in the multiple linear regression model.

All the p-value is <.001

4. Comment on the assumption of normality and constant variance.

Based on the Contour Fit Plot for bmi, it looks normal. The normality means that weight and height is significant to a person's bmi.
The constant variance is small which means the spread is small.
*/




