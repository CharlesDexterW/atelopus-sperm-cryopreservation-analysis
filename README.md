# Sperm Motility Analysis of *Atelopus* sp. under Cryoprotectant Formulations

Statistical analysis of sperm motility data from *Atelopus* sp. specimens,
evaluating the effect of two cryoprotectant formulations (CPA1 and CPA2) across
four post-activation time points. Part of an ongoing amphibian cryopreservation
research programme at Fundación Jambatu, Ecuador.

> **Data note:** The dataset used here is a simulated representation of pilot
> experimental findings, produced to protect confidential project information
> while preserving the statistical characteristics of the original data.
> Data collection was conducted personally by the author with explicit permission
> from supervisor Andrea Terán.

---

## Rendered report

The full analysis — figures, formatted tables, and interpretations — is available
as a self-contained HTML document:

**[View analysis.html](https://charlesdexterw.github.io/BGC/Analysis.html)**

---

## Repository structure

```
.
├── analysis.Rmd          # Source document — prose, code, and output in one file
├── analysis.html         # Rendered report (knitted from analysis.Rmd)
├── prd.xlsx              # Simulated motility dataset
└── Stat_Tests.Rproj      # RStudio project file
```

---

## Dependencies

R 4.x and RStudio. Install required packages before knitting:

```r
install.packages(c("tidyverse", "readxl", "pwr", "ggdist",
                   "knitr", "kableExtra", "broom"))
```

| Package | Purpose |
|---|---|
| `tidyverse` | Data wrangling (`dplyr`, `tidyr`) and plotting (`ggplot2`) |
| `readxl` | Import `.xlsx` dataset |
| `pwr` | Power analysis for sample size determination |
| `ggdist` | `stat_halfeye()` for raincloud plot half-violins |
| `knitr` / `kableExtra` | Formatted, captioned tables in the HTML output |
| `broom` | Converts ANOVA and Tukey objects to tidy data frames |

---

## How to run

1. Clone the repository.
2. Open `Stat_Tests.Rproj` in RStudio — this sets the working directory
   correctly so `prd.xlsx` is found automatically.
3. Open `analysis.Rmd` and click **Knit**, or run from the terminal:

```r
rmarkdown::render("analysis.Rmd")
```

The rendered `analysis.html` will be written to the project folder.
All code chunks are collapsed by default in the HTML output (`code_folding: hide`)
— click any **Code** button to inspect the underlying R.

---

## Analysis overview

### Data

39 observations across two treatments and four time lapses. Each row is one
motility measurement (% motile sperm) for a given treatment and time point.

| Column | Description |
|---|---|
| `Treatment` | Cryoprotectant formulation — CPA1 or CPA2 |
| `Time_Lapse` | Minutes post-activation — 5, 10, 15, or 20 |
| `Motility` | Percentage of motile sperm |

### Visualisation

Raincloud plots combine a half-violin (distribution shape), box plot
(median and IQR), and raw jittered points. This format is recommended for
small samples where bar plots would hide individual variation and distribution
shape (Allen et al., 2019; Weissgerber et al., 2015). CPA1 and CPA2 are
displayed on a shared axis for direct comparison.

### Statistical tests

A two-way ANOVA was fitted with Treatment, Time_Lapse, and their interaction
as fixed factors. One-way ANOVAs were then fitted per treatment to isolate
time effects within each formulation. Tukey's HSD post-hoc test was applied
to CPA2, which showed a significant time effect.

### Key findings

- **Treatment effect:** No significant difference in overall mean motility
  between CPA1 and CPA2 at the current sample size.
- **Time effect:** Time_Lapse is a significant predictor of motility for both
  formulations — motility declines over time regardless of cryoprotectant.
- **CPA2 post-hoc:** Significant motility decline between Time 5 and Time 15,
  and between Time 5 and Time 20 (Tukey HSD, p adj < 0.05). All other
  pairwise comparisons were non-significant.
- **CPA1 post-hoc:** No significant differences between any time lapse pair.
- **Sample size:** A power analysis (Cohen's f = 0.25, α = 0.05, power = 0.80)
  indicates approximately 45 observations per group are needed for a
  confirmatory study. The current pilot falls below this threshold.

---

## References

Allen M, Poggiali D, Whitaker K, Marshall TR, Kievit RA (2019). Raincloud plots:
a multi-platform tool for robust data visualization. *Wellcome Open Research*, 4:63.
https://doi.org/10.12688/wellcomeopenres.15191.1

Weissgerber TL, Milic NM, Winham SJ, Garovic VD (2015). Beyond bar and line
graphs: time for a new data presentation paradigm. *PLOS Biology*, 13(4):e1002128.
https://doi.org/10.1371/journal.pbio.1002128

---

## Author

A. Benjamin Garcés Cifuentes · Fundación Jambatu, Ecuador · R 4.x · Ubuntu 24.04 LTS
