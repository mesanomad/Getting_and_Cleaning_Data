# Getting_and_Cleaning_Data

Section 1: all necessary files read into R

Section 2: "Activity" and "Subject" column names created for the original test and train data

Section 3: Removed the V1 column from the features dataframe and then inserted rows for Subject, Activity, and Group.  I added Group columns to the datasets to identify test vs. train.  Wasn't sure at the time if i would need it or not.

Section 4: Combined all the dataframes together, added a "Group" column thinking I'd need it later, and ordered the columns.

Section 5: Had to complete these steps due to the duplicate columns error.  Seemed to be the only way I could select the "mean" and "std" columns.

Section 6: Assigned the activity labels to values

Section 7: Melted, casted, and merged data to finally look tidy!!!!!!!!!!!
