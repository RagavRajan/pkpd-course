# PKPD Sensei Course — Design Decisions

## Course Sources
Three content pools feed the sensei drill system:

1. **MI-210 (core curriculum)** — `pumas/ch*/ch*.qmd`
   MI-210: Essentials of Population PKPD M&S (Metrum Institute).
   Converted from R/NONMEM to Julia/Pumas as Quarto files. 7 chapters covering
   intro NLME, data assembly, model coding, covariates, simulation, evaluation, PK-PD.

2. **PumasTutorials.jl** — `PumasTutorials.jl/tutorials/<topic>/*.qmd`
   Official Pumas tutorials spanning 25+ topic areas:
   - Foundations: introduction, DataWranglingInJulia, PlottingInJulia, PlotCustomization
   - Core modeling: estimation, fitting, covariate_select, simulation
   - PD/PK-PD: PDModels (direct, effect-cpt, indirect, KPD, selection), pkpd
   - Advanced: bayesian, discrete, TMDD, PBPK, QSP, DeepPumas, AIDD
   - Applied: NCA, bioequivalence, optimal_design, NONMEMtoPumas, forest_plots
   - Workflow: reporting, accp case studies, PKPDDataAnalysisBook, LearningPaths

3. **MI-210 original materials** — `mi210_materials/`
   - `mi210book.pdf` — reference textbook
   - `exercise/` — NONMEM control streams & datasets organized by topic
     (contpkpd, covariates, indpopmodels, intropoppk, modelevaluation, nmtran, simulation)
   - `papers_slides/` — supplementary reading

## Source Files
MI-210 chapter content lives in `pumas/ch*/ch*.qmd`. Each QMD contains theory (markdown)
and executable Julia/Pumas code blocks that serve as worked examples.
PumasTutorials QMDs are standalone per-topic tutorials with their own data/assets.
MI-210 exercises provide NONMEM `.ctl` files useful for translation drills.

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

## Challenge Language
All challenges must be in Julia using the Pumas ecosystem.
Packages: Pumas, DataFramesMeta, CSV, CairoMakie, AlgebraOfGraphics.
