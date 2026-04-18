# Population PK/PD Modeling: Residual Diagnostics and Error Model Specification

## 1. Residual Error Models: Fundamental Concepts

### 1.1 Additive Error Model

The individual observation is modeled as:

$$DV_{ij} \sim \mathcal{N}(CP_{ij},\ \sigma)$$

where $\varepsilon_{ij} \sim \mathcal{N}(0,\ \sigma)$.

A critical question that underpins correct interpretation of error models is: when we define $\varepsilon_{ij} \sim \mathcal{N}(0, \sigma)$, is this additive error with respect to **time** or with respect to **concentration**?

For an additive error model, sigma ($\sigma$) is **constant** — it does not depend on concentration. However, in the concentration–time framework, each observation $DV_{ij}$ carries an index $j$ that corresponds to a specific time point. The residuals are therefore indexed by time. The key insight is that $\sigma$ itself is not a function of concentration in the additive case: the spread of the residuals remains constant regardless of the magnitude of the predicted concentration.

### 1.2 Proportional Error Model

For a proportional error model:

$$DV_{ij} \sim \mathcal{N}(CP_{ij},\ \sigma \cdot CP_{ij})$$

Here, $\sigma$ scales with the predicted concentration. As concentration increases, the absolute spread of the residuals also increases, producing a characteristic fan-shaped pattern in residual diagnostic plots.

This is directly analogous to the coefficient of variation (CV) in bioanalytical assay validation:

$$CV = \frac{\sigma}{\mu} \times 100\%$$

In a standard calibration curve, absolute standard deviation increases with concentration, but the percent CV remains approximately constant across the dynamic range. This is because CV normalizes by the mean concentration. The proportional error model encodes this same relationship.

### 1.3 Combined (Additive + Proportional) Error Model

A combined error model takes the form:

$$DV_{ij} \sim \mathcal{N}\!\left(CP_{ij},\ \sigma_1 + \sigma_2 \cdot CP_{ij}\right)$$

This is appropriate when residual variability shows fan-shaped behavior at moderate-to-high concentrations but non-negligible constant variance at low concentrations.

---

## 2. Independence of Residuals (IID Assumption)

A fundamental statistical assumption underlying all residual error models is that the residuals are **independent and identically distributed (IID)**:

$$\varepsilon_{ij} \overset{\text{iid}}{\sim} \mathcal{N}(0,\ \sigma)$$

**Independence** means that the residual at time $t_1$ carries no information about the residual at time $t_2$. In other words, there is no temporal pattern among the residuals. If the IID assumption holds, plotting the residuals against time should yield a random scatter with no discernible structure.

**Violations of independence** manifest as systematic patterns in the residual-versus-time plot:

- A monotonically increasing or decreasing trend
- A U-shaped or inverted-U-shaped arc
- Any cyclical or systematic structure

Such patterns indicate that the structural model is **mis-specified**: the mathematical equations used to describe the concentration–time profile are not an adequate representation of the underlying pharmacokinetics.

### 2.1 Autocorrelation (AR-1) Models

When residuals are genuinely correlated in time — a situation frequently encountered in pharmacodynamic biomarker data — standard IID models are insufficient. Autoregressive order-one (AR-1) models explicitly link each residual to its predecessor:

$$\varepsilon_{ij} = \rho \cdot \varepsilon_{i,j-1} + \text{innovation}$$

These models are considerably more complex to specify and fit. However, understanding them requires first having a firm grasp of the IID assumption and what its violation implies.

---

## 3. Graphical Diagnostic Plots

### 3.1 Residuals vs. Time

The residual-versus-time plot shares the same time axis as the original concentration–time profile. This creates a **direct mapping**: any systematic pattern in the residuals can be interpreted in terms of specific pharmacokinetic phases.

**Examples of mis-specification patterns:**

- **Overestimation during the distribution phase and underestimation during the elimination phase** (or vice versa): this pattern suggests that the compartmental structure is wrong — for example, a one-compartment model has been applied to data that exhibits two-compartment behavior.
- **High residuals at early time points only**: this suggests that the absorption phase is being poorly described and the absorption model may need to be revised.

Because the time axis maps directly onto pharmacokinetic phases (absorption, distribution, elimination), the residual-versus-time plot is the primary diagnostic for **structural model mis-specification**.

### 3.2 Residuals vs. Predicted Concentration

This plot examines whether the spread of residuals depends on the magnitude of the predicted concentration. The expectation under the IID assumption is that residuals are randomly and uniformly distributed across all predicted concentrations.

**Interpreting patterns:**

| Pattern Observed | Implication |
|---|---|
| Fan shape opening at higher concentrations | Additive error model assumed; proportional (or combined) error needed |
| Fan shape opening at lower concentrations | Possible inverse-proportional relationship; consider $\sigma / CP_{ij}$ |
| Elevated spread only at low concentrations, constant thereafter | Combined error model warranted |

These patterns reflect a mismatch between the assumed error model and the true error structure of the data.

### 3.3 Individual Weighted Residuals (IWRES) vs. Individual Predictions

**Standardization of residuals** removes the dependence of residual magnitude on the underlying error model. By dividing the residual by its expected standard deviation:

$$IWRES_{ij} = \frac{DV_{ij} - \widehat{CP}_{ij}}{\hat{\sigma}_{ij}}$$

this transformation maps the residuals onto a **standard normal distribution**, $\mathcal{N}(0,1)$, regardless of whether the underlying error model is additive, proportional, or combined.

The expectation for a well-specified model is that IWRES values fall randomly within approximately $\pm 1$–$2$ standard deviation units.

**Why this plot diagnoses error model mis-specification:** The individual predicted concentration ($\widehat{CP}_{ij}$, i.e., $IPRED$) incorporates fixed effects and inter-individual random effects ($\eta$), but not the residual error ($\varepsilon$). Whatever variability remains after accounting for these components is the residual. Regressing IWRES against IPRED therefore isolates the error model: any systematic pattern indicates that the assumed $\sigma$ structure is incorrect.

---

## 4. Epsilon Shrinkage

Epsilon shrinkage is defined as:

$$\text{Shrinkage}_\varepsilon = 1 - \text{SD}(IWRES)$$

The expected value of IWRES is $\mathcal{N}(0,1)$, so the expected standard deviation is 1. Epsilon shrinkage measures how much the observed IWRES distribution collapses toward zero relative to this expectation.

**Interpretation:**

- **High epsilon shrinkage** (> 20%) indicates that there is insufficient data across the concentration range to estimate the residual variability. When data are sparse, individual predictions shrink toward the population mean, the residuals shrink toward zero, and the IWRES standard deviation becomes small.
- A direct consequence of high epsilon shrinkage is that the **IPRED vs. observation plot appears excellent** even when the model is poorly specified. This is a form of overfitting: the individual predictions are pulled tightly to the observed data, making the fit look better than it is.
- High epsilon shrinkage should be interpreted alongside the IPRED vs. observation plot, the IWRES vs. IPRED plot, and condition number diagnostics.

---

## 5. Eta Shrinkage and the Random Effects Distribution

The analogous metric for inter-individual random effects is:

$$\text{Shrinkage}_\eta = 1 - \frac{\text{SD}(\hat{\eta})}{\omega}$$

where $\omega$ is the estimated standard deviation of the between-subject random effect.

If the $\eta$ estimates (empirical Bayes estimates, EBEs) follow a distribution that deviates substantially from $\mathcal{N}(0, \omega^2)$ — for example, appearing bimodal, skewed, or heavy-tailed — this indicates that the assumption of normally distributed random effects is violated. Visual inspection of $\eta$ histograms or box plots forms part of a complete diagnostic assessment.

---

## 6. Holistic Model Assessment

No single diagnostic metric is sufficient to evaluate model adequacy. A complete assessment integrates all available numerical and graphical diagnostics:

| Diagnostic | Primary Purpose |
|---|---|
| Population predictions (PRED) vs. observations | Overall model adequacy at the population level |
| Individual predictions (IPRED) vs. observations | Individual-level fit quality; linked to $\varepsilon$ shrinkage |
| PRED or IPRED vs. time (all subjects) | Systematic time trends across individuals |
| Residuals vs. time | Structural model mis-specification |
| Residuals vs. concentration | Error model mis-specification (unstandardized) |
| IWRES vs. IPRED | Error model mis-specification (standardized) |
| $\eta$ distributions | Validity of between-subject variability assumptions |
| Log-likelihood, AIC, BIC | Statistical model comparison |
| Shrinkage ($\varepsilon$ and $\eta$) | Adequacy of information content for parameter estimation |
| Condition number | Model identifiability and numerical stability |

For example, a substantial improvement in log-likelihood between a one-compartment and two-compartment model is not meaningful if the structural model is still mis-specified — systematic patterns will appear in the residual-versus-time plot, the IPRED-versus-observation plot will show bias, and shrinkage and condition numbers will reflect underlying problems. All diagnostics speak to each other and must be interpreted together.

---

## 7. Conditional Weighted Residuals (CWRES) vs. IWRES

There are several classes of residuals encountered in population modeling:

- **Standard (unweighted) residuals**: $DV - PRED$. Used in simple linear regression and PBPK/QSP contexts where there is no concept of individuals.
- **Individual weighted residuals (IWRES)**: conditions on the individual (incorporates $\hat{\eta}$) and normalizes by the estimated residual standard deviation. Primarily used to diagnose the **error model**.
- **Conditional weighted residuals (CWRES)**: marginalizes over the random effects by integrating out individual-level variability. Primarily used to diagnose the **structural model**. This is the residual type most commonly reported in modern nonlinear mixed-effects modeling.

The key distinction is:
- CWRES vs. time → structural model mis-specification
- IWRES vs. IPRED → error model mis-specification

These two classes of residuals are derived differently, capture different sources of model failure, and complement each other as diagnostic tools.

---

## 8. Connecting Diagnostics to Covariate Modeling

The goal of covariate modeling is to explain the variability observed in the population — specifically, to identify subject-level characteristics (e.g., body weight, renal function, age) that account for systematic differences in the $\eta$ values. Because all diagnostic plots are ultimately about characterizing and explaining variability, a thorough understanding of residual diagnostics is a prerequisite for covariate model development. The diagnostic framework described in this lecture forms the analytical foundation upon which covariate screening, forward inclusion, and backward elimination procedures are built.

---

## 9. Clinical and Biomarker Applications

The concepts covered in this lecture extend beyond pharmacokinetics to any longitudinal pharmacodynamic or biomarker context. As an example, consider a glucose–time profile in a diabetic patient receiving a glucose-lowering agent:

- The drug drives glucose to a nadir, after which it may rebound toward baseline.
- Residual diagnostic plots, combined with subject-level fit plots, reveal whether the model adequately captures the nadir, the rebound kinetics, and the return to baseline.
- Accurate characterization of the glucose nadir informs dosing strategies aimed at sustaining glucose suppression without overshoot.

In biomarker data especially, residuals frequently exhibit temporal correlation — making the IID assumption inappropriate and AR-1 or similar correlated-error models necessary.
