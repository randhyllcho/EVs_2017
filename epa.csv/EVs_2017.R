library(tidyverse)
library(ggrepel)

EV <- read.csv("EVs.csv", header = TRUE, stringsAsFactors = FALSE, na.strings = c("", "NA"))
str(EV)
EV %>% View
colnames(EV) <- EV[7,]
EV <- EV[-1:-7,]
EV <- EV[,-1]

EV <- EV %>% select(`Mfr Name`, `Range1 - Model Type Driving Range - Conventional Fuel`, Carline, `Drive Desc`, `Carline Class Desc`, `Batt Specific Energy (Watt-hr/kg)`) 
EV <- EV %>% na.omit() 
newNames <- c("Make", "Range", "Model", "Drive", "Class", "Watt-Hr/Kg")
colnames(EV) <- newNames

EV <- EV %>% mutate_at(vars(Range, `Watt-Hr/Kg`), funs(as.numeric))
# EV %>% separate(col = Drive, into = "Drive", sep = "-1")

EV$Drive[grepl("Front",EV$Drive)] <- "Front"
EV$Drive[grepl("Rear", EV$Drive)] <- "Rear"
EV$Drive[grepl("All", EV$Drive)] <- "AWD"
EV <- EV %>% mutate_at(vars(Drive), funs(as.factor))
EV <- EV %>% distinct(Model, .keep_all = TRUE)

ggplot(EV, aes(Make, Range)) +
  geom_label_repel(aes(label = paste(Model, Range, sep = ": ")), color = "dodgerblue") +
  theme_classic()


