#Data set: cpuperform.csv
#Group the observations in this dataset in classes, using a k-means cluster analysis. The
#clustering variables should be all the variables in the dataset, except vendor and erp.

Cpu <- read.csv('cpuperform.csv', stringsAsFactors = F)
Cpu$vendor <-NULL
Cpu$prp <-NULL

##Remove missing values 
Cpu <-na.omit(Cpu)

#Create a matrix with all clustering variables 
Cpu2 <-cbind(Cpu$myct, Cpu$mmin, Cpu$mmax, Cpu$cach, Cpu$chmin, 
             Cpu$chmax)

#Standardize the clustering variables
Cpu2 <-scale(Cpu2)

colnames(Cpu2) <-c("myct", "mmin", "mmax","cach", "chmin", "chmax")
View(Cpu2)

Cpu2 <-as.data.frame(Cpu2)

## Run K-means with 3 clusters 
model <- kmeans(Cpu2, 3)

## Clustering vector 
member3 <-model$cluster

Cpu2 <- cbind(Cpu2, member3)

View(Cpu2)

#Compute summary stats
library(dplyr)

Summ <- Cpu2 %>% group_by(member3) %>%
  summarize_each(funs(mean),myct, mmin, mmax,cach, chmin,chmax)
View(Summ)








