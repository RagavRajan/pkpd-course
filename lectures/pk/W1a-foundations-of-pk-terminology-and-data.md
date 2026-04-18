# Week 1 Pharmacokinetics — Lecture 1: Foundations of PK Terminology and Data

## Course Overview

This is a 13–14 week program focused on the first principles and fundamentals of pharmacokinetics, with an emphasis on real-world application mapping. The goal is not only to understand equations and concepts, but to consistently map those concepts back to practical applications in drug development.

### Course Structure

- Two-hour teaching sessions every Sunday (10:00–12:00)
- Sessions will be recorded with corresponding detailed notes provided
- Weekly practice problems will be distributed after each session
- Computational work will be conducted in Pumas (Julia-based); course materials are prepared as Quarto markdown documents with Julia tutorials

### Course Scope

The course covers pharmacokinetics only — population PK modeling is introduced separately, at least six to eight months later. The intended progression is: PK fundamentals → advanced statistics → pharmacometric modeling. Topics to be covered include:

1. Basic mathematics for pharmacokinetics
2. One-compartment models (IV bolus)
3. Volume of distribution and clearance
4. Constant-rate intravenous infusions
5. Extravascular administration and biopharmaceutical considerations
6. Multiple dosing concepts
7. Non-linear pharmacokinetic systems
8. Non-compartmental analysis (NCA)
9. Allometric scaling

---

## Fundamental Terminology: Variables, Parameters, and Constants

### The Concentration–Time Relationship

Consider a concentration–time profile following an IV bolus dose. This profile is described by the monoexponential equation:

$$C(t) = \frac{\text{Dose}}{V} \cdot e^{-k_e \cdot t}$$

where $C(t)$ is plasma concentration at time $t$, $V$ is volume of distribution, and $k_e$ is the elimination rate constant. This equation serves as the starting point for discussing the precise meaning of variables, parameters, and constants.

### Dependent and Independent Variables

In any mathematical relationship:

- **Dependent variable** (y-axis): the quantity that changes as a result of other quantities in the system. In pharmacokinetics, plasma concentration $C(t)$ is the dependent variable — it changes within an individual over the course of a study.
- **Independent variable** (x-axis): the quantity whose value is set or predefined by the investigator. Time after drug administration is the independent variable in PK studies, because the sampling time points are selected by the study designer. Similarly, in a body weight regression, body weight is the independent variable.

### Parameters

A parameter is a numerical quantity that defines the relationship between the independent and dependent variables within a given model. In the equation above, $k_e$ and $V$ are parameters. They are estimated from observed data and, within the context of a given model and individual, are treated as fixed quantities.

An important nuance: a parameter is constant within the context of a specific model. For example, if $k_e$ is estimated as 0.02 h$^{-1}$ for a particular individual, that value is constant within that model. This is distinct from the philosophical question of whether parameters vary across individuals or populations.

### Constants

A constant is a value that is not estimated from the data at hand but is instead held fixed, often derived from prior knowledge or separate experiments. A commonly cited example is hepatic blood flow (~1.5 L/hr/kg), which is treated as a physiological constant in many PK models even though it was itself derived from experimental measurement.

**Key distinction**: A parameter can also be a constant. Physiological values that are fixed in a model (e.g., organ blood flow rates in PBPK models) are treated as constants, but they originated as parameters estimated from experimental data. This distinction is frequently misrepresented in the literature and should be applied carefully when reading and writing scientific work.

---

## Data, Information, and Errors in Pharmacokinetics

### What Constitutes Data

Measured concentration values at specific time points constitute pharmacokinetic data. Concentration alone, without temporal or contextual reference, carries limited scientific value. Data becomes meaningful when one quantity can be related to another — for example, concentration as a function of time, or drug exposure as a function of body weight.

This principle becomes especially important in physiologically-based pharmacokinetic (PBPK) modeling, where isolated measurements without physiological context can be uninformative.

### The Concept of Error

In the context of pharmacokinetic modeling, **error** refers to the difference between what is observed (measured data) and what is predicted by the model. However, the concept of error is broader than model residuals:

1. **Measurement error in the dependent variable**: When a bioanalytical method measures a plasma concentration of 10 ng/mL, there is inherent assay error. Bioanalytical method validation defines an acceptable error range (e.g., within 15–20% of nominal), and concentrations are accepted as long as they fall within this range.

2. **Error in the independent variable**: Time of sample collection is typically assumed to be exact, but in practice, a nominal two-hour time point may actually be collected at two hours and five minutes. This deviation is generally assumed to be negligible, but it is error nonetheless.

3. **Error in covariates**: Quantities such as body weight are often treated as if measured without error (e.g., from a home scale of uncertain calibration), but true measurement error exists.

The key principle is that **all data contain error**. The appropriate response is not to ignore error, but to understand its magnitude and assess its impact on the conclusions being drawn. Identifying and characterizing errors in pharmacokinetic data — before fitting any model — is a critical and often underappreciated step in the analysis workflow.

> Errors is not just about residuals in your model. It is about being cognizant of the data you collect, the information you are seeing, and how you interpret that information before you proceed to modeling.
