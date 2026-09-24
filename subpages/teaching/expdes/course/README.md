# Statistical tests in biology

A complete frequentist methods collection for Experimental Design, Heath Blackmon, Texas A&M University.

Start with **index.html** for the course resources, **Course.pptx** for the slides, or **Instructor-dataset-guide.html** for the generating models, known truths, actual results, and reproducible code. All observations are simulated teaching data.

## Rebuild the course

1. Download and unzip the complete course package. Keep the folder structure intact.
2. Open RStudio in the course folder and run `source("install_dependencies.R")` once. This explicitly installs missing CRAN packages. Ordinary knitting never installs packages.
3. Open **Course.Rmd** and click Knit. Every dataset is simulated from its documented seed, written to CSV, read back, plotted, and analyzed before the PowerPoint is produced.
4. Open **Instructor-dataset-guide.Rmd** and click Knit to rebuild the HTML guide, Markdown guide, and catalog. Or run `source("build_instructor_guide.R"); build_instructor_guide(getwd())` after rebuilding data.

From an R session in the course folder, `rmarkdown::render("Course.Rmd")` also rebuilds the slides. PowerPoint rendering needs Pandoc, supplied with RStudio. A full course build runs 63 standalone examples and can take several minutes.

## Work with one method

Each `modules/METHOD/` folder contains:

- **analysis.R** — a standalone script with a fixed seed, simulation, CSV save/read, plot, analysis, and computed interpretation.
- **module.json** — plain-text teaching content, data dictionary, exact code excerpts, assumptions, alternatives, and generating truth.
- **generated/data.csv** — the simulated observations.
- **generated/plot.png** — the main data figure.
- **generated/results.json** — the preview, slide summaries, computed interpretation, and full printed analysis output.

For example, from a terminal in the course folder:

```sh
Rscript modules/welch_t/analysis.R modules/welch_t/generated
```

The optional first argument is the output directory. Read the script header before running an individual script interactively. The course runner invokes each script in a fresh R process.

## How the collection is organized

Every method uses the same sequence: data and analogous examples; seeded simulation; figure; plotting code and arguments; scientific question, null and options; assumptions and responses; executed analysis and results; interpretation and discussion.

The goal is to choose a method whose null answers the scientific question and to interpret its result correctly. Parametric fixes precede nonparametric alternatives. A change to ranks, transformations, or a different model may also change the scientific target. PCA, MDS, bootstrap intervals, and Kaplan–Meier estimation are explicitly identified as estimation or exploration rather than given an invented test null.

The slide picker covers all 45 cells of the earlier course matrix. The separate reveal board hides method names until a cell is selected. The final Midterm plan slide is intentionally blank.

## Reading with an LLM

Use **Course.md**, **Instructor-dataset-guide.md**, a module's **module.json**, and its **analysis.R** together. These retain selectable text and executable code. Distinguish the known generating truth from the realized sample estimate. Ask the assistant to identify the independent unit, state the exact null, explain the selected options, and check the conclusion against the saved output. Do not treat simulated results as observations from a real biological study.

## Provenance and reproducibility

This collection updates the earlier Experimental Design slides and test picker in the Blackmon Lab website repository. The scope is frequentist. Bayesian lectures and obsolete administrative details are not part of this collection. See **Sources.md** and **course-coverage.csv** for source and section mappings. **package-versions.csv** and **generation-status.csv** record the validated build. Seeds reproduce the simulations under the recorded R/package environment; numerical algorithms can vary slightly across package versions.
