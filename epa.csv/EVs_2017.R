library(tidyverse)

EV <- read.csv("EVs.csv", header = TRUE, stringsAsFactors = FALSE, na.strings = c("", "NA"))
str(EV)
EV %>% View
colnames(EV) <- EV[7,]
EV <- EV[-1:-7,]
EV <- EV[,-1]

EV <- EV %>% select(`Mfr Name`, `Range1 - Model Type Driving Range - Conventional Fuel`, Carline, `Drive Desc`, `Carline Class Desc`, `Batt Specific Energy (Watt-hr/kg)`) 
EV <- EV %>% na.omit() 

