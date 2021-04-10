ods _all_ close;    *ODS stands for 'output delivery system';
ods listing;


*NOTE: set the libname below to the appropriate folderfor your data;
*libname home 'c:\Jason';
libname home 'C:\Users\Jim\Desktop\405';


data one (drop=date);
set home.FF_Daily_Factors_1990_2020;
year =year(date);
month=month(date);
day=day(date);
run;

data two (drop=date);
set home.Stock_Data_1990_2019; *This dataset holds the daily returns to 3 permnos - 10107, 12060, 12282;
year =year(date);
month=month(date);
day=day(date);
run;

proc sort data=one;  
by year month day;*By default, sorts are increasing. If you want a variable sorted in a decreasing manner, precede it with a DESCENDING statement ;
run;

proc sort data=two;
by year month day permno;
run;

data full;
merge two(in=x) one; *The "in=" statement creates a temporary variable equal to 1 if the observation is in the data set, and 0 otherwise.;
by year month day;

*if permno ne 10107 then delete; *drops observations that don't have permno = 10107;
if x ne 1 then delete;
ex_ret=ret-rf;
run;


proc sort data=full;
by permno year month;
run;


proc reg data=full outest=capm_params;
by permno;
model ex_ret = mktrf;
run;
quit;



proc reg data=full outest=capm_params_monthly noprint; * rsquare tableout noprint;
by permno year month;
model ex_ret = mktrf;
output out=full_with_predictions p=sys_ret r=iret;
run;
quit;


proc reg data=full outest=ff_params; * tableout;
by permno;
model ex_ret = mktrf hml smb;
run;



proc means data=full;
by permno;
var ret;
output out=sample_statistics;
run;

proc univariate data=full;
by permno;
var ret;
output out=deciles pctlpre=r pctlpts=10 20 30 40 50 60 70 80 90 100;
run;

proc means data=full_with_predictions;
by permno;
var ret sys_ret iret;
output out=return_look;
run;


