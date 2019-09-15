/*Nico Tio	Project 1
*Partners: Marc Navia 3, Mia Freeland 3, Liam Wall 3
*/

/*1. Create a library called Project1 where you are going to read the blood.txt from and
save the output data sets to.*/

LIBNAME Project1 "C:\Users\nicot\Desktop\SASProject";

*2. Read in the file blood.txt and save it as a SAS data set called Blood in the Project1 library.;

DATA Project1.Blood;
	INFILE "C:\Users\nicot\Desktop\SASProject\blood.txt" FIRSTOBS = 1 DELIMITER = " " ;
	INPUT Subject Gender $ BloodType $ AgeGroup $ WBC RBC Chol;
RUN;

/*3 You are interested in WBC count, since it is an important indicator of the health of the
immune system. Write a SAS step and answer the following questions in the comment:
a. What is the largest WBC count in the sample? What about the smallest? Which
subjects have them? 
10550 = HIGHEST WBC  SUBJECT 937
4070 = LOWEST WBC  SUBJECT 4070
b. What is the standard deviation of the sample WBC count? 
STDEV = 1003
*/
PROC UNIVARIATE DATA=Project1.Blood;
	VAR WBC;
RUN;

/*4. Create a histogram for the WBC variable using PROC SGPLOT. Add some statements
and/or options to meet the following requirements:

a. Instead of percentages, make the vertical axis show the values as proportions (0.0
to 1.0) of the total.

b. Add two density curves to the histogram, a normal one and a kernel one.

c. Change the line type of the kernel density curve to dash dot line.

d. Move the legend of the density curves inside the plot on the top right corner.(Hint:
you may find the KEYLEGEND statement useful)
*/

PROC SGPLOT DATA = Project1.blood;
	HISTOGRAM WBC / SCALE = Proportion;
	DENSITY WBC;
	DENSITY WBC / TYPE = kernel LINEATTRS = (PATTERN = shortdashdot);
	KEYLEGEND / LOCATION = inside POSITION = topright;
	
RUN;


 /*
5. Create a scatter plot for WBC against RBC. (WBC on the y axis and RBC one the x axis).
a. Instead of small circles as markers, make the markers show the blood type of the
subject.
b. Give different color to subjects from different age groups.
*/

PROC SGPLOT DATA = Project1.blood;
	SCATTER X = RBC Y = WBC / MARKERCHAR = BloodType GROUP = AgeGroup ;
RUN;

/* 6. a. Create a one-way frequency table for the blood type and save this table as a
permanent data set file called BloodTypeFreq in your Project1 folder.
 
b. Create a two-way frequency table for blood type and age group, but suppress the
display of frequencies.

c. Answer in the comment: what would we do to save the data set in part a as
temporary?  Save it at the work folder b/c that's the temporary folder
*/

PROC FREQ DATA = Project1.blood;
	TABLES BloodType / OUT = Project1.BloodTypeFreq;
RUN;

PROC FREQ DATA = Project1.blood;
	TABLES  BloodType*AgeGroup / NOFREQ; 
RUN;


/*7. Create a horizontal box plot for RBC for each blood type. Add some options to meet
the following requirements:
a. Use blood type as a category variable, so that a box plot is created for each distinct
blood type.
b. Make the marker for the mean a red filled diamond.
c. Make the marker for the median a black line and a little thicker than default.
d. Make the box outline and the whiskers of the same thickness as the median line.
After these settings, you would like to see plot like this:
*/

PROC SGPLOT DATA = Project1.blood;
	HBOX RBC / CATEGORY = BloodType MEANATTRS = (Color = Red Symbol = DiamondFilled)
	MEDIANATTRS = (Color = Black Thickness = 3) LINEATTRS =  (Thickness = 3) 
	WHISKERATTRS = (Thickness = 3);
RUN;
