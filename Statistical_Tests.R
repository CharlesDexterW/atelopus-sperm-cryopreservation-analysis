# statistical_tests.R
# Requires Setup.R to have been run first.

# ── Two-way ANOVA ─────────────────────────────────────────────────────────────
# Tests whether Treatment, Time_Lapse, or their interaction significantly
# explain variation in motility across the full dataset.
# H0: motility is not affected by treatment, time lapse, or their combination.
anova_two_way <- aov(Motility ~ Treatment * Time_Lapse, data = xlr)
print(summary(anova_two_way))

# Interpretation:
# Treatment alone does not produce a significant difference in mean motility
# between CPA1 and CPA2. Time_Lapse is significant, indicating motility
# changes over time regardless of which cryoprotectant is applied.
# The non-significant interaction term suggests both formulations follow a
# similar time-dependent trajectory — neither is uniquely better or worse
# at any specific time point, given the current sample size.

# ── One-way ANOVA per treatment ───────────────────────────────────────────────
# Tests whether time lapse significantly affects motility within each
# treatment independently.
# H0: motility does not differ across time lapses within a given treatment.
anova_cpa1 <- aov(Motility ~ factor(Time_Lapse), data = cpa1r)
anova_cpa2 <- aov(Motility ~ factor(Time_Lapse), data = cpa2r)

print("One-way ANOVA — CPA1:")
print(summary(anova_cpa1))

print("One-way ANOVA — CPA2:")
print(summary(anova_cpa2))

# CPA1: p > 0.05 — fail to reject H0. Time lapse does not significantly
#   affect motility under CPA1.
# CPA2: p < 0.05 — reject H0. At least one time lapse differs significantly
#   from the others under CPA2. Proceed to post-hoc testing.