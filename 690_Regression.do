* Pooled OLS Regression
regress Murders_r Murders_r_lag FSS FSS_t MSA_r lMedInc UR t1 t2 t3 t4 t5 t6

* Fixed Effects Model
xtreg Murders_r Murders_r_lag FSS FSS_t MSA_r lMedInc UR t1 t2 t3 t4 t5 t6, fe robust

* Random Effects Model
xtreg Murders_r Murders_r_lag FSS FSS_t MSA_r lMedInc UR t1 t2 t3 t4 t5 t6, re robust
