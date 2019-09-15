/*
Nico Tio
ST 307
Activity 7
*/


*1. Create a new library called "Week7".;

LIBNAME Week7 "C:\Users\nicot\Desktop\Week7";

/*
2. Read in the FastFood.csv file with a single DATA step and the following
specifications:
a) Save the data set as "FastFood" in the Week7 library.
b) Use the proper informat for the "Price" variable.
c) Make a new variable "Ratio" which is a relative ratio of Sodium to the standard
1,500mg daily allowance.
d) Create a new variable that hides the brand names except the initial character.
e) A new categorical variable would be created by the following code.
IF Ratio > 0.8 THEN SodiumLevel= "Salty" ;
ELSE SodiumLevel="Healthy";
g) Display the "Ratio" variable in percentage format.
h) Display the "Price" variable with dollar sign and two digits right to decimal
point.
i) Display the "Calories" variable with comma. (e.g. 2,400)
*/

DATA Week7.FastFood;
	INFILE "C:\Users\nicot\Desktop\Week7\FastFood.csv" FIRSTOBS=2 DELIMITER = ",";
	LENGTH Type $ 9. Brand $ 11. SodiumLevel $ 13; 
	INPUT Type $ Calories Cal_Fat Tran_Fat Sat_Fat Chol Sodium Brand Price : dollar5.;
	Ratio = Sodium / 1500;
	BrandInitial = SUBSTR(brand,1, 1); 
	IF Ratio > 0.8 THEN SodiumLevel= "Salty" ;
		ELSE SodiumLevel="Healthy";
		FORMAT Price dollar7.2 Calories comma5. Ratio percent. ;
RUN;

*To avoid truncated values, set the length of the variable large enough for the variable to store the dataset.;


/*
3a) Create a new data set called McDonalds utilizing the SET and WHERE
statements. The new data set should only include McDonalds’ data.
3b) Make a new variable called "Price_Dollar" which is the smallest integer that is
greater than or equal to the "Price" value.
(You may see CEIL function is useful.)
3c) Keep only "SodiumLevel" and "Price_Dollar" variables in the final dataset.
3d) Display a dollar sign for "Price_Dollar" variable*/

DATA McDonalds;
	SET Week7.FastFood;
	WHERE Brand = "McDonalds";
	Price_Dollar = CEIL(Price);
	KEEP SodiumLevel Price_Dollar;
	FORMAT Price_Dollar dollar5.2;
RUN;


*Make a vertical bar chart like the following plot;
PROC SGPLOT DATA = McDonalds;
VBAR Price_Dollar / GROUP = SodiumLevel;
RUN;

/*
a) Create a new data set called BurgerKing that includes only Burger King data
utilizing the IF statement with THEN DELETE.
b) Make a new variable called "MedianFat" which is the median of the three fatrelated
variables.
c) Drop the three fat variables.
*/

DATA BurgerKing;
	SET Week7.FastFood;
	IF (BRAND = "McDonalds") THEN DELETE ;
	MedianFat = median(Cal_Fat, Tran_Fat, Sat_Fat);
	DROP Cal_Fat Tran_Fat Sat_Fat;
RUN;


*Draw a scatter plot with the MedianFat on x-axis and Calories on y-axis;
PROC SGPLOT DATA = BurgerKing;
SCATTER X = MedianFat Y = Calories;
RUN;
