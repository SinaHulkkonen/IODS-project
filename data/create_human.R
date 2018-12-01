#Sina Hulkkonen
#21/11/2018
#IODS week4 exercises

#reading the files
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#explore the data
str(hd)
summary(hd)
str(gii)
summary(gii)

#rename the columns
colnames(hd)<-c("HDI_rank", "country", "HDI", "life_exp", "edu_exp", "edu_mean", "GNI", "GNI-HDI")
colnames(gii)<-c("GII_rank", "country", "GII", "mat_mortality", "adol_birth", "parliament", "edu_women", "edu_men", "labour_women", "labour_men")

#creating new variables in gii: ratio of Female and Male populations with secondary education in each country
gii<-mutate(gii, edu_ratio=edu_women/edu_men)

#creating new variables in gii:ratio of labour force participation of females and males in each country
gii<-mutate(gii, labour_ratio=labour_women/labour_men)

#join the datasets by country
human <- inner_join(hd, gii, by = "country")
summary(human)
str(human)

#make a file
write.table(human, file = "create_human.R")

##WEEK 5 EXERCISES

#1. please look above for the variables I made (plus their names in my dataset)
str(human)
summary(human)
dim(human)
#human is a dataset combined of two datasets: hd and gii. it describes populations: life expectancy, labour rate, education. it has 195 observations in 19 variables.

#studying the structure of human variable GNI and mutating it into numeric
str(human$GNI)
str_replace(human$GNI, pattern=",", replace ="")%>%as.numeric

#2. selecting the columns to keep (notice that the column names are made by me!)
keep <- c("country", "edu_ratio", "labour_ratio", "life_exp", "edu_exp", "GNI", "mat_mortality", "adol_birth", "parliament")

human <- select(human, one_of(keep))

#3. selecting only complete cases
human_ <- filter(human, complete.cases(human))

#4. finding out wchich rows refer to regions instead of countries
human_$country

#the last seven rows (156-162) are not countries and are excluded
last <- nrow(human_) - 7
human_ <- human_[1:last, ]

#5. add countries as rownames
rownames(human_) <- human_$country
# remove the country variable
human_ <- select(human_, -country)

#overwriting the formen dataset "human"
human<-human_
#make a file
write.table(human, file = "create_human.R")
human