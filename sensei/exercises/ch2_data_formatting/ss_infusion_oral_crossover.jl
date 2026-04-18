#=
Challenge 3: Steady-State Infusion → Oral Crossover

  A single patient participates in a crossover PK study:

  Period 1 (IV infusion at steady state):
  - 10 mg/hr continuous IV infusion, assumed at steady state at time 0
  - Samples taken at t=0h (trough) and t=2h

  Period 2 (Oral dose):
  - At t=6h, patient receives a single 100 mg oral dose
  - Samples taken at t=8h and t=12h

  ┌──────────┬──────────────────────┐
  │ Time (h) │ Concentration (mg/L) │
  ├──────────┼──────────────────────┤
  │ 0        │ 84.5                 │
  ├──────────┼──────────────────────┤
  │ 2        │ 87.2                 │
  ├──────────┼──────────────────────┤
  │ 8        │ 62.1                 │
  ├──────────┼──────────────────────┤
  │ 12       │ 41.8                 │
  └──────────┴──────────────────────┘

  Your task: Write a Julia script that:
  1. Constructs a DataFrame encoding both the SS infusion and the oral dose
  2. Uses the correct CMT for each route (depot vs central)
  3. Uses SS, II, and RATE correctly for the infusion
  4. Calls read_pumas to produce a Population
  5. Prints the number of subjects

  Think carefully about:
  - What does ss=1 mean, and what ii value pairs with a continuous infusion?
  - What rate value encodes a 10 mg/hr infusion?
  - Which CMT gets the IV infusion? Which gets the oral dose?

  Create at sensei/exercises/ch2_data_formatting_03.jl. Source material: Examples 4 and 5 (lines 87–135). Solve this without hints to reach mastery 3.
=#


using DataFramesMeta
using Pumas

pc = DataFrame(id=1, time=[0, 2, 8, 12], dv=[84.5, 87.2, 62.1, 41.8], evid=0, rate=0, ss=0, cmt=[2,2,2,2], ii=0)

ex = DataFrame(id=1, time=[0,6], amt=[0,100], rate=[10,0], ss=[1,0], evid=1, cmt=[2,1], ii=0)

adppk = @chain pc begin
    vcat(ex, cols=:union)

    sort(_, [:id, :time, order(:evid, rev=true)])
end

pop = read_pumas(adppk)

print(length(pop))

#= NOTES
- Crossover (IV + oral) CMT mapping: CMT 1 = depot (oral), CMT 2 = central (IV)
- IV infusion at SS: rate=10, ss=1, amt=0, ii=0 (continuous, no discrete interval)
- Oral dose: amt=100, cmt=1 (depot) — drug absorbs into central
- ALL observations are always CMT 2 (central/plasma) regardless of dosing route
  - You never observe from depot — you measure plasma concentration
- Sort with dosing events before observations at same time: order(:evid, rev=true)
- SS flag (ss=1) tells Pumas to assume steady-state concentrations at that time point
- RATE > 0 encodes zero-order infusion rate (mg/hr)
=#