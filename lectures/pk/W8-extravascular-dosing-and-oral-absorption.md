# Pharmacokinetics: Extravascular Dosing and Oral Absorption

## Overview

This session covers extravascular (EV) dosing, with a focus on oral administration. Four lectures remain in this pharmacokinetics course, covering the fundamentals. The present session and part of the next address extravascular dosing; the final sessions will cover intravenous infusions. Together, these topics complete the coverage of all major routes of administration and the fundamentals of elimination.

Supplemental lectures on biopharmaceutical principles — required for a deeper understanding of oral absorption — will be provided separately by subject-matter experts.

---

## 1. Extravascular Dosing: Introduction

Extravascular doses are more common in clinical practice than intravenous (IV) doses. They can be broadly classified as:

- **Immediate release (IR):** Drug is released rapidly; formulation type (tablet, capsule) is secondary.
- **Modified release (MR):**
  - *Extended release:* Prolongs the release of drug over time.
  - *Delayed release:* Delays entry of drug into the systemic circulation.

The choice of formulation type is driven by the **Target Product Profile (TPP)**: Does the indication require a rapid onset of exposure, or a sustained concentration over time? These questions guide formulation strategy early in drug development.

---

## 2. Determinants of the Oral Pharmacokinetic Profile

After oral administration, the plasma concentration-time curve is determined by two fundamental factors:

1. **Rate of absorption** — how quickly the drug enters the systemic circulation.
2. **Extent of absorption** — how much of the administered dose ultimately reaches the systemic circulation.

These concepts connect directly to earlier course material: rate and extent also appear in the context of distribution (e.g., rate of distribution, volume of distribution as the extent of distribution).

### 2.1 Steps Required for Oral Absorption

For a drug to be absorbed after oral administration, it must undergo:

1. **Disintegration** of the dosage form
2. **Dissolution** of the drug into solution
3. **Permeation** across the gastrointestinal membrane

Permeation is governed by **Fick's First Law of Diffusion**, which states that the rate of transport across a membrane is proportional to the concentration gradient, the surface area, and inversely proportional to the membrane thickness. Properties such as molecular size, lipophilicity, and charge all factor into permeability.

---

## 3. First-Order Absorption Kinetics

### 3.1 The Absorption Rate Constant (k_a)

Oral absorption generally follows **first-order kinetics**, analogous to first-order elimination. Just as there is a first-order elimination rate constant K_el, there is a first-order absorption rate constant **k_a**.

The **absorption half-life** is given by:

$$t_{1/2,a} = \frac{0.693}{k_a}$$

The **rate of absorption** at any time is:

$$\text{Rate of absorption} = k_a \cdot A$$

where $A$ is the amount of drug remaining to be absorbed (i.e., remaining in the depot compartment).

### 3.2 Why Amounts Are Used for Absorption, But Concentrations for Elimination

An important distinction: when describing the rate of elimination, we use **clearance × concentration** (CL × C), whereas for absorption we use **k_a × amount** (k_a × A). This is because:

- We measure **plasma concentration** directly; we do not measure concentration in the depot compartment.
- Without a measurable concentration in the depot, there is no basis for defining a volume of distribution for that compartment.
- Clearance and volume of distribution are physiologically meaningful parameters precisely because they relate to **observed** concentrations in the plasma.

This distinction reflects a general principle: clearance is a proportionality constant relating the rate of elimination to the observed plasma concentration, just as volume of distribution is a proportionality constant relating the amount in the body to the plasma concentration.

### 3.3 Rate of Emptying from the Depot

The rate of emptying of the depot compartment declines **monoexponentially** over time. On a log scale, this appears as a straight line. The key insight is:

- **k_a is constant** throughout the process — it is the fractional rate constant.
- The **rate** (k_a × A) decreases because the amount A remaining in the depot decreases over time.
- This is analogous to a bucket emptying through a hole: the hole size (k_a) is fixed, but the flow rate decreases as the water level (A) falls.

### 3.4 Fractional Rate Constants

Both k_a and K_el are called **fractional rate constants** because they represent the fraction of drug transferred or removed per unit time. The units are therefore inverse time (e.g., h⁻¹).

**Example:** If K_el = 0.1 h⁻¹, then 10% of the drug present is eliminated per hour. Starting with 100 mg at time zero, 90 mg remains at 1 hour, 81 mg at 2 hours, and so on — the fraction removed is constant, but it applies to a continuously decreasing amount.

### 3.5 Zero-Order Absorption

Drug absorption can also follow **zero-order kinetics** — that is, be independent of the amount remaining to be absorbed. Examples include:

- **Sustained-release (modified-release) oral formulations**, where the release rate from the dosage form itself is constant, making the amount available for absorption constant.
- **Transdermal patches** and **depot implants**, which deliver drug at a controlled, constant rate.

On a linear scale, zero-order release is a straight line; first-order shows a curved decline. On a log scale, first-order becomes linear while zero-order curves.

---

## 4. One-Compartment Model with First-Order Oral Absorption

### 4.1 Model Structure

The standard model for oral pharmacokinetics is described as a **one-compartment model with first-order absorption and first-order elimination**. Although this appears to involve two compartments (a depot and a central compartment), the convention is that **compartmental classification refers only to distribution within the body** — not to the absorption site. The depot is the site of drug input, not a true systemic compartment.

### 4.2 Differential Equations

The system is described by two differential equations:

**Depot compartment:**
$$\frac{dA_{depot}}{dt} = -k_a \cdot A_{depot}$$

**Central compartment:**
$$\frac{dA}{dt} = k_a \cdot A_{depot} - K_{el} \cdot A$$

Here, $A_{depot}$ is the amount remaining to be absorbed, and $A$ is the amount in the central (systemic) compartment.

---

## 5. Comparison of IV and Oral Administration

Comparing IV and oral profiles for the same dose provides key conceptual insights.

### 5.1 Key Differences

| Feature | Intravenous | Oral |
|---|---|---|
| Amount in central compartment at $t = 0$ | Full dose | Zero |
| T_max | Near zero (essentially instantaneous) | Later, determined by absorption kinetics |
| C_max | Generally higher | Generally lower |

### 5.2 Why C_max is Lower After Oral Dosing

Even if bioavailability (F) is 100%, **C_max after oral dosing is lower than after IV dosing** for the same dose. The reason is that absorption and elimination occur **simultaneously**. As drug gradually enters the systemic circulation, it is also being eliminated. By the time absorption is complete, a fraction of the drug has already been cleared. This is in contrast to IV administration, where the full dose is immediately present in the central compartment.

### 5.3 The Oral Concentration Sometimes Exceeds the IV Concentration Post-C_max

After the oral C_max, the oral concentration may exceed the IV concentration at the same time point. This occurs because absorption is still ongoing after C_max — drug continues to enter the system, partially offsetting the decline due to elimination.

### 5.4 C_max Occurs at Equilibrium

**At C_max, the rate of absorption equals the rate of elimination.** This is a steady-state condition for the oral profile:

$$\text{Rate of absorption} = \text{Rate of elimination at } C_{max}$$

### 5.5 Estimating k_a from T_max

By analogy with half-life reasoning, **T_max approximates four to five absorption half-lives** (the time to approach steady state for the absorption process). This provides a useful initial estimate of k_a:

$$t_{1/2,a} \approx \frac{T_{max}}{4}$$

$$k_a \approx \frac{0.693}{t_{1/2,a}}$$

**Example:** If T_max = 1 hour, then one absorption half-life ≈ 0.25 hours, and:

$$k_a \approx \frac{0.693}{0.25} \approx 2.77 \text{ h}^{-1}$$

---

## 6. Bioavailability and the Fundamental Oral PK Equation

### 6.1 Deriving the Oral Clearance Equation

Starting from the IV relationship:

$$\text{Dose}_{IV} = CL \cdot AUC_{IV}$$

For extravascular dosing:

$$F \cdot \text{Dose}_{EV} = CL \cdot AUC_{EV}$$

where $F$ is the bioavailability fraction — the fraction of the oral dose reaching the systemic circulation. Dividing these two expressions gives:

$$F = \frac{AUC_{EV}}{AUC_{IV}} \times \frac{\text{Dose}_{IV}}{\text{Dose}_{EV}}$$

This is the equation for **absolute bioavailability**. The more general form of the clearance equation is:

$$CL = \frac{F \cdot \text{Dose}}{AUC}$$

This is one of the most important equations in oral pharmacokinetics.

### 6.2 Absolute vs. Relative Bioavailability

- **Absolute bioavailability:** Compares oral AUC to IV AUC (reference = IV).
- **Relative bioavailability:** Compares two oral formulations; the reference formulation appears in the denominator.

---

## 7. Absorption and Disposition Rate Limitations

### 7.1 Disposition Rate-Limited Absorption (k_a >> K_el)

When the absorption rate constant is much greater than the elimination rate constant:

- The drug is absorbed rapidly and a distinct, sharp absorption phase is followed by a typical elimination phase.
- The **terminal half-life** estimated from the elimination phase accurately reflects K_el.
- This is the standard case for most immediate-release oral formulations.

As absorption half-life increases (k_a decreases but is still > K_el), T_max shifts later and C_max decreases — though AUC remains unchanged if F and CL are constant. The curve broadens to maintain the same total exposure.

### 7.2 Absorption Rate-Limited Absorption (K_el >> k_a) — Flip-Flop Kinetics

When the elimination rate constant is much greater than the absorption rate constant:

- Elimination is rapid relative to absorption.
- The **terminal slope of the oral concentration-time curve reflects k_a, not K_el** — hence the name "flip-flop kinetics."
- The true elimination half-life cannot be identified from the oral profile alone because the absorption and elimination phases cannot be distinguished.
- At C_max, and throughout much of the profile, the rate of absorption approximately equals the rate of elimination.

**Classic examples of flip-flop kinetics:**
- Long-acting injectable formulations
- Depot implants
- Any formulation designed to slow drug release over an extended period

To obtain unbiased estimates of K_el in these cases, IV data or appropriate reference formulations must be used.

### 7.3 Deconvolution: Separating Absorption from Elimination

To differentiate absorption from disposition, one of the following is needed:

1. **An IV formulation of the same drug** — provides a direct estimate of the true disposition (K_el, CL, V).
2. **A solution or immediate-release reference formulation** — an oral solution approximates the fastest possible absorption and can serve as a unit impulse response to deconvolve absorption from the observed PK profile.
3. **Multiple release-rate formulations** — studying the same drug with formulations of varying release rates allows separation of the absorption and elimination components, since only the absorption changes across formulations while elimination remains constant.

This principle underpins **in vitro–in vivo correlation (IVIVC)** and **physiologically based absorption modeling (PBAM/PBPK-absorption)**.

---

## 8. Effect of Changes in Dose, Absorption Kinetics, and Disposition Parameters

### 8.1 Changes in Dose

For a drug with linear (dose-proportional) PK:

- AUC and C_max increase proportionally with dose.
- **T_max does not change** with dose.

### 8.2 Changes in Absorption Kinetics (k_a)

- Increasing k_a shifts T_max earlier and increases C_max (while AUC remains constant if F is unchanged).
- Decreasing k_a shifts T_max later and decreases C_max (AUC remains constant).
- T_max and C_max are sensitive to k_a; AUC is primarily determined by F and CL.

### 8.3 Changes in Clearance

- Doubling CL: C_max decreases, AUC decreases, T_max is unchanged, terminal half-life decreases.
- Halving CL: C_max increases (or stays similar), AUC increases, terminal half-life increases.
- Causes of altered clearance: drug-drug interactions, disease states, genetic polymorphisms.

### 8.4 Rate vs. Extent of Absorption

A critical distinction:

- **Rate of absorption** (determined by k_a) governs the **shape** of the rising phase and hence **C_max** (and T_max).
- **Extent of absorption** (determined by F, the bioavailability) governs the **total exposure** and hence **AUC**.

**Example — gut wall metabolism:** If 3 out of 10 molecules are metabolized in the gut wall before entering the portal circulation, the effective dose reaching the liver is 7 molecules. This reduces the **extent** of absorption (F decreases), lowering AUC. The amount available for absorption at the gut wall is also lower, which reduces the rate of absorption in absolute terms (even if k_a itself is unchanged) — resulting in a lower and potentially later C_max.

When designing formulations or conducting bioequivalence studies, the rate of absorption must be preserved (same k_a or same absorption profile) and the extent (same F) must be preserved to demonstrate equivalent systemic exposure.

---

## 9. Summary of Key Concepts

| Concept | Key Relationship |
|---|---|
| Absorption half-life | $t_{1/2,a} = 0.693 / k_a$ |
| Rate of absorption | Rate $= k_a \cdot A_{depot}$ |
| T_max approximation | $T_{max} \approx 4 \text{–} 5 \times t_{1/2,a}$ |
| C_max condition | Rate of absorption = Rate of elimination |
| Bioavailability equation | $F = (AUC_{EV} / AUC_{IV}) \times (Dose_{IV} / Dose_{EV})$ |
| Clearance (oral) | $CL = F \cdot Dose / AUC$ |
| Disposition rate-limited | $k_a >> K_{el}$; terminal slope reflects K_el |
| Absorption rate-limited (flip-flop) | $K_{el} >> k_a$; terminal slope reflects k_a |

---

## 10. Looking Ahead

The next session will cover:

- First-pass metabolism and pre-systemic loss
- Additional absorption principles
- Introduction to intravenous infusion kinetics

These topics will complete the foundational pharmacokinetic framework built across this course, grounded in the concepts of membrane permeability, volume of distribution, and clearance introduced in earlier sessions.
