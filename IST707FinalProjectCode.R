####################################
#
# Author: Laura C. Larregui & TEAM
# Purpose: IST 707 Final Project
#
####################################

#Import Libraries
library(plyr)
library(dplyr)
library(arules) #for ARM
library(arulesViz) #for ARM
library(RColorBrewer)#contains color palettes

# First lets load the data set
### link to dataset: https://www.kaggle.com/nareshbhat/health-care-data-set-on-heart-attack-possibility
#APA Citation: Naresh (2020). Health care: Data set on Heart Attack Possibility (Version 1) [CSV file]. Retrieved from https://www.kaggle.com/nareshbhat/health-care-data-set-on-heart-attack-possibility. 
fname<- file.choose()#browse for the file
heart<- read.csv(fname, header = TRUE)
#View(heart) #Takes a look of the csv file
str(heart) # 303 records and 14 variables

#Check for missing values
(sum(is.na(heart))) #There isn't any missing values
heart<-na.omit(heart) # Just to make sure there aren't any missing values
str(heart)# 303 records and 14 variables

#Check for duplicates
duplicated(heart)# One duplicated record
heart<-heart[!duplicated(heart),]# Removed duplicated record
str(heart) #302 records and 14 variables

#Convert variables from numeric to nominal 
## sex, cp, fbs, restecg, exang, slope, ca, thal, target
heart$sex<- factor(heart$sex)
heart$cp<- factor(heart$cp)
heart$fbs<- factor(heart$fbs)
heart$restecg<- factor(heart$restecg)
heart$exang<- factor(heart$exang)
heart$slope<- factor(heart$slope)
heart$ca<- factor(heart$ca)
heart$thal<- factor(heart$thal)
heart$target<-factor(heart$target)
str(heart)#test

#Recoding Variables
heart$thal=dplyr::recode(heart$thal, "0"="Normal", "1"="Fixed Defect", "2"="Reversable Defect")
#head(heart$thal)# I see there is another level "3" which wasn't mentioned in the data info
heart$thal=dplyr::recode(heart$thal,"3"="Unreversable Defect") #I'm assuming this is the value behind 3
heart$cp=dplyr::recode(heart$cp, "0"="None", "1"="Low", "2"="Medium","3"="High")
#head(heart$cp)

#Discretize Age
## -- Testing first
heart$�..age <- cut(heart$�..age, breaks = c(0,20,30,40,50,60,70,80),
                labels=c("twenties","thirties","forties","fifties","sixties", "seventies", "eighties"))
head(heart$�..age)

# Should we discreticize trestbps and chol?

#I would like to change the name of heart$�..age to heart$age
#names(heart)
names(heart)[names(heart) == "�..age"] <- "age"