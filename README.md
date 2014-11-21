tidydata
========

Coursera Project Cleaning data course

#How script works

You must use source("run_analysis.R") and then call go() function.

Script is divided in several functions. Before functions, there are variables with the names of the dir and files. 

Function 'filterAndAdd' filters the data loaded by the cols sent by filterCols, adds a col "type" (train or test), and adds cols activity and subject.

Function 'go' is the main function. Loads and filter headers, train and test data, activities and subjects, change name activities, join test and train data and split and resume data. Finally it writes data to disk and return tidy data.

Function readFile is used to read activities and subjects.

And function named changes activities' names.

