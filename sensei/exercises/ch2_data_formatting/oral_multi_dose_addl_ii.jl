#= 

Challenge 2: Multiple Oral Dosing with ADDL/II and Covariates                                                                                                         

  A patient receives 50 mg oral dose every 12 hours for 3 days (that's 1 initial dose + 5 additional doses). Plasma concentrations were sampled at:                     

  ┌─────────┬─────────┬───────────────┬──────┬───────┬───────┬───────┐                                                                                                  
  │ Subject │ WT (kg) │ CLCR (mL/min) │ t=6h │ t=24h │ t=48h │ t=72h │                                                                                                  
  ├─────────┼─────────┼───────────────┼──────┼───────┼───────┼───────┤                                                                                                  
  │ 1       │ 72      │ 95            │ 42.3 │ 38.1  │ 35.7  │ 33.2  │                                                                                                  
  ├─────────┼─────────┼───────────────┼──────┼───────┼───────┼───────┤                                                                                                  
  │ 2       │ 58      │ 68            │ 55.8 │ 50.2  │ 48.9  │ 46.1  │                                                                                                  
  └─────────┴─────────┴───────────────┴──────┴───────┴───────┴───────┘                                                                                                  

  Your task: Write a Julia script that:                                                                                                                                 
  1. Constructs a DataFrame capturing the dosing regimen using ADDL and II (do NOT create separate rows for each of the 6 doses)                                        
  2. Includes WT and CLCR as covariates                                                                                                                                 
  3. Calls read_pumas with the covariates kwarg to produce a Population                                                                                                 
  4. Prints the number of subjects                                                                                                                                      

  Key questions to think about:                                                                                                                                         
  - This is oral dosing — which CMT does the dose go into?                                                                                                              
  - How do ADDL and II encode "50 mg q12h for 3 days"?                                                                                                                  
  - What EVID values do dosing vs observation rows get?
=#

using DataFramesMeta
using Pumas

ex = DataFrame(id=[1, 2], amt=50, ii=12, addl=5, time=0, route="ev", cmt=1, evid=1)

pc = DataFrame(
    id=repeat(1:2, inner=4),
    wt=repeat([72, 58], inner=4),
    crcl=repeat([95, 68], inner=4),
    time=repeat([6, 24, 48, 72], outer=2),
    dv=[42.3, 38.1, 35.7, 33.2, 55.8, 50.2, 48.9, 46.1],
    route="ev",
    evid = 0,
    cmt=2
)

adppk = @chain pc begin
    vcat(ex, cols=:union)
    @orderby :id :time
end

pop = read_pumas(adppk; covariates=[:wt,:crcl])

print(length(pop))

#= NOTES
- ADDL/II encode repeated dosing in a single row (no need for separate dose rows)
- addl=5, ii=12 → 1 initial + 5 additional doses every 12h = 6 total doses over 3 days
- Oral dosing: dose enters CMT 1 (depot), observations from CMT 2 (central/plasma)
- Covariates (WT, CLCR, etc.) are passed via covariates=[:wt, :crcl] in read_pumas
- Covariates must be present on ALL rows for a subject (constant per row)
=#