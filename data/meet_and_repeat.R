#Sina Hulkkonen
#08/12/2018
#IODS week6 exercises

library(dplyr)
library(tidyr)

#loading he datasets BPRS and RATS
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#describing and exploring them
summary(BPRS)
str(BPRS)
names(BPRS)
dim(BPRS)
summary(RATS)
str(RATS)
names(RATS)
dim(RATS)

#both datasets include study IDs, and the participants have been divided into categories by treatment (BPRS) and group (RATS)
#converting categorical variables into factors
BPRS$treatment <- factor(BPRS$treatment)
RATS$Group <- factor(RATS$Group)
RATS$ID <- factor(RATS$ID)

##BPRS
#convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
#extract the week number
BPRSL <-  BPRSL %>% dplyr::mutate(week = as.integer(substr(weeks,5,5)))

##RATS
# Convert data to long form & add Time variable
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

#describing and exploring datasets in long form
summary(BPRSL)
str(BPRSL)
names(BPRSL)
dim(BPRSL)
summary(RATSL)
str(RATSL)
names(RATSL)
dim(RATSL)

#the difference between the wide and long datasets is that in long form, one individual has several rows (observations in several time point), while in wide dataset, the observations of one individual are on the same row