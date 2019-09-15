
/* Activity 5 NICO TIO 
 MEMBERS: MARC NAVIA, LIAM WALLS, MIA FREELAND
*/

*1) Create new library Week5 ;

LIBNAME Week5 "C:\Users\nicot\Desktop\Activity5";

/*2)
a) character variables must have a $. A $ can only store 8 characters, therefore you have to specify $n where n is the amount of character available 
b) numeric data could include dates, times. These data require special informats specified to be read into sas as a raw data file.
** for date you need to use the something like MMDDYYw and time would be like TIMEw
*/



/*3) The data set super.txt is available on the assignment link. There are two variables, first and last. Open
the file in a program such as and in a comment in your SAS program answer the following:
a) What is the length of the longest first name? 12 Jeanne-Marie
b) What is the length of the longest last name? 9   Amaquelin
*/


*4 What would go wrong with this?;

 DATA Week5.Super;
	INFILE "C:\Users\nicot\Desktop\Activity5\super.txt" FIRSTOBS = 1 DELIMITER = " " ;
	INPUT FirstName $ LastName $;
RUN;

*/ The first name Jeanne-Marie and last name Amaquelin are not complete with only a $, we need to change it to increase the character;

*5) Edit The Data steps above so it'll be fix and print it out;
 DATA Week5.Super;
	INFILE "C:\Users\nicot\Desktop\Activity5\super.txt" FIRSTOBS = 1 DELIMITER = " " ;
	INPUT FirstName : $12. LastName : $9.;
RUN;


PROC PRINT DATA = Week5.Super;
RUN;


/*6. The data set superPlus.txt has 3 additional variables, Dept, DayOff and TimeIn. In the comments,
answer the following.
a) What appears to be the format of the “DayOff” variable? It's a date and in the form of ddmmyyyy without slash or dash inbetween 
b) What appears to be the format of the “TimeIn” variable? It's a time and in the form of 00:00 to 24:00 hours
*/

/*7. Create a new data step to read in the superPlus.txt data set. You’ll need to modify the INPUT statement
accordingly. Notice the variable names in the file. (HINT: use DDMMYYw. and TIMEw. informats –
see SAS help if needed.) Print this data set to the output window - note that SAS stores the dates and
times as integers.*/

DATA Week5.SuperPlus;
	INFILE "C:\Users\nicot\Desktop\Activity5\superPlus.txt" FIRSTOBS = 2 DELIMITER = " " ;
	INPUT FirstName : $12. LastName : $9. Dept : $ DayOff : ddmmyy8. TimeIn : TIME10.;
RUN;

PROC PRINT DATA = Week5.SuperPlus;
	FORMAT DayOff ddmmyy8. TimeIn TIME10.;
RUN;
