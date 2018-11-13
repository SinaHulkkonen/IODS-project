#IODS exercise3, data wrangling
#Sina Hulkkonen
#13/11/2018

library(foreign)
library(dplyr)

#reading the file math & exploring its structure and dimensions
url1<-("/Users/sina/Library/Mobile Documents/com~apple~CloudDocs/tutkimus/tohtorikoulutus/GitHub/IODS-project/data")
url_math<-paste(url1,"student-mat.csv", sep = "/")
math <- read.table(url_math, sep = ";" , header=TRUE)
colnames(math)
str(math)
dim(math)

#reading the file por & exploring its structure and dimensions
url2<-("/Users/sina/Library/Mobile Documents/com~apple~CloudDocs/tutkimus/tohtorikoulutus/GitHub/IODS-project/data")
url_por<-paste(url1,"student-por.csv", sep = "/")
por <- read.table(url_por, sep = ";" , header=TRUE)
colnames(por)
str(por)
dim(por)
