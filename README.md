# Getting-and-Cleaning-Data-CourseProject

1. Download the zip file and extract the data files onto the computer

2. Set working directory in R to the directory where the data has been extracted to

3. Use read.table() to load the training and test data sets into R, assigning them to train.data and test.data respectively

4. Merge the training and test data sets using rbind(), assigning it to merge.data

5. Use read.table() to load the feature data set into R, assigning it to feature.data

6. Assign feature.data as variable names to merge.data obtained in step 4

7. Select columns with the mean and standard deviation of measurements (including mean frequency) using the grepl function and assign to subset.data

8. Use read.table() to load the identifiers of the subjects from the training and test data sets into R, assigning them to train.identifier and test.identifier respectively

9. Merge the identifiers obtained in step 8 using rbind(), using the same order as in step 4, and assign to merge.identifier

10. Use read.table() to load the activity labels into R, assigning it to activity_labels

11. Use read.table() to load the test and training data set labels into R, assigning them to test.labels and train.labels respectively

12. Merge the labels obtained in step 11 using rbind(), using the same order as in steps 4 and 8, and assign to merge.labels

13. Create a vector to contain the description of the activity carried out, corresponding to the values for the various activities in merge.labels obtained in step 13

14. Include subject identifiers and activity labels into the subset of data obtained in step 7, using cbind() to bind merge.identifier, merge.labels to subset.data

15. To create a tidy data set containing the average of each variable for each activity and each subject, a loop function was created to
	a. first subset the observation for each subject,
	b. and for each subject, the mean of the variable for each activity was computed
	c. These means were then appended one after the other, ordered by subject and activity, to create the tidy data set

16. The final tidy data set was then output into the working directory



