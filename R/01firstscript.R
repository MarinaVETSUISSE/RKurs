##################################################
# Kurs: Projects in R
##################################################

# clear all
rm(list = ls())

# setwd
setwd("C:/Users/marin/Desktop/rkurs/")


# packages & libraries
library(usethis)
library(gitcreds)
library(here)
library(tidyverse)
library(medicaldata)
library(cowplot)
library(lubridate)
library(unibeCols)



# TIDYVERSE
# is a group of packages  for data wrangling and visualization
# load the whole thing or only individual packages e.g. ggplot

# making small df by hand BASE R
data.frame(code = c(0,1),
           label =c("male", "female"))

# making small df by hand TYDYVERSE
tibble::tibble(
  ~code, ~label,
  0, "male",
  1, "female"
)

# the "here"-package
# instead of setwd
data <- read.csv((here("C:/Users/marin/Desktop/rkurs/excercisefolder/data/raw","COVID19Cases_geoRegion.csv" )))

# view structure
str(data)



# Umlaute and special characters --> solving issue by encoding UTF
# base
#     read.csv("path/to/file.csv", fileEncoding = "UTF-8")
# tidyverse (readr)
#     read_csv("path/to/file.csv", fileEncoding = "UTF-8",
#         locale = locale(encoding = "UTF-8"))


# Excercise 1: Explore a df
insurancedata <- read.csv((here("C:/Users/marin/Desktop/rkurs/excercisefolder/data/raw","insurance_with_date.csv" )))
# 1338 obs. of 9 variables
view(insurancedata)
# types of variables: numeric or character
insurancedataimportedviatidyverse <- read_csv((here("C:/Users/marin/Desktop/rkurs/excercisefolder/data/raw","insurance_with_date.csv" )))

str(insurancedata)
str(insurancedataimportedviatidyverse)

all.equal(insurancedata, insurancedataimportedviatidyverse) # Returns TRUE if data1 and data2 are equal
# the difference is that in base R the date column is a character and when imported in tidyverse the type of data is unknown


# Piping: chainig operations together --> %>%
# the most important package for data wrangling is dplyr (and of course the tidyverse)
# select is for columns and filter is for rows

strep_tb  %>%  select(columnname1, columnname2)
df %>% select(contains ("i"))
strep_tb %>% select(where(is.factor))

# filtering:
strep_tb %>% filter(arm == "Control")

# Selecting observations: sliceing
# specific rows
strep_tb %>% slice(1, 2, 3, 5, 8, 13)

# Conditional modifivations:
# none
strep_tb  %>% 
  mutate(dose_strep_g_corr = dose_strep_g + 2)
#ifelse
strep_tb  %>%  
  mutate(txt = if_else(gender == "M", 
                       # when TRUE
                       "Male",
                       # when FALSE
                       "Female"))
#case when
strep_tb  %>%  
  mutate(dose_strep_g_corr = case_when(
    # Male, Streptomycin
    gender == "M" & arm == "Streptomycin" ~ "M Strepto",
    # Female, Streptomycin
    gender == "F" & arm == "Streptomycin" ~ "F Strepto",
    # all others are OK
    TRUE ~ "Control")
  )


# Working with strings
library(stringr)
txt <- "A siLLy exAmple "
str_to_lower(txt) # --> "a silly example "

# Excercise 2:
insurancedataimportedviatidyverse <- read_csv((here("C:/Users/marin/Desktop/rkurs/excercisefolder/data/raw","insurance_with_date.csv" )))

#Using the insurance data you loaded earlier…
#make factors out of the sex, and region
#make logical indicators for “has more than 2 children” and “smokes”
#add 6 months to the date variable

result <- insurancedataimportedviatidyverse  %>% 
  mutate(date = date + months(6),
         sex = factor(sex),
         region = factor(region))   %>% 
  filter(children > 2 & smoker == "yes")

# proposed solution:
newversion <- insurancedataimportedviatidyverse
reformatted <- newversion %>%  
  mutate(
    across(c(sex, region), factor),
    # sex = factor(sex),
    # region = factor(region),
    gt2_children = children > 2,
    smokes = smoker == "yes",
    date_6m = date + months(6)
    # date_6m = date + 30.4 * 6
  )

#################
#################
#################
# Making Publication type tables: gtsummary is my package of choice
#################
#################
#################

# aesthetics: all All data visualizations map data values into quantifiable features
# of the resulting graphic. We refer to these features as aesthetics:
# position, shape, size, color, line width, line type
# you can also refer to aesthtetic as dimension

# using color: disthinguishing groups, represent data values or to highlight

# there is a widely used color scheme called ColorBrewer
# to use them in R: install RColorBrewer

#install.packages("RColorBrewer")
library("RColorBrewer")
# in all plots there needs to be a legend indication intervalls and certainty

# The principle of proportional ink:
# chosing an suited axis start is crucial

# handling overlapping datapoints
# making the datapoint a bit more transparent

# 3D Models are not recommende:
# instad map the variables onto another aesthetis (shape, color, size, ...)


# Excercise plotting and data visualization

dfebola <- read.csv((here("C:/Users/marin/Desktop/rkurs/excercisefolder/data/raw", "ebola.csv")))
head(dfebola)
dfebola$Date <- as.Date(dfebola$Date)

# arrange bzw. dort by date
dfebola <- arrange(dfebola, Date)

dfebolafiltered <- dfebola %>%
  select(Date, Country, Cum_conf_cases) %>%
  filter(Date >= "2015-03-31", Country %in% c("Guinea", "Liberia"))

# create point plot:
ebolafirstplot <- ggplot(data = dfebolafiltered, 
                         mapping = aes(x = Date, y = Cum_conf_cases)) +
  geom_point()
ebolafirstplot

# create line plot
ebolasecondplot <- ggplot(data = dfebolafiltered, 
                         mapping = aes(x = Date, y = Cum_conf_cases)) +
  geom_line(aes(group = Country))
ebolasecondplot


# create column plot
ebolathirdplot <- ggplot(data = dfebolafiltered, 
                            mapping = aes(x = Date, y = Cum_conf_cases)) + 
  geom_col(position="stack")
ebolathirdplot


# Save  plots to a single PDF file
ggsave("plots_ebola.pdf", ebolafirstplot, width = 8, height = 6)


# now another example
# read in the data for that
covid_cantons_2020 <- read_csv((here("C:/Users/marin/Desktop/rkurs/excercisefolder/data/raw","covid_cantons_2020.csv" )))
# now plot: geom points
plot_covid_point_v1 <- ggplot(data = covid_cantons_2020, 
                              mapping = aes(x = datum, y = entries)) + 
  geom_point(alpha = 0.7, colour = "black", fill = "blue", 
             shape = 21, size = 1.5, stroke = 1.5)
plot_covid_point_v1

# now plot: geom cols
plot_covid_col_v1 <- ggplot(data = covid_cantons_2020, 
                            mapping = aes(x = datum, y = entries)) + 
  geom_col(position = "stack", alpha = 0.7, fill = "blue", 
           linetype = "solid", linewidth = 0.5, width = 0.7)
plot_covid_col_v1


# Using a Master Script
# Main R script that sources all subsequent R scripts

source(here("R/01_cleaning.R")) # source() reads R code from a file
source(here("R/02_analysis.R"))
source(here("R/03_plotting.R"))

# In a Quarto file: the main two differences to a plain Rfile are the button "source" and "visual"

# making changes to ckeck whether i cann commit changes


