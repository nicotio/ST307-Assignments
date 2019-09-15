/*********************************************
**Nico Tio
**Pre-Class Activity 8
**ST 307
*********************************************/

*For this activity, you should download the data file for the assigment and place it in a folder you will use as a library.;  

*Description of the data:
The data studies the effect of bacteria on the nitrogen content of red clover plants. The treatment
factor is bacteria strain, and it has six levels. Red clover plants are inoculated with the treatments,
and nitrogen content is later measured in milligrams. The data are derived from an experiment by Erdman
(1946) and are analyzed in Chapters 7 and 8 of Steel and Torrie (1980).;

*1. Create a SAS library called ST307 that contains the data file;
LIBNAME ST307 "C:\Users\nicot\Desktop\Week 8";

*2. Read in the Cloverdata.txt data set using the code below.;  
DATA ST307.clovers;
	INFILE "C:\Users\nicot\Desktop\Week 8\Cloverdata.txt" FIRSTOBS=2;
	INPUT Strain $ Nitrogen;
RUN;

/*3. Write SAS code using PROC TTEST that will provide answers to the following questions.
(Assume your data comes from a normal population.)
Place your SAS code after the questions but put your answers as comments below each question part:

Consider the null and alternative hypotheses
H0: mu<=18.5 vs HA:mu>18.5

a) Find a p-value that tests these hypotheses.  State your p-value and your conclusion about the hypotheses.
p-value=0.1168 - fail to reject the null hypothesis

b) Report a two-sided confidence interval for the mean.
(17.5558, 22.2175)
c) Comment on the normality assumption based upon looking at your qqplot.
There is an approximate straight line so the normality assumption seems reasonable.
*/

PROC TTEST DATA = ST307.clovers;
	VAR nitrogen;
RUN;

PROC TTEST DATA = ST307.clovers SIDES = U H0=18.5 ALPHA = .05;
	VAR nitrogen;
RUN;

/*
a)Do not reject null hypothesis b/c it is P-value is greater than .05
b)We are 95% confident that the interal (17.5558, 22.2175) contains the true mean of nitrogen level for the strains.
c) It has symmetric distrubtion. */




