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

# install.packages("ggdist")   # first time only
library(ggdist)

# Colour palette — consistent across both treatments
pal <- c("CPA1" = "#2E6F8E", "CPA2" = "#1D6A52")

# ── Raincloud plot — both treatments on one figure ────────────────────────────
# Combines half-violin (distribution), boxplot (median + IQR), and raw
# jittered points. Faceted by treatment so axes are directly comparable.
# This is the recommended format for small-n continuous data in biology
# (Allen et al. 2019; Weissgerber et al. 2015).

xlr$Time_Lapse <- factor(xlr$Time_Lapse)  # treat time as discrete groups

ggplot(xlr, aes(x = Time_Lapse, y = Motility, fill = Treatment, colour = Treatment)) +
  
  # Half-violin (distribution shape)
  stat_halfeye(adjust = 0.5, width = 0.4, justification = -0.3,
               .width = 0, point_colour = NA, alpha = 0.7) +
  
  # Box plot (median + IQR)
  geom_boxplot(width = 0.15, outlier.shape = NA, alpha = 0.5,
               colour = "grey30") +
  
  # Raw data points
  geom_jitter(width = 0.05, alpha = 0.6, size = 1.8) +
  
  # Significance brackets for CPA2 (Tukey results: 5 vs 15, 5 vs 20)
  # Add manually after confirming exact y positions in your data
  # ggsignif::geom_signif(comparisons = list(c("5","15"), c("5","20")),
  #                       map_signif_level = TRUE, y_position = c(102, 107))
  
  scale_fill_manual(values   = pal) +
  scale_colour_manual(values = pal) +
  facet_wrap(~ Treatment, ncol = 2) +
  scale_y_continuous(limits = c(40, 110), breaks = seq(40, 100, 20)) +
  labs(title    = "Sperm motility over time — CPA1 vs CPA2",
       subtitle = "Atelopus sp. · simulated pilot data",
       x        = "Time lapse (minutes)",
       y        = "Motility (%)") +
  theme_minimal(base_size = 12) +
  theme(legend.position  = "none",
        strip.text        = element_text(face = "bold", size = 11),
        panel.grid.minor  = element_blank(),
        plot.subtitle     = element_text(colour = "grey50", size = 10))

