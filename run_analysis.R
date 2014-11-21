library(data.table)

dir="./UCI HAR Dataset/"

trainX="train/X_train.txt"
trainY="train/Y_train.txt"
trainS="train/subject_train.txt"

testX ="test/X_test.txt"
testY ="test/Y_test.txt"
testS ="test/subject_test.txt"

filterAndAdd<-function(x=data.frame(), filterCols = 1, type="noType", activity, subject){
  ##filter train by filterCols 
  x<-x[filterCols]
  ##adding type
  x["type"]<-type
  ##adding activity
  x["activity"]=activity
  ##adding subject
  x["subject"]=subject
  x
}

go<-function(){
  ## reading headers
  headers<-read.csv(paste(dir, "features.txt", sep = ""),header = FALSE, sep = " ")

  ##subseting only mean() and std()
  goodcols<-grep("(mean\\(\\))|(std\\(\\))", headers[,2])
  goodcolsnames<-headers$V2[goodcols]

  ##reading data train
  file<-paste(dir, trainX, sep="")
  datatrain<-read.table(file, header = FALSE, col.names = headers[,2], colClasses = rep("numeric", 561))

  ##reading data train activities
  datatrainActivities<-named(readFile(trainY))
	
  ##reading test subjects
  datatrainSubjects<-readFile(trainS)

  ##filterAndAdd datatrain
  datatrain<-filterAndAdd(datatrain, goodcols, "train", datatrainActivities, datatrainSubjects)

  ##reading test
  file<-paste(dir, testX, sep="")
  datatest<-read.table(file, header = FALSE, col.names = headers[,2], colClasses = rep("numeric", 561))

  ##reading data test activities
  datatestActivities<-named(readFile(testY))

  ##reading test subjects
  datatestSubjects<-readFile(testS)
	
  ##filterAndAdd datatest
  datatest<-filterAndAdd(datatest, goodcols, "test", datatestActivities, datatestSubjects)


  ##filter by goodcols
  data<-rbind(datatrain, datatest)

  ##Splitting
  sdata<-split(data, list(data$subject, data$activity))

  ##...and finally, colMeans
  tidydata <- sapply(sdata, function(x) colMeans(x[, gsub("\\(|\\)|-", ".", goodcolsnames)]))	

  ##write data
  write.table(tidydata, "tidydata.txt", row.name=FALSE )
  
  tidydata 
}

readFile<-function(file){
  ##reading file for activities and subjects
  file<-paste(dir, file, sep="")
  read.table(file, header = FALSE)
}



named<-function(x){
  names<-c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
  x["xx"]<-names[x$V1]
  x["xx"]
}


