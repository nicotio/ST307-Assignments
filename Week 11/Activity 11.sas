/*
**Nico Tio
**Activity 11/ ST 307
*/

*1) Create a library called Topic11, load data from height_weight.csv and store it in the dataset hw in the library.;

LIBNAME Topic11 "C:\Users\nicot\Desktop\SAS\Week 11";

DATA Topic11.HW;
	INFILE "C:\Users\nicot\Desktop\SAS\Week 11\height_weight.csv" DELIMITER="," FIRSTOBS=2;
	INPUT height weight;
RUN;

PROC UNIVARIATE DATA= Topic11.HW;
RUN;


/*What is the median weight of all children? What is the average height of all children?
**The median weight of all children is 127.8750 lbs and the average height is 67.935 inches*/


/*2. We�ll use a simple linear regression to characterize the relationship between body height and body weight. We
will treat height as the "predictor" and weight as the "response". We will refer to this model as model one.
a) Answer this in a comment: Write down the linear model using the estimated value of slope and intercept
from output;*/
					
PROC GLM DATA = Topic11.HW PLOTS = ALL;
	MODEL weight = height/CLM;
RUN;
QUIT;

*weight = (Height) * 3.4326761 - 106.0277064;


/*b) Answer this in a comment: What is the 95% confidence Interval of mean weight for a 69.4 inches child?
(Hint: Refer to the 3rd observation)
The 95% confidence interval for 69.4 inches child is (130.46459366,133.93544018)
*/


/*3a) Create a temporary dataset hw with two new variables: weight2 that is the body weight in kilograms and
height2 that is height in centimeters*/

DATA hw;
	SET Topic11.HW;
	weight2 = 1/2.2*weight;
	height2 = 2.54*height;
RUN;

 
/*3b) Fit the simple linear regression. Answer this in a comment: Use the SAS output and write down the formula
(value1/value2=answer) to calculate the ratio between the current slope and that in question 2.*/

PROC GLM DATA = hw PLOTS = ALL;
	MODEL weight2 = height2/CLM;
RUN;
QUIT;

/* *weight2 = (Height2) * 0.61429422 - 48.19441202;
	 3.4326761 / 0.61429422 = 5.588
	The ratio between the current slope and question 2's slope is 5.588
	

/*4. Go back to the original unit (Question 2). Add a quadratic term of height to the regression model. We will refer to
this model as model II.*/

PROC GLM DATA = hw PLOTS = ALL;
	MODEL weight = height height*height;
RUN;
QUIT;


/*4a) Answer this in a comment: Write down model II using the estimated coefficients from output. Are the
model assumptions roughly met?

Model II
weight = (height)*17.0236832 + (height*height)*(-0.0997394) - 568.6458994
Yes the model assumptions are roughly met

4b) Answer this in a comment: Find the p-value of the quadratic term. Which model would you prefer,
Model I or Model II?

P-value of quadratic term is .4595
I would prefer Model I because the P value of Model I is <.0001

*/



/*5a) Build a multiple regression model to model the relationship between infant birth weight and all following
information: infant gender, Smoking Mother indicator, Mother�s Pregnancy Weight Gain and Mother's Age.
(Hint: use proc content to get variable names). Are the model assumptions roughly met?
Yes the model assumptions are roughly met based on QQ plot
*/

PROC CONTENTS DATA = sashelp.bweight;
RUN;


PROC GLM DATA = sashelp.bweight PLOTS(MAXPOINTS=50000)=ALL;
	MODEL Weight = Boy MomSmoke MomWtGain MomAge ;
RUN;
QUIT;

PROC UNIVARIATE DATA = sashelp.bweight;
RUN;

/*b)Answer this in a comment: What is the prediction value and 95% Prediction Interval for the weight of a
baby boy whose mom (1) smokes (2) has average weight gain and (3) has average age (Hint: follow the
steps below)
Prediction value of weight (3398.266685)
95% Prediction Interval of weight (2378.851057, 4417.682314) 
.

b1) Create a new dataset temp with missing birth weight and the above predictor values;(Hint: The
dataset sas.bweight is scaled. So the corresponding value for average should be 0.)*/

DATA temp;
	INPUT Weight Boy MomSmoke MomWtGain MomAge;
	DATALINES;
	. 1 1 0.70922 0.41614
;
RUN;


/*b2) Create a temporary dataset bweight keeping only relevant variables and the first 200
observations; (Hint: you can use obs option in set statement).*/

DATA bweight;
SET sashelp.bweight (OBS=200);
KEEP Weight Boy MomSmoke MomWtGain MomAge;
RUN;


*b3) Append dataset temp to dataset bweight(Hint: use proc datasets);

PROC DATASETS;
	APPEND BASE=bweight DATA=temp;
RUN;

*b4) Get prediction value and prediction interval.;

PROC GLM DATA=bweight PLOTS=ALL;
	MODEL Weight = Boy MomSmoke MomWtGain MomAge/ CLI ;
RUN;
QUIT;







