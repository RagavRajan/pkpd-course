# Week 1 Pharmacokinetics: Mathematical Foundations — Units, Dimensionality, and Rate Processes

## 1. Review: The Basic Pharmacokinetic Equation

Returning to the foundational equation from the previous session:

$$C(t) = \frac{\text{Dose}}{V} \cdot e^{-k_e \cdot t}$$

The elimination rate constant $k_e$ can be expressed as a relationship between clearance (CL) and volume of distribution (V):

$$k_e = \frac{CL}{V}$$

This relationship will be revisited throughout the course.

---

## 2. Units and Dimensionality

### 2.1 Why Units Matter

An equation is only valid if the units on both sides are consistent. Consider the relationship $CL = k_e \cdot V$:

- $k_e$ has units of $\text{hr}^{-1}$
- $V$ has units of $\text{L}$
- Therefore, $CL = k_e \cdot V$ has units of $\text{L/hr}$ ✓

Understanding units provides a near-complete description of a system's behavior. Units should never be treated as an afterthought.

### 2.2 Fundamental Rules of Dimensionality

There are two fundamental rules to keep in mind at all times:

1. **Addition and subtraction:** Quantities can only be added or subtracted if they share the same units. For example, one cannot add a dose in milligrams to a dose in nanograms without first converting them to a common unit.

2. **Multiplication and division:** Quantities with different units can be multiplied or divided to form new composite units. For example, $k_e \cdot V$ combines $\text{hr}^{-1}$ and $\text{L}$ to yield $\text{L/hr}$.

### 2.3 Dimensionless Quantities

Some quantities in pharmacokinetics carry no units. These are termed **dimensionless quantities**.

**Examples of dimensionless quantities:**

- **Bioavailability (F):** F is a fraction — the ratio of the amount of drug reaching systemic circulation to the dose administered. Fractions and ratios are inherently dimensionless.
- **Percentages as fractions:** When bioavailability is expressed as a percentage (e.g., 40%), it is simply a fraction multiplied by 100 for readability. As long as a percentage represents a ratio of two like quantities, it remains dimensionless. Note that percentages can also be applied to quantities that carry dimensions (e.g., weight/volume concentrations in dispensing pharmacy), but in the context of bioavailability and pharmacokinetic fractions, they are unitless.
- **Unbound fraction (f$_u$):** Also a ratio, and therefore dimensionless.
- **Logarithms of quantities:** The logarithm of any quantity is dimensionless. This is because a logarithm is implicitly a ratio — the quantity is compared to a reference value of the same unit, yielding a dimensionless result. In practice, publications sometimes label a log-concentration axis with units (e.g., "log[ng/mL]") as a shorthand to communicate the original concentration units; however, strictly speaking, the logarithm itself has no units.

### 2.4 The AUC Equation and Units

The area under the concentration–time curve (AUC) is given by:

$$AUC = \frac{F \cdot \text{Dose}}{CL}$$

Since F is dimensionless and dose is in $\mu\text{g}$ and clearance is in $\text{mL/hr}$:

$$AUC = \frac{\mu\text{g}}{\text{mL/hr}} = \mu\text{g} \cdot \text{hr/mL}$$

This unit — a mass-time product divided by volume — is the standard unit for AUC.

### 2.5 Common Pharmacokinetic Parameters: Symbols and Units

A reference table of the most commonly encountered PK parameters, their symbols, typical units, and representations is provided as a starting point. Multiple representations exist; this table serves as an orientation.

---

## 3. Unit Conversions

Unit conversions are an essential, practical skill in pharmacokinetic analysis. Common scenarios arise when dose units and concentration units are on different scales, or when converting between measurement systems (e.g., from clinical to research platforms).

### 3.1 Simple Single-Unit Conversions

**Example — dose conversion:**

$$\text{Dose in } \mu\text{g} = \text{Dose in mg} \times 1000$$

Since 1 mg = 1000 µg, multiplying by 1000 converts milligrams to micrograms.

**Example — concentration conversion (single dimension):**

When converting from ng/mL to mg/mL, only the mass unit changes. The conversion factor is applied to the mass dimension alone.

### 3.2 Multi-Unit Conversions

When the dose is expressed in milligrams but plasma concentrations are in nanograms per milliliter, both units must be reconciled before analysis. Options include:

- Converting concentrations from ng/mL to mg/mL, or
- Converting the dose from mg to ng, yielding concentrations in ng/L.

If both mass and volume units differ, each dimension must be converted independently and sequentially.

### 3.3 Molar Conversions

A common real-world scenario involves converting mass-based concentrations to molar concentrations. For example, converting ng/mL to nanomolar (nM) requires knowledge of the drug's molecular weight (MW, in g/mol). The steps are:

1. Convert ng to mg
2. Convert mg to g
3. Convert g to mol using MW
4. Convert mol to nmol
5. Convert mL to L

Each step addresses a single dimension. The intermediate steps are:

$$[\text{nM}] = \frac{[\text{ng/mL}] \times 10^{-6}}{MW [\text{g/mol}]} \times 10^9$$

### 3.4 Clearance Unit Conversion

**Example — converting clearance from L/hr to mL/min:**

$$CL [\text{mL/min}] = CL [\text{L/hr}] \times \frac{1000 \text{ mL}}{1 \text{ L}} \times \frac{1 \text{ hr}}{60 \text{ min}}$$

Both the volume dimension (L → mL, factor of 1000) and the time dimension (hr → min, factor of 1/60) are converted independently.

---

## 4. Significant Figures and Rounding

### 4.1 Machine Precision and Floating-Point Arithmetic

Computers represent numbers with finite precision, and floating-point arithmetic can produce results with many trailing decimal digits that appear numerically meaningful but are computational artifacts. For example, a clearance value computed as 250.000000000003 mL/min is, for all pharmacokinetic purposes, 250 mL/min. This discrepancy arises from **machine accuracy** — the finite precision of the hardware's floating-point representation.

The key principle: **the precision required for computing is not the same as the precision required for communication or decision-making.** The analyst must recognize when trailing digits are computationally necessary but scientifically irrelevant, and report accordingly.

### 4.2 Significant Figures

**Definition:** The number of significant figures (or significant digits) is the total number of meaningful digits in a measurement — that is, digits that carry information about the actual precision of the measurement.

**Rules:**

- Non-zero digits are always significant.
- Zeros between non-zero digits are significant.
- **Leading zeros are not significant.** For example, in 0.002345, only the digits 2, 3, 4, 5 are significant — there are four significant figures.
- Trailing zeros after the decimal point are significant.

**Example:** 1230.4 has five significant figures; 0.002345 has four.

### 4.3 Decimal Places vs. Significant Figures

There are two distinct rounding conventions, each appropriate in different contexts:

| Convention | Definition | Use case |
|---|---|---|
| **Decimal places (digits)** | Number of digits to the right of the decimal point | When communicating precision for numbers of similar magnitude |
| **Significant figures (sigdigits)** | Total number of meaningful digits | When numbers span a wide range or when the integer part is large |

**When to use each:**

- Use **significant figures** when numbers vary widely in magnitude (e.g., across a results table), or when the integer values are large and decimal precision is relatively unimportant. Keeping three significant figures throughout a table ensures uniform precision regardless of scale.
- Use **decimal places** when precision in the decimal component is specifically important for communication — for example, reporting a PK parameter like CL = 12.34 L/hr where the decimal conveys meaningful resolution.

### 4.4 Rounding Rules

The standard rounding rule applies: if the first digit to be dropped is **≥ 5**, round up; if it is **< 5**, round down.

**Example:** Rounding 12.3456789 to two decimal places yields 12.35 (since the third decimal digit, 5, triggers rounding up). Rounding to four significant figures yields 12.35 (digits 1, 2, 3, 4, 5 → round up from 5 → 12.35).

### 4.5 Practical Importance: Bioequivalence

Significant figures and rounding conventions are not merely academic. In regulatory contexts such as bioequivalence (BE) assessments, the FDA specifies how confidence interval limits must be handled. The 90% confidence interval for the geometric mean ratio must fall within 80.00–125.00%. A lower bound of 79.9356 **cannot** be rounded to 80.00 and declared a pass — specific rules govern how decimal places are applied, and the relevant regulatory guidance must be followed.

### 4.6 Printing with Custom Formats

In computational reporting environments (e.g., Julia with Quarto or Markdown), it is possible to **display** a number with controlled precision without **changing** the underlying stored value. String formatting macros (e.g., `@sprintf` in Julia) allow the printed representation to show a specified number of decimal places or significant figures, while the variable in memory retains full floating-point precision. This is distinct from the `round()` function, which creates a new numeric value with reduced precision.

The distinction matters when computed results feed into subsequent calculations — always retain full precision in memory and apply formatting only at the output/reporting stage.

---

## 5. Exponential and Logarithmic Functions

### 5.1 Logarithms: Definition and Bases

The logarithm of a number $x$ to base $b$ is the power to which $b$ must be raised to produce $x$:

$$\log_b(x) = y \iff b^y = x$$

Two bases are commonly used:

| Name | Notation | Base |
|---|---|---|
| Common logarithm | $\log_{10}(x)$ or $\log(x)$ | 10 |
| Natural logarithm | $\ln(x)$ | $e \approx 2.718$ |

The relationship between natural and common logarithms is:

$$\ln(x) = 2.303 \cdot \log_{10}(x)$$

**Important note for Julia:** The `log()` function in Julia computes the **natural logarithm** (base $e$). To compute log base 10, use `log10(x)`; for an arbitrary base $b$, use `log(b, x)`.

### 5.2 Why Use Logarithmic Scales?

Logarithmic transformation is used extensively in pharmacokinetics for two primary reasons:

1. **Linearization:** An exponential concentration–time profile, $C(t) = C_0 \cdot e^{-k_e t}$, becomes a straight line when plotted on a log scale:
$$\ln C(t) = \ln C_0 - k_e \cdot t$$
   Linear relationships are easier to analyze, fit, and interpret than exponential ones.

2. **Visualization:** When data span several orders of magnitude, a log scale compresses the range and makes all values visible on a single plot.

### 5.3 Interpreting the Log-Linear Slope

When the log-transformed concentration–time relationship is written as:

$$\ln C = \ln C_0 - k_e \cdot t$$

the slope is $-k_e$ with units of $\text{hr}^{-1}$. A value of $k_e = 0.38\ \text{hr}^{-1}$ means that approximately **38% of the drug in plasma is eliminated each hour**, under the assumption of first-order kinetics. This interpretation arises because $k_e$ has units of $\text{hr}^{-1}$, and the product $k_e \cdot t$ is dimensionless — the rate constant scales the remaining concentration at each moment in time.

### 5.4 Dimensionless Nature of Logarithms

Because a logarithm is implicitly the ratio of a quantity to a reference value of the same unit, logarithms are dimensionless. Log-concentration does not carry the units of concentration.

### 5.5 Fundamental Rules of Logarithms

These rules appear repeatedly in pharmacokinetic derivations:

| Rule | Expression |
|---|---|
| Product rule | $\log(xy) = \log x + \log y$ |
| Quotient rule | $\log\!\left(\dfrac{x}{y}\right) = \log x - \log y$ |
| Power rule | $\log(x^n) = n \cdot \log x$ |
| Logarithm of 1 | $\log(1) = 0$ |

**Application — allometric scaling:** In allometric scaling, clearance (or volume) is plotted as $\log(CL)$ vs. $\log(\text{body weight})$ across species. This is a direct application of the power rule: $CL = a \cdot W^b$ becomes $\log(CL) = \log(a) + b \cdot \log(W)$, a linear relationship.

**Application — dimensionless ratios:** The quotient rule explains why $\log(x/y)$ is dimensionless — when $x$ and $y$ share the same units, the ratio $x/y$ is unitless, and its logarithm is therefore also unitless.

### 5.6 Rules of Exponents

Exponents are a shorthand for repeated multiplication and appear throughout PK equations. Key rules:

| Rule | Expression |
|---|---|
| Product rule | $a^m \cdot a^n = a^{m+n}$ |
| Power of a power | $(a^m)^n = a^{mn}$ |
| Zero exponent | $a^0 = 1$ (for $a \neq 0$) |
| Negative exponent | $a^{-n} = \dfrac{1}{a^n}$ |

A solid command of exponent rules is essential for simplifying and solving PK equations. Negative exponents in particular can cause computational issues (e.g., division by zero) and must be handled carefully in model implementations.

---

## 6. Rates and Orders of Processes

### 6.1 Zero-Order Processes

A **zero-order process** is one in which the rate of change of concentration is **constant** and **independent of the current concentration**:

$$-\frac{dC}{dt} = k_0$$

Integrating this expression yields:

$$C(t) = C_0 - k_0 \cdot t$$

This is a linear equation in time: on a concentration–time plot, it produces a straight line with slope $-k_0$.

**Units of $k_0$:** Since $C$ has units of concentration (e.g., ng/mL) and $t$ has units of time (e.g., min), $k_0$ must have units of $\text{ng/mL/min}$ — concentration per unit time.

**Numerical example:** If $C_0 = 200\ \text{ng/mL}$ and $C(30) = 35\ \text{ng/mL}$ at $t = 30\ \text{min}$:
$$k_0 = \frac{200 - 35}{30} = 5.5\ \text{ng/mL/min}$$

**Biological examples of zero-order processes:**
- Alcohol metabolism (saturated enzymatic capacity)
- Zero-order input processes at steady state (e.g., constant-rate infusion)

Note: A system at steady state does not require zero-order input or output. Steady state simply requires that input rate equals output rate; both can be first-order processes.

### 6.2 First-Order Processes

A **first-order process** is one in which the rate of change of concentration is **proportional to the current concentration**:

$$-\frac{dC}{dt} = k_1 \cdot C$$

The rate depends on how much drug remains in the system at any given moment. As concentration decreases, the rate of elimination also decreases proportionally.

This is the basis for the standard monoexponential decline:

$$C(t) = C_0 \cdot e^{-k_1 t}$$

**Key distinction:**
- Zero-order: rate is constant, independent of concentration
- First-order: rate is proportional to the remaining concentration

Understanding this distinction is foundational for building and interpreting pharmacokinetic models. Both elimination and absorption can be zero-order or first-order, and the choice has significant implications for model structure.

---

## 7. Differential Equations in Pharmacokinetics

### 7.1 Introduction

The Noyes–Whitney equation describes the dissolution rate of a solid drug placed in a medium:

$$\frac{dA}{dt} = \frac{D \cdot S \cdot (C_s - C)}{h}$$

where $D$ is the diffusion coefficient, $S$ is the effective surface area, $C_s$ is the saturation concentration, $C$ is the bulk concentration, and $h$ is the thickness of the diffusion boundary layer. This is one of the foundational equations in pharmaceutical science — it describes how drug molecules leave the solid surface and enter solution, and underpins formulation design experiments such as membrane permeability studies.

In pharmacokinetics, the drug amount or concentration is the **dependent variable** and time is the **independent variable**.

### 7.2 Rules for Writing Differential Equations for Compartmental Models

There are four rules for constructing differential equations for a compartmental PK system:

1. **Number of equations:** The number of differential equations equals the number of compartments in the model.

2. **Number of terms:** The number of terms on the right-hand side of each differential equation equals the number of arrows (rate processes) touching that compartment.

3. **Sign of each term:** If an arrow points **into** the compartment, the corresponding term is **positive**. If an arrow points **out of** the compartment, the term is **negative**.

4. **Coefficients:** The coefficients of each term are determined by the rate constants (flow constants) associated with the arrows.

### 7.3 Example: One-Compartment Model

For a single compartment containing drug amount $X$ with first-order elimination:

$$\frac{dX}{dt} = -k_e \cdot X$$

**Unit check:**
- Left-hand side: $X$ in mg, $t$ in hr → $\text{mg/hr}$
- Right-hand side: $k_e$ in $\text{hr}^{-1}$, $X$ in mg → $\text{mg/hr}$ ✓

The arrow points out of the compartment, so the sign is negative. There is one arrow, so there is one term.

By convention, the elimination rate constant $k_e$ is written as $k_{10}$ (subscript notation: from compartment 1, to the outside, denoted 0):

$$\frac{dX}{dt} = -k_{10} \cdot X$$

### 7.4 Example: Two-Compartment Model

For a two-compartment model with bidirectional transfer between compartments 1 and 2:

- Transfer from compartment 1 to compartment 2: rate constant $k_{12}$
- Transfer from compartment 2 to compartment 1: rate constant $k_{21}$
- Elimination from compartment 1: rate constant $k_{10}$

The differential equations are:

$$\frac{dX_1}{dt} = -k_{10} \cdot X_1 - k_{12} \cdot X_1 + k_{21} \cdot X_2$$

$$\frac{dX_2}{dt} = k_{12} \cdot X_1 - k_{21} \cdot X_2$$

Extensions such as a feedback (recirculation) process within compartment 1 would add a term with rate constant $k_{11}$.

---

## 8. Integration and the Area Under the Curve (AUC)

### 8.1 Conceptual Basis of Integration

Integration in pharmacokinetics represents the summation of concentration over time. The AUC from time 0 to $T$ is formally defined as:

$$AUC_{0 \to T} = \int_0^T C_p(t)\, dt$$

Numerically, this is computed by dividing the time axis into small intervals $dt$, approximating the area under the curve in each interval, and summing all contributions.

### 8.2 The Linear Trapezoidal Rule

The most common numerical method for computing AUC in non-compartmental analysis (NCA) is the **linear trapezoidal rule**. For two adjacent concentration measurements $C_i$ and $C_{i+1}$ at times $t_i$ and $t_{i+1}$:

$$AUC_{t_i \to t_{i+1}} = \frac{(C_i + C_{i+1})}{2} \cdot (t_{i+1} - t_i)$$

This formula computes the area of the trapezoid formed by the two data points and the time axis. The total AUC is the sum of all such trapezoids. Extrapolation to infinity ($AUC_{0 \to \infty}$) uses the terminal elimination rate constant and will be covered in detail in the NCA lecture.

### 8.3 Note on Implementation

A basic implementation of the trapezoidal rule provides correct results for standard cases but does not account for all edge cases (e.g., missing data, below-quantification-limit observations, multiple dosing). The full NCA workflow with appropriate edge-case handling will be developed later in the course.

---

## 9. Summary

The mathematical foundations covered in this session — units and dimensionality, significant figures, logarithms and exponents, rate processes, differential equation construction, and integration — form the essential toolkit for pharmacokinetic analysis. These concepts will be referenced continuously throughout the course. Key takeaways:

- Always verify unit consistency on both sides of an equation.
- Fractions, ratios, and logarithms are dimensionless.
- Significant figures govern how results are reported; floating-point precision governs how they are computed — these are distinct concerns.
- First-order processes depend on remaining concentration; zero-order processes do not.
- Compartmental PK models are built from differential equations following four simple structural rules.
- AUC is computed numerically via the trapezoidal rule.

The next lecture will apply these principles to the intravenous bolus one-compartment model.
