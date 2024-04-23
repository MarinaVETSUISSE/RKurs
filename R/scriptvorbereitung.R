##################################################
# Kurs: Projects in R
##################################################

# clear all
rm(list = ls())

# setwd
setwd("C:/Users/marin/Desktop/rkurs/")


# install.packages("Packagename")
# libary("Packagename") --> packages must be loaded each R session to give access to their functionality

# packages & libraries
library(usethis)
library(gitcreds)
library(here)
library(tidyverse)
library(medicaldata)
library(cowplot)

# Making sure RStudio knows about Git
# Introducing myself to GIt and R
usethis:: use_git_config(user.name = "MarinaVETSUISSE", user.email = "marina.hillen@unibe.ch")

# Creating a PAT (personal access token)
# usethis:: create_github_token()
# done 16.04.2024 (referal to confirmation email)
# gitcreds::gitcreds_set()
Sys.setenv(GIT_PAT = "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")

# In the Console R can be used as a calculator, brief calculations before adding
# a new snipplet to the actual code

# Objects:
# can be a single piece of data: number, string of characters
# or they can constist of structured data: array, vector, matrix, lists, data frames (tables)
# difference between matrix and df is that a matrix contains rows and columns only containing all numeric OR all character
# and a df can contain different types of data in different columns

# Object classes:
# numeric:	Any real number	(1, 3.14, 8.8e6)
# character: 	Individual characters or strings, quoted 	("a", "Hello, World!")
# factor: 	Categorical/qualitative variables 	Ordered values of economic status
# logical: 	Boolean variables 	(TRUE and FALSE)
# Date/POSIXct 	Calendar dates and times 	("2023-06-05")

# functions: using R for calculations
# roll2 <- funktion(bones = 1:6){
#    dice <- sample(bones, size = 2,
#        replace = TRUE,
#            sum(dice))
#  }

# name of function: roll2
# bones being the numbers on the dice
# rolling a dice two times, replace means clear and independent setting both times

# GOAL 1: FINDING A CHEAT SHEET FOR MY SCRIPTS
# GOAL 2: CONNECT R SCRIPTS VIA A MASTER FILE

########################
# EXCERCISES
########################

# assigning values
a <- 5
b <- 6
c <- a+b
sqrt(c) # squareroot

df <- read.csv("COVID19Cases_geoRegion.csv")

#using a preisntalled example data set
help(datasets)
?datasets#

aq <- airquality
aq #view
head(aq) #view only first 6 rows

aq[3,4]     #get values of individual cells: df[row, colum]
aq$Temp     #view only specific columns
aq$Temp[5]  #view only specific rows in that column

# some base plots
plot(aq$Temp, aq$Ozone) #plotting: plot(x-axis, y-axis)
#finding the exact name of a variable "Oz-" PRESS TAB

plot(aq$Temp, aq$Ozone, xlab = "Temperature (F)", ylab = "Ozone") 




