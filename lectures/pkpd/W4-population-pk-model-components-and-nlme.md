# Week 4: Components of a Population PK Model and the NLME Framework

## Overview

This lecture covers two main topics: (1) the components of a population PK model, broken down systematically, and (2) how these components map to the Nonlinear Mixed Effects (NLME) framework. The motivating context is the modeling of concentration-versus-time data using a one-compartment intravenous bolus model.

---

## 1. The Three Components of a Model

Any population PK model — and more broadly, any pharmacometric model including exposure-response and clinical endpoint models — is built on three foundational submodels:

1. **Structural submodel**
2. **Variability submodel**
3. **Covariate submodel**

These three components form the cornerstone of all population modeling analyses. The remainder of this lecture focuses on the first two.

---

## 2. The Structural Submodel

### 2.1 Definition

The structural submodel defines the core underlying mechanism of the model. In PK and PKPD modeling, this corresponds to model types such as one-compartment, two-compartment, or indirect response models. These models are governed by differential equations. For example, for a one-compartment IV bolus model:

$$\frac{d(\text{Central})}{dt} = -\frac{CL}{V} \cdot \text{Central}$$

### 2.2 Structural Parameters

The structural submodel contains **structural parameters** — physiologically interpretable parameters such as clearance (CL), volume of distribution (V), and absorption rate constant (K_a). Depending on the context of the analysis, these may be referred to as either population parameters or individual parameters.

Structural parameters have the following key properties:

- **Physiological interpretability:** They are abstractions of known physiological processes.
- **Natural bounds:** They are constrained by physiology. Clearance and volume cannot be negative; K_a cannot be arbitrarily large.
- **Population distribution:** Within a population, these parameters follow a statistical distribution.
- **Potential correlations:** Parameters may be correlated with one another (e.g., CL and V may or may not be correlated depending on the system). Whether such correlations are physiologically meaningful is an important modeling consideration.
- **Known or unknown status:** Parameters may be fixed to previously estimated values or treated as unknowns to be estimated from the data. In most analyses, the goal is for the software to estimate these parameters.

---

## 3. The Variability Submodel

### 3.1 Between-Subject Variability (BSV) and the ETA Distribution

To move from population parameters to individual parameters, one must assume a distribution governing how individual parameters are scattered around the population mean. This spread is called **between-subject variability (BSV)**, also referred to as **inter-individual variability (IIV)**.

The difference between an individual's parameter and the population mean is captured by a random variable denoted **η** (eta), which is assumed to follow a normal distribution:

$$\eta_i \sim \mathcal{N}(0, \omega^2)$$

where $\omega$ is the standard deviation of the η distribution. By convention, the mean of the η distribution is zero — η represents a *deviation* from the population mean, not an absolute value.

#### Interpretation on the Concentration-Time Curve

Consider a mean (population) concentration-time curve. Subjects whose clearance is lower than the population mean will lie *above* the mean curve (slower elimination), while subjects with higher clearance will lie *below* it. A negative η for clearance corresponds to a subject with lower-than-average clearance and a higher-than-average concentration profile.

#### The Role of the Software

A critical principle: **η will be whatever it needs to be to match the observed data.** The software does not have knowledge of the underlying physiology or experimental conditions. Given a dataset, the optimizer will sample and resample η until the individual prediction is as close as possible to the observed data. If a subject has an unusual profile, the software will assign an extreme η to capture that profile — even if this η falls far outside the assumed normal distribution.

This is a common source of misinterpretation. The optimizer does not flag unusual η values as problematic; it simply produces the η that minimizes the objective function.

### 3.2 ETA Shrinkage and Regression to the Mean

The assumption underlying the η distribution is that individual parameter deviations are normally distributed. In practice, this assumption can be violated for several reasons:

1. **Natural variability:** The drug or population is inherently highly variable.
2. **Experimental design issues:** Insufficient sampling means the model cannot estimate reliable individual parameters.
3. **Model misspecification:** The distributional assumption itself is incorrect.

When sampling is sparse (e.g., only two time points per subject), the software lacks sufficient information to estimate a subject's individual η. In this case, the software "borrows" information from the population and assigns an η close to zero — effectively treating the subject as a typical subject. When this phenomenon occurs systematically across many subjects, the empirical η distribution collapses toward zero, becoming more peaked than the assumed normal distribution. This phenomenon is called **η shrinkage**, which is the NLME equivalent of the statistical concept of **regression to the mean**.

η shrinkage serves as a diagnostic indicator: high shrinkage suggests that the model is not well-supported by the data and that individual parameter estimates should be interpreted with caution.

#### A Note on the Mean of the ETA Distribution

The theoretical mean of the η distribution is zero, because η represents deviations from the population mean and the mean of deviations is zero by construction. In practice, the empirical mean of estimated ηs may deviate slightly from zero (e.g., 0.001 or −0.02), which is assessed via the **η-bar test** (testing $\bar{\eta} = 0$). On average, across a well-specified model and adequate data, the empirical mean will be close to zero.

### 3.3 Residual Unexplained Variability (RUV) and the Epsilon Distribution

Even after accounting for between-subject variability through the η distribution, differences remain between the individual-level model predictions and the observed data at each time point. These residual differences are captured by a second random variable, **ε** (epsilon):

$$\varepsilon_{ij} \sim \mathcal{N}(0, \sigma^2)$$

where $i$ indexes the subject and $j$ indexes the time point. The ε distribution has mean zero and standard deviation σ. At each time point, the software picks an ε from this distribution to account for the gap between the individual prediction and the observation.

This residual variability is called **Residual Unexplained Variability (RUV)** because it represents the portion of variability that cannot be explained after accounting for the η distribution.

Sources of RUV include:
- Bioanalytical assay variability (measurement error)
- Sampling and experimental design errors
- Model misspecification (structural or statistical)

### 3.4 Types of Residual Error Models

The nature of σ — and hence the ε distribution — can take three forms, motivated by the behavior of assay variability:

#### Additive Error

$$\sigma_{\text{add}}$$

The standard deviation is constant across all concentration levels. The units of σ are the same as the units of concentration. On a plot of standard deviation versus concentration, this appears as a flat horizontal line. On a plot of percent coefficient of variation (CV%) versus concentration, this appears as a decreasing curve (since CV% = SD/mean, and the mean increases with concentration while SD remains constant).

#### Proportional Error

$$\sigma_{\text{prop}} \cdot C_p$$

The standard deviation is proportional to the concentration. As concentration increases, the standard deviation increases proportionally. On a plot of standard deviation versus concentration, this appears as an upward-sloping line. On a plot of CV% versus concentration, this appears as a flat horizontal line (since the proportional relationship between SD and mean is constant).

#### Combined (Additive + Proportional) Error

$$\sigma_{\text{add}} + \sigma_{\text{prop}} \cdot C_p$$

The standard deviation is additive at low concentrations and proportional at higher concentrations. This model captures the behavior commonly observed in bioanalytical assays, where imprecision near the lower limit of quantification is approximately constant, while imprecision at higher concentrations grows proportionally.

#### Connection to Bioanalytical Assay Variability

The reference standard curve in a bioanalytical assay provides an a priori estimate of measurement variability. If the percent CV of the standard curve is, for example, 12%, and the estimated RUV from the model is 34%, then approximately 12% can be attributed to bioanalytical measurement error. The remaining 22% is truly unexplained variability — variability that cannot be attributed to known sources, hence the designation "unexplained."

---

## 4. Assumptions and Diagnostics

All three sources of variability discussed above rest on distributional assumptions. A key reference on this topic is:

> Mascal and Low-China (1993): *Assumption Testing in Pharmacometrics* — which enumerates 22 common assumptions in NLME modeling and discusses how to evaluate whether those assumptions hold.

Violations of assumptions can arise from natural variability, experimental design choices, or model misspecification. **Diagnostic plots and tables** are the primary tools for identifying assumption violations. Examples include:

- **η shrinkage:** Indicates poor information content for individual parameter estimation.
- **η-bar test:** Checks whether the mean of the η distribution deviates significantly from zero.
- **Goodness-of-fit plots:** Visualize the agreement between observed data and model predictions.
- **Residual plots:** Assess whether the ε distribution matches its assumed normal form.

---

## 5. Summary and Looking Ahead

This lecture introduced the three components of a population PK model (structural, variability, and covariate submodels) and examined the first two in detail:

- The **structural submodel** defines the physiological mechanism and contains structural parameters with natural bounds and population distributions.
- The **variability submodel** contains two levels of random effects:
  - **η (ETA):** Between-subject variability, assumed $\mathcal{N}(0, \omega^2)$
  - **ε (epsilon):** Residual unexplained variability, assumed $\mathcal{N}(0, \sigma^2)$, with additive, proportional, or combined error structures.

**Required reading before next class:** Chapter 4 (*Variability and Transformation*) of Bonate's pharmacometrics textbook.

**Discussion question for next class:** For each of the three residual error models (additive, proportional, and combined), how does the percent CV plot look as a function of concentration, and what does this reveal about the nature of σ in each case?

The **covariate submodel** will be covered after the NLME mapping is completed in a future session.

---
