# Week 2: Pharmacokinetics — One-Compartment IV Bolus Model

## Overview

This session covers the foundational concepts of pharmacokinetics (PK), beginning from first principles. The primary focus is the one-compartment model under intravenous (IV) bolus administration, which serves as the foundation for understanding the core PK parameters: clearance and volume of distribution.

---

## 1. Systemic Exposure

The term **systemic** refers to something present throughout the body. In pharmacokinetics, **systemic exposure** refers to the internal exposure of the body to a drug. It has two defining attributes:

- **Magnitude** — characterized by metrics such as maximum concentration (C_max)
- **Duration** — characterized by metrics such as half-life or area under the curve (AUC)

---

## 2. Measurement Matrices

Drug concentrations can be measured using both invasive and non-invasive methods.

### Invasive Methods
The most common invasive approach is the collection of blood for plasma concentration measurement.

### Non-Invasive Methods
Examples include measurement of drug concentrations in urine, breath, saliva, and milk.

### Biological Matrices Defined

| Matrix | Definition |
|---|---|
| **Whole Blood** | All components: red blood cells (RBCs), plasma, platelets, and clotting factors |
| **Plasma** | Whole blood minus RBCs (and other blood cells) |
| **Serum** | Plasma minus clotting factors |

In practice, **plasma concentration** is the primary measurement matrix in pharmacokinetics. The choice between blood, plasma, and serum depends on the physicochemical properties of the drug — for example, whether the drug binds to RBCs.

### Surrogate Concentrations and the Site of Action

In many cases, the drug's site of action is not directly accessible. For example, in tuberculosis research, the alveolar fluid in the lungs is the relevant site, but plasma is the practical sampling matrix. The relationship between the surrogate plasma concentration and the true site-of-action concentration must be established through modeling and mechanistic understanding.

---

## 3. Free Drug Hypothesis

### Bound vs. Unbound Drug

Drugs in plasma can exist in two forms:
- **Bound** — complexed to plasma proteins (plasma protein binding)
- **Unbound (free)** — not complexed; available for membrane crossing

Drugs in the body may also bind to tissues (tissue binding), which is distinct from plasma protein binding.

Only **free (unbound) drug** can cross biological membranes and therefore only the unbound drug can exert pharmacological activity.

### Two Principles of the Free Drug Hypothesis

1. **At steady state**, the unbound drug concentration on both sides of a membrane is equal. This assumes **passive diffusion** as the transport mechanism.

2. The **drug concentration at the site of action** — specifically the unbound concentration — is what drives pharmacological effect.

### Total vs. Unbound Concentration

In practice, what is typically measured is **total plasma concentration** (bound + unbound). However, using the concept of **fraction unbound (f_u)**, the unbound concentration can be estimated:

$$C_{\text{unbound}} = f_u \times C_{\text{total}}$$

The fraction unbound is experimentally determined and is drug-specific. Understanding f_u is critical for interpreting PK parameters, particularly volume of distribution and clearance, as only the unbound drug is available for metabolism and elimination.

---

## 4. Zero-Order vs. First-Order Processes

### Zero-Order Kinetics
A **constant amount** of drug is processed per unit time, independent of the amount remaining. On a linear scale, this appears as a straight line.

### First-Order Kinetics
A **constant fraction** of drug is processed per unit time. The rate of processing is proportional to the amount remaining in the body. This leads to an exponential decline in drug concentration.

- On a **linear scale**: the concentration-time profile is a curve.
- On a **log scale**: the concentration-time profile is a straight line.

---

## 5. One-Compartment IV Bolus Model

### Assumptions

The one-compartment IV bolus model is built on three key assumptions:

1. The drug enters the systemic circulation **rapidly** upon IV administration.
2. The drug is **instantaneously and uniformly distributed** throughout the body (the body is treated as a single homogeneous compartment).
3. The rate of **elimination follows a first-order process**.

### Differential Equation

The rate of change of drug amount in the body is:

$$\frac{dX}{dt} = -K \cdot X$$

where:
- $X$ is the amount of drug in the body
- $K$ (or $K_{el}$) is the **fractional elimination rate constant** (units: 1/time)

Equivalently, in terms of concentration:

$$\frac{dC}{dt} = -K \cdot C$$

This holds because dividing both sides of the amount equation by volume $V$ converts amount to concentration.

### Integrated (Closed-Form) Solution

Integrating the differential equation yields:

$$C(t) = C_0 \cdot e^{-K \cdot t}$$

where $C_0$ is the drug concentration at time zero (immediately after the IV bolus). This is the fundamental equation of the one-compartment IV bolus model.

---

## 6. Volume of Distribution

### Definition

**Volume of distribution (V)** is a **proportionality constant** that relates the amount of drug in the body to the measured plasma concentration at any given time:

$$V = \frac{X}{C} \implies C = \frac{\text{Dose}}{V}$$

Volume of distribution has **no direct physiological meaning** as a true anatomical volume. It simply scales the amount in the body to the observed concentration.

### Illustrative Example: Two Cylinders

Consider two identical 10-liter cylinders, each receiving 100 units of drug:

- **Cylinder A** (water only): Measured concentration = 10 units/L → Apparent V = 100/10 = **10 L**
- **Cylinder B** (water + charcoal that binds drug): Measured concentration = 1 unit/L → Apparent V = 100/1 = **100 L**

Both cylinders have the same physical volume (10 L), but the apparent volume in Cylinder B is 100 L because drug is sequestered by the charcoal. This illustrates that volume of distribution is an **apparent volume** determined by the measured (free) concentration, not the physical space.

This concept is directly relevant to pharmacokinetics: a drug with high tissue binding or lipophilicity will exhibit a large apparent volume of distribution because most drug is sequestered outside the sampling compartment (plasma), resulting in a low measured plasma concentration.

---

## 7. Clearance

### Introduction via the Differential Equation

Introducing clearance ($CL$) into the differential equation:

$$\frac{dC}{dt} = -\frac{CL}{V} \cdot C$$

This reveals the relationship:

$$K = \frac{CL}{V} \implies CL = K \cdot V$$

### Units and Interpretation

| Parameter | Unit | Interpretation |
|---|---|---|
| $K_{el}$ | 1/time (e.g., h⁻¹) | Fractional rate at which drug is eliminated |
| $V$ | volume (e.g., L) | Proportionality constant between amount and concentration |
| $CL$ | volume/time (e.g., L/h) | Volume of blood/plasma cleared of drug per unit time |

**Textbook definition of clearance:** The volume of blood or plasma that is completely cleared of its drug content per unit time.

### Rate of Elimination

Multiplying both sides of the differential equation by $V$:

$$\frac{dX}{dt} = -CL \cdot C$$

This defines the **rate of elimination**:

$$\text{Rate of elimination} = CL \times C$$

Units: mg/h = (L/h) × (mg/L). If the rate of elimination is plotted against concentration, the **slope is clearance**.

### Distinguishing Rate of Elimination from Fractional Elimination Rate Constant

| Concept | Symbol | Derived From | Units | Graphical Meaning |
|---|---|---|---|---|
| Fractional elimination rate constant | $K_{el}$ | Slope of ln(C) vs. time | h⁻¹ | Slope of log-concentration vs. time plot |
| Rate of elimination | $K_{el} \cdot X$ or $CL \cdot C$ | $dX/dt$; derived by scaling concentration equation by V | mg/h | Slope of rate vs. concentration plot |

Clearance is **independent of dose** in a linear (first-order) system. As dose increases, AUC increases proportionally, and the ratio $\text{Dose}/\text{AUC}$ remains constant.

---

## 8. Half-Life

### Definition

Half-life ($t_{1/2}$) is the time required for the drug concentration to decrease by 50%.

### Derivation

Starting from $K_{el} = \frac{\ln 2}{t_{1/2}}$, rearranging:

$$K_{el} \cdot t_{1/2} = \ln 2$$

Exponentiating both sides:

$$e^{K_{el} \cdot t_{1/2}} = 2$$

Taking the reciprocal:

$$e^{-K_{el} \cdot t_{1/2}} = \frac{1}{2} = 0.5$$

This confirms that at $t = t_{1/2}$, the concentration has decreased to exactly 50% of its initial value — a direct consequence of the first-order exponential equation, not an arbitrary definition.

$$\boxed{t_{1/2} = \frac{\ln 2}{K_{el}} = \frac{0.693}{K_{el}}}$$

Since $K_{el} = CL/V$, it follows that:

$$t_{1/2} = \frac{0.693 \cdot V}{CL}$$

Half-life increases with increasing volume of distribution and decreases with increasing clearance.

---

## 9. Area Under the Curve (AUC)

### Definition

AUC is the area under the plasma concentration-time curve from time zero to infinity:

$$\text{AUC}_{0 \to \infty} = \int_0^{\infty} C_0 \cdot e^{-K_{el} \cdot t} \, dt = \frac{C_0}{K_{el}}$$

### Relationship to Clearance

Substituting $C_0 = \text{Dose}/V$ and $K_{el} = CL/V$:

$$\text{AUC} = \frac{C_0}{K_{el}} = \frac{\text{Dose}/V}{CL/V} = \frac{\text{Dose}}{CL}$$

Therefore:

$$\boxed{CL = \frac{\text{Dose}}{AUC}}$$

This is one of the most important equations in pharmacokinetics. It states that clearance can be estimated from the administered dose and the observed AUC. For a linear system, doubling the dose doubles the AUC, leaving clearance unchanged.

### Numerical Estimation: Trapezoidal Rule

AUC can also be computed numerically by dividing the concentration-time profile into trapezoids, computing the area of each, and summing them. This method (non-compartmental analysis, or NCA) does not require assuming a compartmental model.

---

## 10. Volume of Distribution and the Free Drug Hypothesis

The total volume of distribution can be decomposed in terms of the unbound fraction:

$$V = \frac{X}{C} = \frac{X_u/f_u}{C_u/f_u} = V_u \cdot \frac{C_u}{C} = V_u \cdot f_u$$

Wait — more precisely, the relationship shows that the total observed volume of distribution is modulated by the fraction unbound ($f_u$). Because only unbound drug crosses membranes, changes in plasma protein binding (and hence $f_u$) directly affect both the apparent volume of distribution and clearance. These implications are discussed further in the volume of distribution and multiple-dosing lectures.

---

## 11. Summary: IV Bolus One-Compartment Model

Given an IV bolus dose and measured plasma concentrations over time, the analysis proceeds as follows:

1. **Plot** log-concentration vs. time — this yields a straight line.
2. **Slope** = $-K_{el}$
3. **Intercept** = $\ln(C_0)$, where $C_0 = \text{Dose}/V$
4. **Derived parameters:**
   - $t_{1/2} = \ln 2 / K_{el}$
   - $V = \text{Dose} / C_0$
   - $CL = K_{el} \times V$
   - $\text{AUC} = C_0 / K_{el} = \text{Dose} / CL$

### The Fundamental Equation

$$\boxed{C(t) = C_0 \cdot e^{-\frac{CL}{V} \cdot t}}$$

All basic one-compartment PK concepts — half-life, clearance, volume, AUC — are embedded in this single equation. More complex PK models (multi-compartment, non-linear, multiple dosing) extend from this foundation.

---

## 12. Looking Ahead

The next lectures will cover **volume of distribution** and **clearance** in detail, including:

- Physiological determinants of volume (lipophilicity, tissue binding, protein binding)
- Physiological determinants of clearance (hepatic blood flow, intrinsic clearance — the well-stirred model)
- Non-linear (saturable) pharmacokinetics
- Multiple dosing and accumulation
- The impact of fraction unbound on steady-state concentrations

Pre-reading materials on volume of distribution will be distributed prior to the next session. Students are encouraged to (1) discuss lecture concepts with peers, (2) review the provided lecture notes, and (3) reinforce learning with a pharmacokinetics textbook of their choice.
