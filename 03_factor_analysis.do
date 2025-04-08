* Load data
import delimited ".\temp\fa_df.csv", case(preserve) clear

* Tetrachoric matrix
tetrachoric HI_EVICT_RISK1 HI_EVICT_THREAT HI_RENT13 HI_UTIL1 /*
*/ HI_ADEQ_SEV HI_UPK3 HI_BADHOME4 /*
*/ HI_RIR50 HI_POVERTY133, posdef

global N = r(N)
matrix C = r(Rho)
matrix symeigen eigenvectors eigenvalues = C
matrix list C
matrix list eigenvalues

* Factor analysis
factormat C, n($N) factor(3) 

* Rotation
rotate, oblimin oblique normalize
estat common

* Save eigenvalues
matrix eig = eigenvalues
clear
set obs 9
gen eigenvalue = .
replace eigenvalue = eig[1, 1] in 1
replace eigenvalue = eig[1, 2] in 2
replace eigenvalue = eig[1, 3] in 3
replace eigenvalue = eig[1, 4] in 4
replace eigenvalue = eig[1, 5] in 5
replace eigenvalue = eig[1, 6] in 6
replace eigenvalue = eig[1, 7] in 7
replace eigenvalue = eig[1, 8] in 8
replace eigenvalue = eig[1, 9] in 9

gen factor = _n

* Scree plot
twoway (line eigenvalue factor, sort lcolor("203 111 24") lwidth(medium)) ///
       (scatter eigenvalue factor, msymbol(circle) mcolor("203 111 24") msize(medium)), ///
		title("Scree Plot") xtitle("Factor Number") ytitle("Eigenvalue") ///
		ylabel(, angle(horizontal)) xlabel(1(1)9) ///
		graphregion(color(white)) bgcolor(white) ///
		legend(off) ///
		yline(1, lcolor("blue") lwidth(medium) lstyle(solid)) 