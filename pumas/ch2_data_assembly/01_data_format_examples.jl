#=
Chapter 2: Population PK-PD Data Requirements and Formatting
=============================================================
Pumas/Julia equivalent of NMTRAN data formatting concepts.

This script walks through Examples 1–5 from the MI-210 book,
showing how each NMTRAN dataset maps to Pumas `read_pumas`.

Note: Pumas expects lowercase column names by default
(id, time, dv, amt, evid, cmt, rate, ss, ii, addl, mdv).
=#

using Pumas
using DataFramesMeta
using CSV

# ─────────────────────────────────────────────────────────────
# Example 1: Simple PRED-style data (no PREDPP)
# ─────────────────────────────────────────────────────────────
# NONMEM: C,ID,TIME,DOSE,DV  — used with PRED model
# Model: Ct = Dose/V * exp(-CL/V * t)
#
# In Pumas, PRED-style models don't use the ODE/compartment
# machinery. DOSE column maps to a covariate.

ex1 = DataFrame(
    id   = [1, 1, 2, 2],
    time = [2, 6, 2, 6],
    DOSE = [100, 100, 100, 100],
    dv   = [24, 18, 29, 21],
    evid = [0, 0, 0, 0],
    amt  = [0, 0, 0, 0],
)

pop_ex1 = read_pumas(
    ex1;
    observations = [:dv],
    covariates = [:DOSE],
    event_data = false,
)

println("Example 1 — PRED style (", length(pop_ex1), " subjects)")

# ─────────────────────────────────────────────────────────────
# Example 2: Single IV bolus — PREDPP format
# ─────────────────────────────────────────────────────────────
# NONMEM: C,ID,TIME,AMT,DV
# Pumas: same columns (lowercase), EVID inferred from AMT

ex2 = DataFrame(
    id   = [1, 1, 1, 2, 2, 2],
    time = [0, 2, 6, 0, 2, 6],
    amt  = [100, 0, 0, 100, 0, 0],
    dv   = [missing, 24, 18, missing, 29, 21],
    evid = [1, 0, 0, 1, 0, 0],
    cmt  = [1, 1, 1, 1, 1, 1],   # single compartment IV bolus
)

pop_ex2 = read_pumas(ex2)
println("Example 2 — IV bolus PREDPP (", length(pop_ex2), " subjects)")

# ─────────────────────────────────────────────────────────────
# Example 3: Multiple oral dosing with ADDL/II + covariates
# ─────────────────────────────────────────────────────────────
# 30 mg q8h for 2 days (1 + 5 additional doses)
# Pumas supports addl and ii natively.

ex3 = DataFrame(
    id   = [1, 1, 1, 2, 2, 2],
    time = [0.0, 18.0, 23.8, 0.0, 10.0, 42.0],
    amt  = [30, 0, 0, 30, 0, 0],
    addl = [5, 0, 0, 5, 0, 0],
    ii   = [8, 0, 0, 8, 0, 0],
    dv   = [missing, 126, 33, missing, 150, 45],
    evid = [1, 0, 0, 1, 0, 0],
    cmt  = [1, 1, 1, 1, 1, 1],   # depot compartment (oral)
    WT   = [64, 64, 64, 81, 81, 81],
    CLCR = [80, 80, 70, 110, 110, 125],
)

pop_ex3 = read_pumas(
    ex3;
    covariates = [:WT, :CLCR],
)
println("Example 3 — oral q8h with ADDL/II (", length(pop_ex3), " subjects)")

# ─────────────────────────────────────────────────────────────
# Example 4: Steady-state infusion with RATE and SS
# ─────────────────────────────────────────────────────────────
# SS infusion (10 mg/hr), then 2nd infusion (20 mg/hr) at t=4
#
# Key NONMEM to Pumas mappings:
#   SS=1 -> ss=1 (steady state)
#   RATE>0 -> rate=value (zero-order infusion rate)

ex4 = DataFrame(
    id   = [1, 1, 1, 1, 1],
    time = [0.0, 0.0, 4.0, 6.0, 10.0],
    amt  = [0, 0, 40, 0, 0],
    rate = [10, 0, 20, 0, 0],
    ss   = [1, 0, 0, 0, 0],
    ii   = [0, 0, 0, 0, 0],   # required when ss is present
    dv   = [missing, 124.9, missing, 135.6, 110.6],
    evid = [1, 0, 1, 0, 0],
    cmt  = [1, 1, 1, 1, 1],   # single central compartment
)

pop_ex4 = read_pumas(ex4)
println("Example 4 — SS infusion + 2nd infusion (", length(pop_ex4), " subjects)")

# ─────────────────────────────────────────────────────────────
# Example 5: Crossover oral to IV with DATE/TIME, SS, CMT
# ─────────────────────────────────────────────────────────────
# 1-compartment model: cmt 1=depot (oral), cmt 2=central (IV)
#
# DATE+TIME: Pumas expects numeric time. Pre-convert dates to
# elapsed hours before calling read_pumas.

ex5 = DataFrame(
    id   = [1, 1, 1, 1, 1, 1],
    time = [0.0, 11.867, 11.883, 14.75, 24.1, 25.2],
    amt  = [50, 0, 50, 0, 50, 0],
    ss   = [1, 0, 0, 0, 0, 0],
    ii   = [12, 0, 0, 0, 0, 0],
    dv   = [missing, 124.9, missing, 135.6, missing, 150.9],
    evid = [1, 0, 1, 0, 1, 0],
    cmt  = [1, 2, 1, 2, 2, 2],
    AGE  = [42, 42, 42, 42, 42, 42],
)

pop_ex5 = read_pumas(
    ex5;
    covariates = [:AGE],
)
println("Example 5 — crossover oral to IV with CMT (", length(pop_ex5), " subjects)")

# ─────────────────────────────────────────────────────────────
# Summary: NONMEM to Pumas Data Column Mapping
# ─────────────────────────────────────────────────────────────
#=
  NONMEM Column    Pumas Column    Notes
  ─────────────    ────────────    ─────
  ID               id              Subject identifier
  TIME             time            Must be numeric (elapsed)
  DV               dv              Dependent variable
  AMT              amt             Dose amount
  EVID             evid            0=obs, 1=dose (same as NONMEM)
  CMT              cmt             Compartment number
  RATE             rate            Infusion rate (>0=specified, -1=est, -2=est duration)
  SS               ss              Steady state flag (1=SS)
  II               ii              Inter-dose interval
  ADDL             addl            Additional doses
  MDV              mdv             Pumas can also infer from missing dv
  DATE/TIME        (preprocess)    Convert to elapsed numeric time

  Covariates (WT, AGE, SEX, etc.) -> covariates kwarg in read_pumas
  Note: Pumas defaults expect lowercase column names for reserved items.
=#

println("\nAll 5 examples loaded successfully.")
