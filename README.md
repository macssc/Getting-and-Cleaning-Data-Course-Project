# Getting and Cleaning Data Course Project

My implementation of the project is included into a single R source file
named 'run_analysis.R'.  For simplicity the data set folder was renamed 
to 'Dataset' but was otherwise unchanged.

The script can be divided into 5 main parts:

- The first loads the common data for both the training and testing sets.  More precisely it loads the features and activities.
- The second step loads the training set, assigns descriptive activity and variable names (using the previously loaded data) and extracts the mean and standard deviation measurements
- The third step repeats the second with the test set
- The fourth step merges the the test and train sets into a single table named 'full'
- The fifth steps creates another table, named 's', containing the averages of each variable for each activity and subject


## Prerequisite

The script requires the 'dplyr' package which can be installed 
by executing the following within the R console
```
install.packages('dplyr')
```

## Running

From the R console:
```
source('run_analysis.R')
```

The variable 'full' will contain the result from steps 1 through 4 and the
variable 's' will contain the result from step 5
