/*********************************************
**Pre-Class Activity 5 Nico Tio
**ST 307
*********************************************/

*For this activity, you should download the data file for the assigment and place it in a folder you will use as a library.;  

*Description of the data:
The data give observations on prospective employees for a company.;

*1. Create a SAS library called ST307 that contains the data file;

LIBNAME ST307 "C:\Users\nicot\Desktop\MyData";


*2. Read the raw data into SAS with a data step. Things to be sure about - 
							Read in ID and Group as character (in addition to FName and Lname, standard $ will work) 
							Read in the full first name ($w informat)
							Read the Bday as a date variable (mmddyy informat)
							Read in BiWkSal as numeric (comma informat);


DATA ST307.Employee;
	INFILE "C:\Users\nicot\Desktop\MyData\employee.txt" FIRSTOBS = 2 DELIMITER = "?" ;
	INPUT ID $  FirstName : $12. LastName $ Group $ HT WT DOB : mmddyy8. BiWkSal : comma5. ;
RUN;
