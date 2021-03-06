# ECON690_Final_Project
Data is collected for each of the 50 states over a 7 year period.

## Raw Data Files
Each segment includes a short explaination about the data and the files corresponding to it.

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

### Firearm Laws (State Firearm Laws) (UNUSED)
Data is collected for all 50 states over 7 years.  There are several laws to choose from.  For now I'll focus on the top few that other sources attribute to gun violence.

gun_laws.csv

### Age/Race/Gender (IPUMS) (UNUSED)
There's too much data to fit on a csv file.  I'm trying to find a work around right now (if time permits).

usa_00007.csv

### Party Strength (Wikipedia) (UNUSED)
Dataset scraped from Wikipedia and formatted before submission to Kaggle and Github.  Unfortunately, the data has only been updated to 2015.  Fortunately, the Python code used to clean the data is available on Github (https://github.com/kiwiPhrases/state_party_strength) and can be utilized to update the process.  Unfortunately, I don't know enough Python to do this myself.

states_party_strength_cleaned.csv

## Data Cleaning and Variable Generation
Time dummies, Lag * FSS, One-Year Lag of Murders, and log(income) are generated.  Test OLS regressions and VIF factors are checked.  A .dta file is outputted for Stata usage (master.dta) because I don't know how to regress panel data in R just yet.

## Papers
Here's a small collection of papers I've read and will include in my research.  They're in .bib format so I can easily include them in my LaTeX documents.

### The National Incident-Based Reporting System: Research and Policy Applications
@article{maxfield1999national,
  title={The national incident-based reporting system: Research and policy applications},
  author={Maxfield, Michael G},
  journal={Journal of Quantitative Criminology},
  volume={15},
  number={2},
  pages={119--149},
  year={1999},
  publisher={Springer}
}

### State and Local Prevalence of Firearms Ownership Measurement, Structure, and Trends
@article{azrael2004state,
  title={State and local prevalence of firearms ownership measurement, structure, and trends},
  author={Azrael, Deborah and Cook, Philip J and Miller, Matthew},
  journal={Journal of Quantitative Criminology},
  volume={20},
  number={1},
  pages={43--62},
  year={2004},
  publisher={Springer}
}

### The Social Costs of Gun Ownership
@article{cook2006social,
  title={The social costs of gun ownership},
  author={Cook, Philip J and Ludwig, Jens},
  journal={Journal of Public Economics},
  volume={90},
  number={1-2},
  pages={379--391},
  year={2006},
  publisher={Elsevier}
}

### Public Opinion on Proposals to Strengthen U.S. Gun Laws (UNUSED)
@article{mcginty2013public,
  title={Public opinion on proposals to strengthen US gun laws},
  author={McGinty, Emma E and Webster, Daniel W and Vernick, Jon S and Barry, Colleen L},
  journal={REDUCING GUN VIOLENCE},
  pages={239},
  year={2013}
}
