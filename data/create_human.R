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
