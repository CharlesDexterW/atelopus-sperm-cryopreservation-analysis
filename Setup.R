# Setup.R
# ── Dependencies ──────────────────────────────────────────────────────────────
# tidyverse provides dplyr (filtering, grouping), tidyr (reshaping),
# and ggplot2 (plotting) in a single import.
library(tidyverse)
library(readxl)  # read_xlsx() for .xlsx import
library(pwr)     # pwr.anova.test() for sample size determination
library(ggdist)  # install.packages("ggdist")   # first time only


# ── Data import ───────────────────────────────────────────────────────────────
# Range A1:C40 is specified explicitly to suppress warnings from trailing
# empty columns. col_names = FALSE prevents the first data row being
# consumed as a header — column names are assigned manually below.
xlr <- read_xlsx("prd.xlsx", range = "A1:C40", col_names = FALSE)
colnames(xlr) <- c("Treatment", "Time_Lapse", "Motility")

# ── Per-treatment subsets ─────────────────────────────────────────────────────
# Splitting into separate data frames simplifies plot and ANOVA calls
# and makes the treatment-specific analyses self-documenting.
cpa1r <- xlr %>% filter(Treatment == "CPA1")
cpa2r <- xlr %>% filter(Treatment == "CPA2")

# ── Descriptive summaries ─────────────────────────────────────────────────────
# Mean and SD per time lapse are pre-computed here and reused by both
# the error bar layers in plots.R and the ANOVA interpretation in
# statistical_tests.R.
cpa1_summary <- cpa1r %>%
  group_by(Time_Lapse) %>%
  summarize(mean_motility = mean(Motility, na.rm = TRUE),
            sd_motility   = sd(Motility,   na.rm = TRUE))

cpa2_summary <- cpa2r %>%
  group_by(Time_Lapse) %>%
  summarize(mean_motility = mean(Motility, na.rm = TRUE),
            sd_motility   = sd(Motility,   na.rm = TRUE))

# ── Colour palette ─────────────────────────────────────────────────────
# consistent across both treatments
pal <- c("CPA1" = "#2E6F8E", "CPA2" = "#1D6A52")
