* Pooled OLS Regression
regress Murders_r FSS FSS_t MSA_r lMedInc UR

* Fixed Effects Model
xtreg Murders_r FSS FSS_t MSA_r lMedInc UR, fe robust

* Random Effects Model
xtreg Murders_r FSS FSS_t MSA_r lMedInc UR, re robust
