/* ST307 Activity 4
   Nico Tio
   Members: Marc Navia, Liam Wall, Mia Freeland
*/

/*1. Create a new library called Week4 where you have saved the gpa.txt, airquality.csv, and
broilers.txt raw data files.*/

LIBNAME Week4 "C:\Users\nicot\Desktop\MyData";


/*2. Use DATA step to read the airquality.csv file into Week4 library. 
*/

PROC PRINT DATA = Week4.airquality;
RUN;
/*3. Sort the SAS dataset in question 4 according to Month variable, and save the sorted dataset in a
temporary library. */

PROC SORT DATA=Week4.airquality OUT = sortedAir;
	BY month;
RUN;


/*4 Use PROC UNIVARIATE and the sorted data to output a new data set called �summary� which has
the ranges of Ozone and Wind variables for each month. The new data set should be saved in
Week4 library. */
PROC UNIVARIATE DATA = sortedAir;
BY month;
VAR ozone wind;
OUTPUT OUT = Week4.summary RANGE=ozone wind;
RUN;


/*5. Use DATA step to read the gpa.txt file into a temporary library.
The original data contains information on students including their scores in midterm (exam 1) and
final (exam 2). Only Score and GPA variables are numeric. 
*/

DATA Week4.gpaNew;
	INFILE "C:\Users\nicot\Desktop\MyData\gpaNew.txt" FIRSTOBS = 6 DELIMITER = "_" ;
	INPUT student $ sex $ Exam $ Score gpa level $;
RUN;


/*6a. Create a two-way contingency table with Sex and Level variables. Export this table as a
permanent data set in Week4 library*/
PROC FREQ DATA = Week4.gpaNew;
	TABLES Sex*Level / OUT = Week4.gpa;
RUN;

/*6b. In a comment below your code answer the following question:
In SAS we often reference a data set by writing something like ‘name1.name2’. What information
does name1 tell SAS and what information does name2 tell SAS?

name1 is is the libary where the data set is stored. 
name2 is the name of the data set in the library.

*/

/*7. Read the text file in Week4 library.
This file is a tab delimited file. The Boiler and Drum variable are categorical, and all others are
numeric. Check out the DELIMITER option on the INFILE statement to find out the representation of
a tab in SAS code. 
*/

DATA Week4.boiler;
	INFILE "C:\Users\nicot\Desktop\MyData\broilers.txt" FIRSTOBS = 2 DELIMITER='090D'x ;
	INPUT ManHRs Capacity Pressure Boiler $	Drum $ CP;
RUN;

/*Use a DATA step to read the above data in using the instream method. Save the data set into your
Week4 library. 
*/

DATA Week4.petMusic;
	INPUT Obervastion Pet $ Music $;
	DATALINES;
	1 Cat Rock
2 Dog Rock
3 Fish Oldies
4 Dog Rap
5 Dog Oldies
6 Cat Rock
7 Cat Rock
8 Cat Oldies
9 Fish Rock
10 Dog Rap
11 Cat Oldies
12 Fish Rap
13 Fish Oldies
14 Fish Oldies
15 Dog Oldies
16 Cat Rock
RUN;
