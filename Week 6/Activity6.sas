/*********************************************
**NICO TIO
**Pre-Class Activity 6
**ST 307
*********************************************/

*1. Create a library called Topic6;

LIBNAME Topic6 "C:\Users\nicot\Desktop\Week6";


/*2. Load Data superPlus and store it in library Topic6, using appropriate informats (See last week).
- Print the dataset with an appropriate procedure and check the output.
- In the comments, answer the following:
a) What are the variable types and lengths (HINT: PROC CONTENTS may help)
	-Variable types:  Numeric and Characters
    -The largest length for numeric type is 8
	-THe largest length for characters type is 12
b) Also state what the '10' following ddmmyy indicates?
	-Specifies the width of the input field
c) What would happen if the ':' was not included after the variables
	-It would read the data set and record all the data until the all memory in the variable space is filled, ignoring delimiters
*/

DATA Topic6.SuperPlus;
	INFILE "C:\Users\nicot\Desktop\Week6\superPlus.txt" FIRSTOBS = 2 DELIMITER = " " ;
	INPUT FirstName : $12. LastName : $9. Dept : $ DayOff : ddmmyy8. TimeIn : TIME10.;
RUN;

PROC PRINT DATA = Topic6.SuperPlus;
RUN;

/*3. Create a new temporary data set called superFormat from superPlus (HINT: use a SET statement).
a) Format the variables DayOff to list the 3-letter-month-abbreviation, 2-digit-day and 4-digityear.
b) Format the variable TimeIn to display HH:MM
c) Print the data set;
d) In the comments, state whether or not the new date format specification changes the actual
class of the variable 
	-The new date format specification doesn't change the actual class of the variable, Only the format.
*/

DATA superFormat;
	SET Topic6.SuperPlus;
	FORMAT DayOff : date9. TimeIn : HHMM.;
RUN;


/*4. Modify superFormat to include the following variable labels:
- 'First Name', 'Last Name', 'Department', 'Day Off', 'Start Time’
- Use a PROC PRINT step so that the variable labels above are displayed in the output.
- Do not include the observation numbers (RECALL: NOOBS);
(HINT: in order to print the labels you will need to specify an option in the PROC PRINT step)*/

DATA superFormat;
	SET Topic6.SuperPlus;
	FORMAT DayOff : date9. TimeIn : HHMM.;
	LABEL First = "First Name"
		  Last = "Last Name"
		  Dept = "Department"
		  DayOff = "Day Off"
		  TimeIn = "Start Time";
PROC PRINT NOOBS DATA = superFormat LABEL;
RUN;

/*5. Create a dataset superFormula from SET superFormat and store it in library Topic6.
 In this data set:
a) Change the format of DayOff to display two-digit-day, 3-letter-month-abbreviation, and 2-
digit-year with no spaces.
b) Create a new variable called "DaysLeft" that counts the number of days left until each person's
day off (HINT: use the today() function and subtract it from the appropriate variable).
c) Add the label "Days Until Vacation" to the new variable "DaysLeft".
d) Print the data set displaying the labels without displaying observation numbers. */

DATA Topic6.superFormula;
	SET work.superFormat;
	FORMAT DayOff : DATE7.;
	DaysLeft = DayOff - today();
PROC PRINT NOOBS DATA = Topic6.superFormula;
RUN;

/*6. Super Folk earn $20/day for their services. The Department director wants to know how much money
each person will get paid until his/her day off.
a) Create a new temporary dataset called superCalc with a variable called 'Wages' that displays
this amount.
b) Format 'Wages' so that a dollar sign and comma appear in the output.
c) In the comments, list the formula used for your calculation.
	DaysLeft * 20 = Wages
d) Print out ONLY the Wages variable displaying the proper format */

DATA superCalc;
	SET Topic6.superFormula;
	Wages = DaysLeft * 20;
	FORMAT Wages : dollar6.;

PROC PRINT DATA = superCalc;
	VAR Wages;
RUN;
