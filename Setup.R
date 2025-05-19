## First of
## To load the needed packages

library(tidyverse) ## it's only necessary for loading the "readxl" function 
library(dplyr) ## this one I'll use it for later.
library(ggplot2)
library(tidyr)

## ---

## Adding text for git test

xlr <- read_xlsx("Cryoprotectant_Results.xlsx")
xlr
colnames(xlr) <- c("Treatment", "Time Lapse", "Motility (%)")
xlr

ggplot(xlr, aes(`Time Lapse`, `Motility (%)`)) + 
  geom_bar(stat = "summary", fun = "mean")

cpa1r <- xlr %>%
  filter(Treatment == "CPA1")

cpa1r_p <- ggplot(cpa1r, aes(`Time Lapse`, `Motility (%)`)) + 
  geom_bar(stat = "summary", fun = "mean")
cpa1r_p

cpa2r <- xlr %>%
  filter(Treatment == "CPA2")

cpa2r_p <- ggplot(cpa2r, aes(`Time Lapse`, `Motility (%)`)) + 
  geom_bar(stat = "summary", fun = "mean")
cpa2r_p
