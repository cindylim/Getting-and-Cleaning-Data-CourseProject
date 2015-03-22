#Set working directory
rm(list=ls())
setwd("C:/Users/Home/Desktop/Coursera/3. Getting and Cleaning Data/Project/UCI HAR Dataset/")


#Read test and training data into R
test.data<-read.table("test/X_test.txt",header=FALSE)
train.data<-read.table("train/X_train.txt",header=FALSE)


#Merge training and test data sets
merge.data<-rbind(test.data,train.data)


#Read features into R
features<-read.table("features.txt",header=FALSE)


#Assign features as variable names to merged data set
colnames(merge.data)<-features$V2


#Extract measurements on the mean and standard deviation for each measurement
subset.data<-merge.data[,grepl("mean",names(merge.data)) | grepl("std",names(merge.data))]


#Read identifiers of test and training data into R
test.identifier<-read.table("test/subject_test.txt",header=FALSE)
train.identifier<-read.table("train/subject_train.txt",header=FALSE)


#Create one identifier for the merged data set
merge.identifier<-rbind(test.identifier,train.identifier)
names(merge.identifier)<-c("SubjectID")


#Read activity labels into R
activity_labels<-read.table("activity_labels.txt",header=FALSE)


#Read test and training data labels into R
test.labels<-read.table("test/y_test.txt",header=FALSE)
train.labels<-read.table("train/y_train.txt",header=FALSE)


#Create one vector of labels for the merged data set
merge.labels<-rbind(test.labels,train.labels)
names(merge.labels)<-c("ActivityClass")


#Create a column for activity description to correspond to activity labels
merge.labels<-data.frame(merge.labels)
merge.labels$Activity<-NA
merge.labels$Activity<-ifelse(merge.labels$ActivityClass==1,as.character(activity_labels$V2[1]),merge.labels$Activity)
merge.labels$Activity<-ifelse(merge.labels$ActivityClass==2,as.character(activity_labels$V2[2]),merge.labels$Activity)
merge.labels$Activity<-ifelse(merge.labels$ActivityClass==3,as.character(activity_labels$V2[3]),merge.labels$Activity)
merge.labels$Activity<-ifelse(merge.labels$ActivityClass==4,as.character(activity_labels$V2[4]),merge.labels$Activity)
merge.labels$Activity<-ifelse(merge.labels$ActivityClass==5,as.character(activity_labels$V2[5]),merge.labels$Activity)
merge.labels$Activity<-ifelse(merge.labels$ActivityClass==6,as.character(activity_labels$V2[6]),merge.labels$Activity)


#Include identifier and labels into data set with columns on mean and standard deviation
subset.data2<-cbind(merge.identifier,merge.labels,subset.data)


#Create a second independent data set with average of each variable for each activity for each subject
tidy.data<-numeric(0)

for(i in 1:length(unique(subset.data2$SubjectID)))
{
	subject<-subset(subset.data2,subset.data2$SubjectID==i)
	activity.mean.data<-numeric(0)

	for(j in 1:length(unique(subset.data2$ActivityClass)))
		{
			activity<-subset(subject,subject$ActivityClass==j)
			activity.use<-activity[,-c(1,2,3)]
			activity.mean<-colMeans(activity.use)
			activity.mean.data<-rbind(activity.mean.data,activity.mean)
			rownames(activity.mean.data)<-NULL			
		}
	subjectID<-rep(i,6)
	activityType<-seq(1,6,1)
	activityTypeDescription<-as.character(activity_labels$V2)
	activity.mean.labelled<-cbind(subjectID,activityType,activityTypeDescription,data.frame(activity.mean.data))
	
	tidy.data<-rbind(tidy.data,activity.mean.labelled)
}
names(tidy.data)<-names(subset.data2)


#Output the tidy data set for submission
write.table(tidy.data,"tidy.data.txt",row.names=FALSE,sep=",")