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