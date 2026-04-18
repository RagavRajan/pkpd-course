# PKPD Sensei Course — Design Decisions

## Course Sources
Four content pools feed the sensei drill system:

1. **MI-210 (core curriculum)** — `pumas/ch*/ch*.qmd`
   MI-210: Essentials of Population PKPD M&S (Metrum Institute).
   Converted from R/NONMEM to Julia/Pumas as Quarto files. 7 chapters covering
   intro NLME, data assembly, model coding, covariates, simulation, evaluation, PK-PD.
   Each chapter is enhanced with PK concept callout boxes drawn from lecture material,
   explaining the physiological and theoretical foundations behind the code.

2. **Lecture Notes** — `lectures/pk/*.md` and `lectures/pkpd/*.md`
   Transcribed and formalized from Vimeo video lectures. Two course series:
   - **PK Course** (12 lectures, Weeks 1–9): Terminology, math foundations,
     1-cpt IV bolus, drug transport/distribution, volume of distribution,
     clearance, hepatic/renal elimination, well-stirred model, oral absorption,
     IV infusion kinetics.
   - **PKPD Modeling Course** (8 lectures, Weeks 1–8): Modeling philosophy,
     structural models, parameter estimation, PopPK components/NLME, base model
     diagnostics, graphical/residual diagnostics, error model specification,
     covariate modeling fundamentals and methodology (SCM/GAM/FFM).
   Lectures are also served as QMD pages on the website (`pumas/lectures/pk/*.qmd`
   and `pumas/lectures/pkpd/*.qmd`) and linked from chapter Supplementary Material
   sections.

3. **PumasTutorials.jl** — `PumasTutorials.jl/tutorials/<topic>/*.qmd`
   Official Pumas tutorials spanning 25+ topic areas:
   - Foundations: introduction, DataWranglingInJulia, PlottingInJulia, PlotCustomization
   - Core modeling: estimation, fitting, covariate_select, simulation
   - PD/PK-PD: PDModels (direct, effect-cpt, indirect, KPD, selection), pkpd
   - Advanced: bayesian, discrete, TMDD, PBPK, QSP, DeepPumas, AIDD
   - Applied: NCA, bioequivalence, optimal_design, NONMEMtoPumas, forest_plots
   - Workflow: reporting, accp case studies, PKPDDataAnalysisBook, LearningPaths

4. **MI-210 original materials** — `mi210_materials/`
   - `mi210book.pdf` — reference textbook
   - `exercise/` — NONMEM control streams & datasets organized by topic
     (contpkpd, covariates, indpopmodels, intropoppk, modelevaluation, nmtran, simulation)
   - `papers_slides/` — supplementary reading

## Source Files
MI-210 chapter content lives in `pumas/ch*/ch*.qmd`. Each QMD contains theory (markdown),
PK concept callouts (from lectures), and executable Julia/Pumas code blocks as worked examples.
PumasTutorials QMDs are standalone per-topic tutorials with their own data/assets.
MI-210 exercises provide NONMEM `.ctl` files useful for translation drills.
Lecture notes in `lectures/` provide the theoretical depth behind each chapter topic.

## Website
Hosted at https://ragavrajan.github.io/pkpd-course/ via GitHub Pages (gh-pages branch).
Quarto website with:
- **Navbar**: Home, Chapters (7), Lectures dropdown (12 PK + 8 PKPD), Sensei Progress (top-right)
- **Sidebar**: Chapters only (lectures accessible via navbar and cross-links)
- **Cross-links**: Each chapter's Supplementary Material table links to relevant lectures
- **Sensei Progress**: Dashboard page reading `sensei-state.json`, showing mastery cards,
  progress bar, session history. Fetches state.json at render/deploy time.

## PK Concept Enhancements
Each MI-210 chapter includes PK concept callout boxes (`::: {.callout-note}`) inserted
from lecture material. These explain the *why* behind the code — 18 callouts total:

| Chapter | Callouts Added |
|---------|---------------|
| Ch 1 | Modeling philosophy, PK terminology/error, 1-cpt model physiology, what η means |
| Ch 3 | CL/V/Ka physiology, compartment selection, Michaelis-Menten→Emax, error model rationale |
| Ch 4 | Why covariates reduce ω, physiological WT→V/CLCR→CL basis, η-shrinkage warning, SCM/GAM/FFM |
| Ch 5 | Accumulation/steady-state, parameter uncertainty for decisions |
| Ch 6 | Diagnostic plot interpretation, bootstrap vs asymptotic SEs |
| Ch 7 | Pharmacological basis of Emax, turnover concept physiology |

## Lecture-to-Chapter Mapping
Cross-references in each chapter's Supplementary Material section:

| Chapter | Linked Lectures |
|---------|----------------|
| Ch 1 | PK W1a, PK W2, PKPD W1, PKPD W2, PKPD W4 |
| Ch 2 | PK W1a, PK W1b |
| Ch 3 | PK W2, PK W4, PK W6, PK W7a, PK W8, PKPD W7 |
| Ch 4 | PK W4, PK W7b, PKPD W7.5, PKPD W8 |
| Ch 5 | PK W1c, PK W9 |
| Ch 6 | PKPD W5, PKPD W6, PKPD W7 |
| Ch 7 | PK W6, PK W7a, PK W8 |

## Node Structure
Nodes are organized by chapter (MI-210) or topic area (tutorials), progressing from
foundational concepts to applied skills. Each node maps to a section of a QMD file
or a tutorial. Challenges are Julia/Pumas coding tasks.

## Progression
MI-210 core path is linear within chapters, chapters are sequential. Prerequisites enforced:
- Ch1 (theory) before Ch3 (coding models)
- Ch3 (base models) before Ch4 (covariates)
- Ch3 before Ch5 (simulation) and Ch6 (evaluation)
- Ch3 before Ch7 (PK-PD)

Tutorial topics can extend the core path or stand alone:
- DataWranglingInJulia and PlottingInJulia have no prerequisites (can start anytime)
- PDModels, bayesian, discrete, TMDD, PBPK require Ch3 (base model competency)
- covariate_select requires Ch4
- NCA, bioequivalence, optimal_design are independent tracks
- DeepPumas, AIDD require both Ch3 and introduction tutorials
- NONMEMtoPumas pairs with MI-210 exercise `.ctl` files for translation drills

Lecture notes serve as supplementary reading — they are not prerequisite-gated but are
linked contextually from the chapters where their concepts are applied.

## Challenge Language
All challenges must be in Julia using the Pumas ecosystem.
Packages: Pumas, DataFramesMeta, CSV, CairoMakie, AlgebraOfGraphics.
