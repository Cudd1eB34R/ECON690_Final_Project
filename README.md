# ECON690_Final_Project
Data is collected for each of the 50 states over a 7 year period.

## Raw Data Files

### Murder Ratio/MSA Ratio (FBI:UCR)
Each table contains data for all 50 states in 1 year.  Murder ratio is calculated from estimated total murders and estimated state population.  MSA ratio is calculated from estimated MSA population over estimated state population

crime2010.csv

crime2011.csv

crime2012.csv

crime2013.csv

crime2014.csv

crime2015.csv

crime2016.csv

### Unemployment Rate (FRED)
Only 12 states could be collected at a time over 7 all years.  As such, 4 time series files of 12 states and 1 time series file of 2 states were collected and merged together.

ALUR_IDUR.csv (Alabama to Idaho)

ILUR_MSUR.csv (Illinois to Mississippi)

MOUR_OKUR.csv (Missouri to Oklahoma)

ORUR_WVUR.csv (Oregon to West Virginia)

WIUR_WYUR.csv (Wisconsin to Wyoming)

### Firearm Suicide Ratio (CDC)
Data is collected for all 50 states over 7 years.  Two data sets are present for firearm related suicides and total suicides.  Firearm Suicides over Total Suicides (FSS) is calculated by dividing firearm related suicides by total suicides.

firearm_suicdes.csv

total_suicides.csv

### Median Household Income (U.S. Census Bureau)
Data is collected for all 50 states over 7 years.

income.csv

### Age/Race/Gender (IPUMS)
There's too much data to fit on a csv file.  I'm trying to find a work around right now (if time permits).

usa_00007.csv

## Data Cleaning and Variable Generation
Time dummies, Lag * FSS, One-Year Lag of Murders, and log(income) are generated.  Test OLS regressions and VIF factors are checked.  A .dta file is outputted for Stata usage.

master.dta
