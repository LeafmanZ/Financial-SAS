ods _all_ close;    *ODS stands for 'output delivery system';
ods listing;


*NOTE: set the libname below to the appropriate folder for your data;

libname home 'C:\Users\Jim\Desktop\405';


data one (drop=date);
set home.FF_Daily_Factors_1990_2020;
run;

data two (drop=date);
set home.Stock_Data_1990_2019;
run;

proc univariate data=one;
run;

proc univariate data=two;
run;
