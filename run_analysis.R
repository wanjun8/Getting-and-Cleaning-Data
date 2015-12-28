TrainSet<-read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
TestSet<-read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)

## Merges the training and the test sets to create one data set
Data<-rbind(TrainSet,TestSet)

## Extracts only the measurements on the mean and sd for each measurement
features<-read.table("./UCI HAR Dataset/features.txt",header=FALSE)
features$id<-grepl("mean",features[,2]) | grepl("std",features[,2])
Measurement<-features$V2[features$id]

## Uses descriptive activity names to name the activities in the data set
Train_labels<-read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
Test_labels<-read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
act_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
act_labels<-as.character(act_labels$V2)
Labels<-rbind(Train_labels,Test_labels)
n=dim(Labels)[1]
for(i in 1:n){
  for(j in 1:6){
    if(Labels[i,1]==j){Labels[i,1]=act_labels[j]}
  }
}

## data set with descriptive variable names
Data$names=Labels[,1]

## independent tidy data
m=ncol(Data)
Tidy=matrix(data=NA,6,(m-1))
for(i in 1:(m-1)){
  Tidy[,i]=tapply(Data[,i],Data$names,mean)
}

write.table(Tidy,"Data.txt",row.names = FALSE)

