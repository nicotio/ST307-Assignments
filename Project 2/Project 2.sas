/*
Nico Tio
ST 307
Project 2
*/


*1. Create a new library called "Project 2".;

LIBNAME Project2 "C:\Users\nicot\Desktop\Project2";

/*2. Read in the citybike.csv file with a single DATA step and the following
specifications:
a. Save the data set as “citybike” in library “Project2”;
b. Use correct Informat for each variable, note that gender variable should be
categorical instead of numerical;
c. Create a new variable called “duration” which equals the minutes from start
to end time. (Hint: SAS stores time in seconds)
d. Create a new variable called “age” which is the age of users at the start time.
(hint: use datepart() and year() functions to extract the year of startT)
e. Format variables “startT” and “endT” as mm/dd/yy hh:mm AM/PM;
f. Label variables “startT”, “endT”, “startS” and “endS”;*/

DATA Project2.citybike;
	INFILE "C:\Users\nicot\Desktop\Project2\citybike.csv" FIRSTOBS=2 DELIMITER = ",";
	INPUT startT : MDYAMPM. endT : MDYAMPM. startS : $21. endS : $21. bikeID user : $12. gender $ birthyear;
	Duration = (endT - startT)/60;
	Age = Year(datepart(startT)) - birthyear;
	FORMAT startT MDYAMPM. endT MDYAMPM.;
	LABEL starT = "Start Time" endT = "End Time" StartS = "Start Station" endS = "End Station";
RUN;

/*3. Create a new dataset called “newcitybike” to library “Project2” and do the
followings:
a. Drop variable bikeID;
b. Modify the gender if the value is 0, then gender=”unknown”, if 1,
gender=“female”, and if 2, gender=”male”.
*/

DATA Project2.newcitybike;
SET Project2.citybike;
DROP bikeID;
IF gender = 0 THEN gender = "unknown";
ELSE IF gender = 1 THEN  gender = "female";
ELSE gender = "male";
RUN;

/*4 4. Use PROC UNIVARIATE to generate a statistical summary of duration variable.
Output the mean, maximum and minimum to the temporary “duration” dataset.*/

PROC UNIVARIATE DATA = Project2.citybike;
VAR DURATION;
OUTPUT OUT = duration MEAN = Mean MAX = Maximum MIN = Mininum;
RUN;

/*5. Create a box plot for the variable “duration” for only those with values less than
200 minutes at the start station “Grove St PATH”.*/

PROC SGPLOT DATA = Project2.citybike;
HBOX duration;
WHERE duration < 200 & startS = "Grove St PATH";
RUN;

/*6. What factor is related to the missing data for birth and gender? To solve the
issue, drop the observations with missing values and create a new temporary
dataset called “subscriber”:
a. Select the observations of usertype=”Subscriber” only use the IF statement
with THEN DELETE. Could you use a WHERE statement for this?
b. Create a new variable called “agegroup” which separate the users into 3 age
groups called “old”, “middle” and “young” at the margin of 60 and 25*/

DATA subscriber;
SET Project2.citybike;
LENGTH agegroup $7.;
IF user ^= "Subscriber" THEN DELETE;
IF Age >= 60 THEN agegroup = "old";
ELSE IF Age >= 25 THEN agegroup = "middle";
ELSE agegroup = "young";
RUN;

*You use WHERE statement as well;

/*7. Generate a box plot for variable duration, for those with duration less than 100
minutes for each age group. Answer the following questions:
a. Which type of users tend to use longer time? Middle age group
b. What reason do you think cause the result? Young age group has no money, Old age group has no energy  */


PROC SGPLOT DATA = subscriber;
HBOX duration / CATEGORY = agegroup;
WHERE duration < 100;
RUN;
