*For working with PA6 DATA (It has all the quarterly S&P, Gold returns, and CAPE Data;
proc import DATAFILE = "C:\Users\Ziele\Desktop\PA6_DATA.csv"
		out = PA6_Data
		DBMS = csv REPLACE;
	GETNAMES = YES;
run;

*Part A: For 7 year ahead return vs cape;
proc reg data=PA6_Data;
model _7_yr_ret = Cape;
run;
quit;
*Part A: For 7 year ahead return vs cape and real price of gold;
proc reg data=PA6_Data;
model _7_yr_ret = Cape Gold_pr;
run;
quit;

*Part B: For 7 year ahead return of gold vs cape;
proc reg data=PA6_Data;
model _7_yr_ret_gold = Cape;
run;
quit;

*Part B: For 7 year ahead return of gold vs cape and real price of gold;
proc reg data=PA6_Data;
model _7_yr_ret_gold = Cape Gold_pr;
run;
quit;

