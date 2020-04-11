library(dplyr)

# This does not quite follow the order in the description but achieves the
# same result (e.g. merging at the end made more sense in my thought process)

# Paths to files
datasetPath <- './Dataset/'
activityLabelsPath <- file.path(datasetPath, 'activity_labels.txt')

# Load features
featuresPath <- file.path(datasetPath, 'features.txt')
features <- tbl_df(read.csv(file=featuresPath, sep=' ', header=FALSE, col.names=c("featureid", "feature")))

# Load the activity labels
activities <- tbl_df(read.csv(file=activityLabelsPath, sep=' ', header=FALSE, col.names=c("activityid", "activity")))

####################
##### Training set #####
####################

# Load subjects
trainSubjectsPath <- file.path(datasetPath, 'train/subject_train.txt')
trainSubjects <- tbl_df(read.csv(trainSubjectsPath, sep=' ', header=FALSE, col.names=c("subject")))

# Load set
trainSetPath <- file.path(datasetPath, 'train/X_train.txt')
## Step 4 (column names from the features)
trainSet <- tbl_df(read.fwf(trainSetPath, widths=rep(16, 561), header=FALSE, col.names=features$feature))

# Step 2: Extract means and standard deviations
trainSet <- select(trainSet, grep('std|[Mm]ean', colnames(trainSet)))

# Load labels
trainLabelsPath <- file.path(datasetPath, 'train/y_train.txt')
trainLabels <- tbl_df(read.csv(trainLabelsPath, header=FALSE, col.names=c("activityid"))) %>% full_join(activities)

# Step 3 (use the activity labels)
# Add the subject, activity features
trainFull <- mutate(trainSet, subject=trainSubjects$subject, activity=trainLabels$activity)

####################
##### Test set #####
####################

# Load subjects
testSubjectsPath <- file.path(datasetPath, 'test/subject_test.txt')
testSubjects <- tbl_df(read.csv(testSubjectsPath, sep=' ', header=FALSE, col.names=c("subject")))

# Load set
testSetPath <- file.path(datasetPath, 'test/X_test.txt')
## Step 4 (column names from the features)
testSet <- tbl_df(read.fwf(testSetPath, widths=rep(16, 561), header=FALSE, col.names=features$feature))

# Step 2: Extract means and standard deviations
testSet <- select(testSet, grep('std|[Mm]ean', colnames(testSet)))

# Load labels
testLabelsPath <- file.path(datasetPath, 'test/y_test.txt')
testLabels <- tbl_df(read.csv(testLabelsPath, header=FALSE, col.names=c("activityid"))) %>% full_join(activities)

# Step 3 (use the activity labels)
# Add the subject, activity features
testFull <- mutate(testSet, subject=testSubjects$subject, activity=testLabels$activity)

# Step 1
# 'Merge' the test and train sets into one
full <- bind_rows(trainFull, testFull)


####################
##### Step 5   #####
####################

# group by activities and subjects
groups <- group_by(full, activity, subject)

# get the means 
s <- summarize_all(groups, mean)
