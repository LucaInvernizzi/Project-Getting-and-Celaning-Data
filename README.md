# Project-Getting-and-Cleaning-Data

The different steps to get to the final tidi_df file were as follow

1) Loaded set, labels and subjects for both train set and test set into data frame
2) Assigned the variable name from feature file to the dataframes
3) cbinded the test set and the train set df with their respective labels and subject df
4) cbinded train and test df using the ID coloumn
5) corrected a problem with the name of the variables
6) extracted coloumn containing the mean and the standard deviation
7) assigned a descriptive name to the activity
8) constructed the final tidy dataframe
9) created the txt file from the dataframe

The variable in the final dataframe are:
- the subject bnumber
- the activity name
- the mean of all the variable, in the 3 spacial direction x/y/z
