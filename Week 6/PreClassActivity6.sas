/*********************************************
**NICO TIO
**Pre-Class Activity 6
**ST 307
*********************************************/

*For this activity, you should download the data file for the assigment and place it in a folder you will use as a library.;  

*Description of the data:
The data give observations on prospective employees for a company.;

*1. Create a SAS library called ST307 that contains the data file;
LIBNAME ST307 "C:\Users\nicot\Desktop\Week6";


*2. Use the DATA step below to read the data set in;
DATA ST307.employee;
	INFILE "C:\Users\nicot\Desktop\Week6\employee.txt" FIRSTOBS=2 DELIMITER="?";
	INPUT ID $ FName : $11. LName $ Group $ HT WT BDay : mmddyy8. BiWkSal : Comma5.;
RUN;

*Create a copy of this data set in the work library that also has the following:
Labels for ID (Employee ID), HT (Height), WT (Weight)
Formats for BiWkSal (display with a comma), Bday (display in day-day-month-month-year-year-year-year);

DATA ST307.employee;
	INFILE "C:\Users\nicot\Desktop\Week6\employee.txt" FIRSTOBS=2 DELIMITER="?";
	INPUT ID $ FName : $11. LName $ Group $ HT WT BDay : mmddyy8. BiWkSal : Comma5.;
	FORMAT BDay ddmmyy10. BiWkSal comma5.;
	LABEL ID="Employee ID"	      
		  HT="Height"
		  WT="Weight";
RUN;


