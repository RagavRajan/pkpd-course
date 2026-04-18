# Population PK Modeling: Base Model Construction, Model Diagnostics, and Likelihood-Based Model Comparison

## Review: Components of a Population PK Model

As established in previous sessions, a population PK model comprises three primary components:

1. **Structural component** — the mathematical model describing the system (e.g., one-compartment, two-compartment, three-compartment, indirect response, or linear regression models)
2. **Variability component** — between-subject variability (BSV/IIV) and residual unexplained variability (RUV)
3. **Covariate component** — factors that explain inter-individual variability

---

## Goals of Population PK Modeling

The overarching goal of population PK modeling is to **explain variability** by identifying the factors that cause it. This process yields:

- Accurate predictions of the pharmacokinetic behavior under study
- Identification of physiologically or clinically meaningful covariates
- A model capable of simulating alternate or future scenarios

### Descriptive vs. Predictive Models

Models can be broadly classified as either **descriptive** or **predictive**:

- A **descriptive model** fits the observed data; the analysis ends there.
- A **predictive model** is one with validated predictive performance — it is the basis for simulating future scenarios or informing clinical decisions.

In practice, descriptive models serve primarily as a stepping stone toward building a model that is predictive in nature. The utility of any model is ultimately realized through its ability to forecast outcomes — analogous to a weather forecast, which is only useful if it supports decision-making.

---

## Gaining Confidence in a Model

Before a model is used for simulation or decision-making, confidence in its structure and parameters must be established. The following criteria contribute to model confidence:

### 1. Correlation Between Observed and Predicted Values
Observations and model predictions should be well correlated.

### 2. Physiological and Clinical Plausibility
Parameter estimates must be physiologically plausible. For example, a clearance estimate of 600 L/h would warrant serious scrutiny.

### 3. Parameter Precision
Parameters should be estimated with sufficient precision, expressed as standard error (SE), relative standard error (RSE), or confidence intervals. High RSE (e.g., 150%) undermines confidence in an otherwise plausible estimate.

### 4. Distributional Assumptions
Assumptions embedded in the model must be verified. If the random effects (ETAs) are assumed to be normally distributed but the empirical distribution is clearly non-normal, that assumption is violated and must be addressed. Similarly, if residuals (epsilons) are assumed to be normally distributed with mean zero and standard deviation σ, deviations from this assumption indicate a model misspecification.

### 5. Reproducibility
Model results should be reproducible. Reproducibility is a foundational requirement of scientific rigor.

### 6. Robustness
A model is considered robust if its parameter estimates are insensitive to the choice of initial estimates. For example, if different starting values for clearance (e.g., 5 vs. 7.5 vs. 55) all converge to the same final estimate, this reflects numerical stability. It is important to distinguish robustness (insensitivity to initial conditions) from assumption testing — these are conceptually distinct.

The full set of metrics and plots used to evaluate these criteria is collectively referred to as **model diagnostics**.

---

## The Base Model

Before incorporating covariates, a **base model** must be established. The base model combines:

- The **structural model**
- The **variability model** (BSV and RUV)

without any covariate terms. The base model determines how much of the variability in the data can be captured by the structural and statistical assumptions alone. Once a satisfactory base model is identified, covariates can be introduced to explain the remaining unexplained variability.

In the modeling workflow, the base model corresponds to the stage where one-compartment and two-compartment models (or other structural forms) are compared before proceeding to covariate analysis.

---

## Model Diagnostics

Diagnostics are used to evaluate and compare models. They fall into two categories:

- **Numerical diagnostics** — quantitative metrics (e.g., log-likelihood, AIC, BIC, RSE)
- **Graphical diagnostics** — visual tools (e.g., observed vs. predicted plots, VPCs, residual plots)

Both types are applied to each candidate model; models are then compared statistically, physiologically, and clinically — and in terms of fitness for the question being answered.

### Fit-for-Purpose Models

In some modeling contexts, the primary goal is to support a specific decision (e.g., study design). In these cases, the model need not be fully mechanistic. Fit-for-purpose models may incorporate pragmatic assumptions where data are insufficient to fully characterize a given component, provided the model reliably supports the decision at hand.

---

## Information Flow Inside a Pumas Model

The following describes the complete mathematical and computational workflow for a one-compartment IV bolus model in Pumas.

### Structural Model

The system is described by a single differential equation:

$$\text{central}' = -\frac{CL}{V_C} \cdot \text{central}$$

This is the **dynamics block** in Pumas.

### Population and Individual Parameters (pre block)

The individual clearance and volume are assumed to be log-normally distributed:

$$CL_i = \theta_{CL} \cdot e^{\eta_{CL,i}}$$
$$V_{C,i} = \theta_{V_C} \cdot e^{\eta_{V_C,i}}$$

where:
- $\theta_{CL}$ and $\theta_{V_C}$ are the population (typical) values of clearance and volume
- $\eta_{CL,i}$ and $\eta_{V_C,i}$ are individual random effects, assumed to follow:

$$\eta_{CL} \sim \mathcal{N}(0, \omega_{CL}^2), \quad \eta_{V_C} \sim \mathcal{N}(0, \omega_{V_C}^2)$$

These equations belong to the **pre block** in Pumas. The pre block must be specified before the dynamics block, as the individual parameters it computes are required inputs to the differential equation.

### Parameters to Optimize (param block)

The unknown parameters to be optimized are:

$$\theta_{CL}, \quad \theta_{V_C}, \quad \omega_{CL}, \quad \omega_{V_C}$$

These are declared in the **param block**, where each parameter is given a lower bound, upper bound, and initial estimate. Any parameter declared in the param block is submitted to the optimizer.

### Random Effects (random block)

The distributional assumptions for the random effects $\eta_{CL}$ and $\eta_{V_C}$ are declared explicitly in the **random block**.

### From Amount to Concentration (derived block)

The differential equation yields `central`, the **amount** of drug over time. Because the observed data are concentrations, the solution must be scaled:

$$CP_{ij} = \frac{\text{central}_{ij}}{V_{C,i}}$$

In Julia/Pumas, since `central` is a vector (over time points) and $V_C$ is a scalar (per individual), broadcasting is used:

```julia
CP = @. central / VC
```

This predicted concentration $CP_{ij}$ is computed in the **derived block**.

### Residual Error Model

The observed dependent variable $DV_{ij}$ is modeled as:

$$DV_{ij} \sim \mathcal{N}(CP_{ij},\ \sigma^2) \quad \text{(additive error)}$$

or

$$DV_{ij} \sim \mathcal{N}(CP_{ij},\ (CP_{ij} \cdot \sigma)^2) \quad \text{(proportional error)}$$

The residual $DV_{ij} - CP_{ij}$ is assumed to have mean zero and standard deviation σ. The sigma (additive, proportional, or combined) is also declared in the param block and optimized.

### Summary: Block Sequence in Pumas

| Order | Block | Purpose |
|-------|-------|---------|
| 1 | `@param` | Declare parameters with bounds and initial estimates |
| 2 | `@random` | Declare distributional assumptions for random effects |
| 3 | `@pre` | Compute individual parameters from population values and ETAs |
| 4 | `@dynamics` | Define the differential equation(s) |
| 5 | `@derived` | Scale solution to observed metric; specify residual error model |

At every iteration of the optimizer, this full chain is executed: parameters are updated → individual values are computed → the differential equation is solved → concentrations are predicted → residuals are evaluated → likelihood is computed. This continues until the optimizer converges to the maximum likelihood estimate.

---

## Numerical Diagnostics and Likelihood-Based Metrics

### Log-Likelihood and Related Criteria

The optimization process yields a set of **maximum likelihood parameter estimates** along with a log-likelihood value. Associated metrics include:

| Metric | Direction | Interpretation |
|--------|-----------|----------------|
| Log-likelihood (LL) | Maximize | Higher is better |
| −2 Log-likelihood (−2LL) | Minimize | Lower is better |
| AIC (Akaike Information Criterion) | Minimize | Lower is better |
| BIC (Bayesian Information Criterion) | Minimize | Lower is better |

These metrics are most meaningful in **comparison** between models, not in isolation. A standalone AIC of 34, for instance, carries no interpretive value without a reference model.

### The Maximum Likelihood Estimate as the Mode

From a statistical standpoint, the maximum likelihood estimate of a parameter corresponds to the **mode** of the posterior distribution — not the mean or median. This distinction is relevant when reading the modeling literature, where this terminology appears frequently.

### Parameter Precision

Each maximum likelihood estimate is accompanied by a confidence interval (derived from the standard error or RSE). A parameter estimate is only useful if it is sufficiently precise. High RSE values signal poor identifiability and reduce confidence in the model.

---

## Model Comparison and the Log-Likelihood Ratio Test

### Setting Up the Comparison

Consider comparing a one-compartment model (Model 1) and a two-compartment model (Model 2):

**One-compartment model parameters:**
$$\theta_{CL},\ \theta_{V_C},\ \omega_{CL},\ \omega_{V_C},\ \sigma \quad (5\ \text{parameters})$$

**Two-compartment model parameters:**
$$\theta_{CL},\ \theta_{V_C},\ \theta_{V_P},\ \theta_Q,\ \omega_{CL},\ \omega_{V_C},\ \omega_{V_P},\ \omega_Q,\ \sigma \quad (9\ \text{parameters})$$

The two-compartment model has **4 additional parameters** (degrees of freedom, $\Delta df = 4$).

### The Log-Likelihood Ratio Test (LRT)

The **log-likelihood ratio test** (LRT, implemented in Pumas as `lrtest()`) compares two nested models. The test statistic is:

$$\Delta \text{LL} = \text{LL}_{\text{complex}} - \text{LL}_{\text{simple}}$$

Under the null hypothesis, this difference follows a **chi-squared distribution** ($\chi^2$) with degrees of freedom equal to the difference in the number of parameters between the two models.

### Critical Values and Decision Rule

For a significance level of $\alpha = 0.05$ and **one degree of freedom**, the expected $\Delta$LL threshold is **3.84** (the 95th percentile of the $\chi^2_1$ distribution). For multiple degrees of freedom, the threshold scales accordingly:

$$\Delta \text{LL}_{\text{critical}} = \Delta df \times 3.84$$

**Example:** Comparing a two-compartment model (LL = 68) against a one-compartment model (LL = 55):

- $\Delta \text{LL} = 68 - 55 = 13$
- $\Delta df = 9 - 5 = 4$
- Critical threshold: $4 \times 3.84 = 15.36$
- Since $13 < 15.36$, the test **does not pass** at $\alpha = 0.05$

Despite the two-compartment model yielding a higher log-likelihood, the improvement is not statistically significant after accounting for the additional model complexity. The one-compartment model is therefore preferred on the basis of this test.

**Important:** Even when the LRT does not favor the more complex model, graphical diagnostics (e.g., goodness-of-fit plots, VPCs) may still reveal that the two-compartment model provides a better description of the data. Numerical and graphical diagnostics are complementary and should both be considered.

### When to Explore Multiple Structural Models

The extent of model exploration depends on the context:

- **New compound / first analysis:** Explore the full structural space (one-compartment, two-compartment, linear vs. Michaelis-Menten elimination, etc.) to identify the most parsimonious model.
- **Prior literature or study history available:** Structural choices are guided by precedent; exploration focuses on the variability model, which is sensitive to the design and sample size of the current dataset.
- **Late-phase trials (e.g., Phase 3):** Structural forms are largely established from earlier phases; the modeling effort shifts to refining and confirming the variability and covariate structure.

The guiding principle is parsimony — the simplest model that adequately describes the data is preferred.

---

## Reading Assignment

Before the next session, review the following:

1. **Chi-squared ($\chi^2$) distribution** — understand its relationship to the normal distribution (a $\chi^2$ random variable is the square of a standard normal random variable), its shape, and how it is used as a reference distribution for test statistics.
2. **Log-likelihood ratio test** — understand how $\Delta$LL is computed, how it relates to the $\chi^2$ distribution, and how to apply it to compare nested models.
3. **Test statistics in general** — revisit the concept of test statistics from normal distributions, t-tests, and ANOVA to reinforce the principle of how p-values and significance thresholds are derived.

The value 3.84 — the threshold for one degree of freedom at $\alpha = 0.05$ — arises directly from the $\chi^2_1$ distribution. Understanding where this number comes from is essential for independently applying and interpreting likelihood-based model comparison.
