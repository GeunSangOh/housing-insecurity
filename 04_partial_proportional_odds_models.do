* gologit2 needs to be installed
* findit gologit2

* Independent variables
global varlist BLACK ASIAN OTHER_RACE LATIN NON_US_CITIZEN /* 
			*/ HH_AGE /* 
			*/ MALE UNDSCHOOL HIGHSCHOOL BACHELOR MASTER MARRIED SEPARATED /*  
			*/ STAY_5_10 STAY_10_MORE YNGKIDS SENIORS DISABLED NUM_MEMBERS /* 
			*/ HOUSE_AGE ONE_FAMILY_HOUSE MOBILE_HOUSE /*    
			*/ NOGOODSCHOOL NOGOODPTRNS HIGH_PCRIME HIGH_SCRIME HIGH_RISK /*
			*/ RENT_CONTROL HUD_HOU HUD_HCV /* 
			*/ DIV4_1 DIV4_2 DIV4_4 

* Very low-income group model
import delimited ".\temp\Xy_df1.csv", case(upper) clear
gologit2 COMPOSITE_HI2 $varlist, autofit(0.01) gamma 
gologit2, or gamma
gologit2 COMPOSITE_HI2

* Low-income group model
import delimited ".\temp\Xy_df2.csv", case(upper) clear
gologit2 COMPOSITE_HI2 $varlist, autofit(0.01) gamma 
gologit2, or gamma
gologit2 COMPOSITE_HI2

* Modest-income group model
import delimited ".\temp\Xy_df3.csv", case(upper) clear
replace COMPOSITE_HI2 = 2 if COMPOSITE_HI2 == 3
gologit2 COMPOSITE_HI2 $varlist, autofit(0.01) gamma 
gologit2, or gamma
gologit2 COMPOSITE_HI2 

* Higher-income group model
import delimited ".\temp\Xy_df4.csv", case(upper) clear
replace COMPOSITE_HI2 = 2 if COMPOSITE_HI2 == 3
gologit2 COMPOSITE_HI2 $varlist, autofit(0.01) gamma 
gologit2, or gamma
gologit2 COMPOSITE_HI2 