**** Robert Ackerman *****************************************************************************
**** HW2: Berry (1994) Estimating discrete-choice models of product differentiation, *************
**** RAND Jounal of Economics Vol. 25, No. 2, Summer 1994 ****************************************

**** Initial Settings ****
clear
clear matrix
capture cd "/Users/robertackerman/Desktop/Dropbox"
log using "HW2_Ackerman.log", replace

set more off
pause on 

**** Load, re-name and re-shape data   ****
import delimited "/Users/robertackerman/Documents/MATLAB/STATA_data.csv", case(upper) 

rename (V1 V2 V3 V4 V5 V6 V7) (M J X W P Q S0)
gen S = Q/1000000
gen logS = log(S/S0)
xtset J M


**** OLS  Estimates ****
xtreg logS X P, vce(robust)

**** 2SLS  Estimates ****
xtivreg logS X (P = W) 


log close
