using DataFramesMeta
using Optim

df = DataFrame(Time=[1,2,4,6,8,12],Conc=[38.5,30.1,17.8,11.2,6.5,2.4])
Dose = 1000
Co = 38.5

V = Dose / Co

obs = df.Conc
t = df.Time
pred(p) = Dose/p[2] * exp.(-(p[1]/p[2]) .* t)

f(p) = sum((obs - pred(p)) .^ 2)
result = optimize(f, [3.0,25.0], NelderMead())
print(Optim.minimizer(result))

#= NOTES
- Nonlinear regression: minimize sum of squared residuals (OLS) to estimate parameters
- 1-cmt IV bolus model: Ct = Dose/V * exp(-CL/V * t)
- Initial estimates matter — C0 = Dose/V gives a starting V; half-life guides CL
- Half-life: t½ = 0.693 * V / CL
- NelderMead() is a derivative-free optimizer — works for simple problems
- This is what fit() in Pumas does under the hood (with more sophistication)
=#