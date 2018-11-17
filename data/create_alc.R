#IODS exercise3, data wrangling
#Sina Hulkkonen
#13/11/2018

install.packages("dplyr")
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

#joinin the two datasets
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, by = join_by,suffix=c(".math", ".por"))

#exloring the structure and dimensions of the joined dataset
str(math_por)
dim(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

#taking a look to the new dataset alc
glimpse(alc)


#alcohol consumption
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)
