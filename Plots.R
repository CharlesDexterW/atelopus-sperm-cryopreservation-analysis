# plots.R
# Visualises sperm motility across time lapses for both CPA treatments.
# Requires Setup.R to have been run first (xlr, cpa1r, cpa2r,
# cpa1_summary, cpa2_summary must be in the environment).
#
# Two plot styles are provided:
#   - Jitter plots: show individual data points alongside mean ± 1 SD.
#     Preferred for small samples where individual variation matters.
#   - Bar plots: show group means with SD error bars.
#     Included as an alternative for contexts where bar plots are expected.

# ── Jitter plot — CPA1 ────────────────────────────────────────────────────────
ggplot(cpa1r, aes(x = Time_Lapse, y = Motility)) +
  geom_jitter(aes(color = "Individual data points"),
              width = 0.2, alpha = 0.5) +
  geom_errorbar(data = cpa1_summary,
                aes(ymin  = mean_motility - sd_motility,
                    ymax  = mean_motility + sd_motility,
                    y     = mean_motility,
                    color = "Mean ± 1 SD"),
                width = 0.2, linewidth = 0.5) +
  geom_point(data = cpa1_summary,
             aes(y = mean_motility),
             color = "black", size = 2) +
  scale_color_manual(name   = "Data representation",
                     values = c("Individual data points" = "darkblue",
                                "Mean ± 1 SD"            = "black")) +
  labs(title = "Sperm motility under CPA1",
       x     = "Time lapse (minutes)",
       y     = "Motility (%)") +
  theme_minimal() +
  theme(legend.position = "bottom")

# ── Jitter plot — CPA2 ────────────────────────────────────────────────────────
ggplot(cpa2r, aes(x = Time_Lapse, y = Motility)) +
  geom_jitter(aes(color = "Individual data points"),
              width = 0.2, alpha = 0.5) +
  geom_errorbar(data = cpa2_summary,
                aes(ymin  = mean_motility - sd_motility,
                    ymax  = mean_motility + sd_motility,
                    y     = mean_motility,
                    color = "Mean ± 1 SD"),
                width = 0.2, linewidth = 0.5) +
  geom_point(data = cpa2_summary,
             aes(y = mean_motility),
             color = "black", size = 2) +
  scale_color_manual(name   = "Data representation",
                     values = c("Individual data points" = "darkblue",
                                "Mean ± 1 SD"            = "black")) +
  labs(title = "Sperm motility under CPA2",
       x     = "Time lapse (minutes)",
       y     = "Motility (%)") +
  theme_minimal() +
  theme(legend.position = "bottom")

# ── Bar plot — CPA1 ───────────────────────────────────────────────────────────
# geom_bar(stat = "identity") is used because means are pre-calculated
# in cpa1_summary — ggplot should not aggregate the data itself.
ggplot(cpa1_summary, aes(x = Time_Lapse, y = mean_motility)) +
  geom_bar(stat = "identity", fill = "lightblue", width = 3) +
  geom_errorbar(aes(ymin = mean_motility - sd_motility,
                    ymax = mean_motility + sd_motility),
                width = 0.2) +
  labs(title = "Mean sperm motility under CPA1",
       x     = "Time lapse (minutes)",
       y     = "Mean motility (%)") +
  theme_minimal()

# ── Bar plot — CPA2 ───────────────────────────────────────────────────────────
ggplot(cpa2_summary, aes(x = Time_Lapse, y = mean_motility)) +
  geom_bar(stat = "identity", fill = "lightgreen", width = 3) +
  geom_errorbar(aes(ymin = mean_motility - sd_motility,
                    ymax = mean_motility + sd_motility),
                width = 0.2) +
  labs(title = "Mean sperm motility under CPA2",
       x     = "Time lapse (minutes)",
       y     = "Mean motility (%)") +
  theme_minimal()