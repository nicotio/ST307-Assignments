/*********************************************
**Pre-Class Activity 7
**NICO TIO
**St 307
*********************************************/

*For this activity, you should download the data file for the assigment and place it in a folder you will use as a library.;  

*1. Create a SAS library called ST307 that contains the data file;

LIBNAME ST307 "C:\Users\nicot\Desktop\Week7";

*2. Read in the cigarettes.txt data set using an infile statement.  
Save this in your ST307 library as a data set called cigs.
Note that this is a space delimited file and that the first line includes the variable names!
The longest brand name has 16 characters, use an informat to make sure nothing is truncated.;

DATA ST307.cigs;
	INFILE "C:\Users\nicot\Desktop\Week7\cigarettes.txt" FIRSTOBS=2 DELIMITER=" ";
	INPUT Brand :  $16. Tar  Nicotine Weight CO;
RUN;

*3. Use a data step and the set statement to create a new data set in your WORKING directory called cigarettes.
This new data set should include a new variable called Addictive.  Use a LENGTH statement to set the length of 
Addictive to be 8 prior to the IF THEN ELSE you'll use below.
If the value of nicotine is greater than 1 then Addictive should take the value "High".
If the value of nicotine is between 0.75 and 1 (including 1) then Addictive should take the value "Moderate".
If the value of nicotine is less than 0.75 (including 0.75) then Addictive should take the value "Low".
You should also remove the co variable and only include observations where tar is less than or equal to 16.;

DATA cigarettes;
	SET ST307.cigs;
	LENGTH AddictiveValue $8.;
	IF (nicotine > 1) THEN AddictiveValue = "High" ;
	ELSE IF (nicotine > .75) & (nicotine <= 1) THEN AddictiveValue = "Moderate";
	ELSE AddictiveValue = "Low";
		
RUN;
