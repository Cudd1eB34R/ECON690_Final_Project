* packages
ssc install xttest3
ssc install outreg2

* set panel data
xtset State Year

* visualize murder rates
xtline Murders_r, overlay

* Heterogeneity across States
bysort State: egen murder_mean = mean(Murders_r)
twoway scatter Murders_r State, msymbol(circle_hollow) || connected murder_mean State, msymbol(diamond)

* Heterogeneity across Years
bysort Year: egen murder_mean2 = mean(Murders_r)
twoway scatter Murders_r Year, msymbol(circle_hollow) || connected murder_mean2 Year, msymbol(diamond)

* OLS Model
regress Murders_r FSS FSS_t MSA_r lMedInc UR, robust
outreg2 using final, tex replace

* FE Model
xtreg Murders_r FSS FSS_t MSA_r lMedInc UR, fe
outreg2 using final, tex append ctitle(Fixed Effects)
estimates store fixed

* RE Model
xtreg Murders_r FSS FSS_t MSA_r lMedInc UR, re
outreg2 using final, tex append ctitle(Random Effects)
estimates store random

* Hausman Test
hausman fixed random

* Heteroskedasticity in FE Model
xtreg Murders_r FSS FSS_t MSA_r lMedInc UR, fe
xttreg3

* FE Robust Model
xtreg Murders_r FSS FSS_t MSA_r lMedInc UR, fe robust
outreg2 using final, tex append ctitle(Fixed Effects (Robust))
