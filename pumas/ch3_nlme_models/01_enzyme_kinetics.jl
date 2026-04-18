#=
Chapter 3, Problem 1: Enzyme Kinetics (Michaelis-Menten)
========================================================
Translated from: indpopmodels/solution/enz/1.ctl

NONMEM $PRED model:
  KM = THETA(1)*EXP(ETA(1))
  VMAX = THETA(2)*EXP(ETA(2))
  ACT = VMAX*CONC/(KM+CONC)
  Y = ACT + EPS(1)

Estimation: FO (METHOD=0) with POSTHOC
=#

using Pumas
using DataFramesMeta
using CSV

# ── Data Loading ──────────────────────────────────────────────

# Read the corrected data (enz3.csv)
# $INPUT C ID CONC DV EVID → columns are: C, ID, Concentration, ObsActivity, MDV
raw = CSV.read(
    joinpath(@__DIR__, "../data/enz3.csv"),
    DataFrame,
)

# Fix the data entry error (concentration > 1000 → 1000)
# as done in the original R script: enz.data$Concentration[enz.data$Concentration>1000] <- 1000
enz_df = @rtransform(raw,
    :Concentration = :Concentration > 1000 ? 1000 : :Concentration,
)

# Rename to Pumas-compatible lowercase columns
# This is a $PRED model — CONC is the independent variable (used as time axis)
rename!(enz_df,
    :ID => :id,
    :Concentration => :CONC,
    :ObsActivity => :dv,
)

# Use CONC as the time axis since this is a non-temporal $PRED model
# where concentration is the independent variable
enz_df.time = Float64.(enz_df.CONC)

pop = read_pumas(
    enz_df;
    observations = [:dv],
    covariates = [:CONC],
    event_data = false,
)

println("Data loaded: ", length(pop), " subjects")

# ── Model Definition ──────────────────────────────────────────

enz_model = @model begin
    @metadata begin
        desc = "Enzyme Kinetics — Michaelis-Menten (PRED)"
        timeu = u"hr"
    end

    @param begin
        tvKM   ∈ RealDomain(lower = 0.0, init = 20.0)    # THETA(1)
        tvVMAX ∈ RealDomain(lower = 0.0, init = 120.0)   # THETA(2)
        Ω      ∈ PDiagDomain(2)                            # diagonal OMEGA
        σ_add  ∈ RealDomain(lower = 0.0, init = sqrt(10)) # SIGMA(1) = 10 (variance)
    end

    @random begin
        η ~ MvNormal(Ω)
    end

    @covariates CONC

    @pre begin
        KM   = tvKM * exp(η[1])     # KM = THETA(1)*EXP(ETA(1))
        VMAX = tvVMAX * exp(η[2])   # VMAX = THETA(2)*EXP(ETA(2))
    end

    # No @dynamics — this is a $PRED model

    @derived begin
        ACT := @. VMAX * CONC / (KM + CONC)   # Michaelis-Menten
        dv ~ @. Normal(ACT, σ_add)              # Y = ACT + EPS(1)
    end
end

# ── Initial Parameters ────────────────────────────────────────

params = (
    tvKM   = 20.0,
    tvVMAX = 120.0,
    Ω      = Diagonal([0.04, 0.04]),   # OMEGA values
    σ_add  = sqrt(10.0),               # sqrt(SIGMA) for SD
)

# ── Estimation ────────────────────────────────────────────────
# NONMEM METHOD=0 → FO (First Order)
# POSTHOC → empirical Bayes estimates (computed automatically by Pumas)

fit_result = fit(enz_model, pop, params, Pumas.FO())

println("\n── Fit Result ──")
println(fit_result)

# ── Inference (maps to $COVARIANCE) ──────────────────────────

infer_result = infer(fit_result)
println("\n── Inference ──")
println(infer_result)

# ── Diagnostics (maps to $TABLE) ─────────────────────────────

inspect_result = inspect(fit_result)
println("\n── Inspection complete ──")
