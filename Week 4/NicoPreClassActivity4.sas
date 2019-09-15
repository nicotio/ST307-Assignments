/*********************************************
**Pre-Class Activity 4 NICO TIO
**St 307
*********************************************/

*For this activity, you should download the SAS data file (pulsedata.sas7bdat) and the data set (repair.txt, an & delimited file)
for the assigment and place them in a folder you will use as a library.;  
*As this the pulsedata.sas7bdat is a SAS data set, once you create a library that contains it you won't need a data step to read it in.;
*You will need a data step to read in the repair.txt file.;

*1. Create a SAS library called ST307 that contains the data files;

LIBNAME ST307 "C:\Users\nicot\Desktop\MyData";

*2. Print out the pulsedata data set using the PROC PRINT procedure;

PROC PRINT DATA = ST307.Pulsedata;
RUN;

*3. Read the repair.txt data set into the working directory.  Call the data set repair.;

DATA ST307.repair;
	INFILE "C:\Users\nicot\Desktop\MyData\repair.txt" FIRSTOBS = 2 "&";
	INPUT SCORE $ SCORE2 $;
RUN;

*4. Print out the repair data set.;

PROC PRINT DATA = ST307.repair;
RUN;
