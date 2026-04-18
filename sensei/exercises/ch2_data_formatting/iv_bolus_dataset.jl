#=
Challenge 1: Build an IV Bolus Dataset from Scratch

  You have 3 subjects who each received a 200 mg IV bolus at time 0. Plasma concentrations
  ┌─────────┬──────┬──────┬──────┐owing times:
  │ Subject │ t=1h │ t=4h │ t=8h │
  ├─────────┼──────┼──────┼──────┤
  │ 1       │ 15.2 │ 8.7  │ 3.1  │
  ├─────────┼──────┼──────┼──────┤
  │ 2       │ 18.1 │ 10.3 │ 4.5  │
  ├─────────┼──────┼──────┼──────┤
  │ 3       │ 12.9 │ 7.2  │ 2.8  │
  └─────────┴──────┴──────┴──────┘

  Your task: Write a Julia script that:
  1. Constructs a DataFrame with all required columns for read_pumas to parse this as
  PREDPP-style IV bolus data
  2. Calls read_pumas on it to produce a Population
  3. Prints the number of subjects

  Create the file at sensei/challenges/ch2_data_formatting_01.jl and run it.

  No hints yet — dig into the source material at
  pumas/ch2_data_assembly/01_data_format_examples.jl (especially Example 2) if you need
  guidance. You write every line.
=#

using DataFramesMeta
using Pumas

pc = DataFrame(USUBJIDN=[1, 1, 1, 2, 2, 2, 3, 3, 3], AFRLT=[1, 4, 8, 1, 4, 8, 1, 4, 8], DV=[15.2, 8.7, 3.1, 18.1, 10.3, 4.5, 12.9, 7.2, 2.8], ROUTE="iv", EVID=0, CMT=1)

ex = DataFrame(USUBJIDN=[1, 2, 3], AMT=200, AFRLT=0, ROUTE="iv", EVID=1, CMT=1)

adppk = @chain pc begin
  vcat(ex, cols=:union)
  @orderby :USUBJIDN :AFRLT
end

pop = read_pumas(adppk, id=:USUBJIDN, amt=:AMT, time=:AFRLT, evid=:EVID, cmt=:CMT, route=:ROUTE, observations=[:DV])

print(length(pop))

#= NOTES
- CMT in data = where the dose lands / where you observe (not total compartments in model)
- IV bolus: both dosing and observation rows are CMT = 1 (central)
- EVID: 1 = dosing event, 0 = observation (same as NONMEM)
- DV on dosing rows should be `missing` — Pumas infers mdv from this
- vcat(..., cols=:union) naturally makes DV missing on dose rows (clean trick)
- Standard lowercase column names (id, time, amt, evid, cmt, dv) need no kwargs in read_pumas
- Custom names (USUBJIDN, AFRLT) require explicit kwargs: id=:USUBJIDN, time=:AFRLT, ...
- `route` is NOT a standard data column — CMT determines where the dose goes
=#