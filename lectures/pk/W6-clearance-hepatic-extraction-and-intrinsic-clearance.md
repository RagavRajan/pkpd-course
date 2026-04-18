# Week 6: Drug Elimination — Clearance, Hepatic Extraction, and Intrinsic Clearance

## Overview

This lecture covers the topic of drug elimination, with a primary focus on small molecules. The same principles broadly apply to large molecules, though large-molecule clearance mechanisms differ and will be addressed separately. Elimination is among the most important topics in pharmacokinetic modeling. The goal is to develop a comprehensive conceptual understanding of the overall process, which serves as a foundation for mechanistic modeling and drug development decision-making.

The subtopics addressed in this session are:

1. Elimination vs. excretion vs. metabolism
2. Biotransformation and metabolizing enzyme superfamilies
3. Clearance as a proportionality factor
4. Clearance via mass balance — introduction to extraction ratio
5. Terminology and classification of clearance
6. Plasma vs. blood clearance and the plasma-to-blood concentration ratio
7. Hepatic clearance and liver physiology
8. High vs. low extraction ratio drugs
9. Intrinsic clearance

---

## 1. Elimination, Excretion, and Metabolism

### Definitions

**Excretion** is the underlying process by which drug is removed from a compartment or the body. **Elimination** is the observable manifestation of that process. In other words, excretion describes the mechanism; elimination describes what is observed.

Elimination occurs via two distinct processes:

- **Excretion**: Removal of unchanged (or chemically unaltered) drug via specific organs and routes — biliary system, pulmonary system, and renal system.
- **Metabolism**: Biotransformation of the parent drug into a metabolite, primarily in the liver and other organs.

The key distinction is that excretion can involve the unchanged drug leaving the body directly, whereas metabolism involves chemical transformation of the parent compound.

### Biotransformation

Biotransformation is the chemical modification of a drug within the body. It proceeds sequentially through two phases:

- **Phase I reactions**: Oxidation, reduction, and hydrolysis. These reactions introduce or expose a functional group on the drug molecule.
- **Phase II reactions**: Conjugation reactions (e.g., glucuronidation). These reactions attach an endogenous molecule to the Phase I product, generally increasing water solubility and facilitating excretion. Some drugs bypass Phase I and undergo Phase II reactions directly.

The resulting metabolite is then excreted from the body via the standard excretory routes.

Most biotransformations occur in the **endoplasmic reticulum** of cells, primarily in the liver. When liver tissue is homogenized during in vitro experiments, the endoplasmic reticulum breaks down into vesicular fragments called **microsomes**. The metabolizing enzymes contained within the endoplasmic reticulum are therefore referred to as **microsomal enzymes**.

There are two broad categories of metabolism:
- **Microsomal metabolism**: Carried out by microsomal enzymes.
- **Non-microsomal metabolism**: Carried out by enzymes outside the endoplasmic reticulum.

### Metabolizing Enzyme Superfamilies

Two major enzyme superfamilies are responsible for drug metabolism:

1. **Cytochrome P450 (CYP450)**: Contains three families (1, 2, and 3), each with subfamilies designated A, B, C, D, E. Individual enzymes are denoted with a number following the subfamily letter — e.g., CYP3A4, CYP2C19, CYP2D6.
2. **UDP-glucuronosyltransferases (UGT)**: Also classified with a numbered family system.

These classifications are updated over time as understanding of individual enzymes improves.

### Metabolite Pharmacokinetics

The relationship between parent drug clearance and metabolite appearance adds complexity to pharmacokinetic modeling. Two key layers of complexity are:

1. What fraction of the parent drug is converted to a given metabolite?
2. Can the metabolite convert back to the parent drug (reverse metabolism)?

Metabolite pharmacokinetics will not be covered in depth in this introductory course; the focus remains on parent drug kinetics.

---

## 2. Clearance as a Proportionality Factor

Clearance (CL) is defined as the proportionality constant that relates the **rate of drug elimination** to the **plasma concentration**:

$$\text{Rate of elimination} = CL \times C$$

With units:

$$\frac{\text{mg}}{\text{hr}} = \frac{\text{L}}{\text{hr}} \times \frac{\text{mg}}{\text{L}}$$

This equation is fundamental to pharmacokinetics. Clearance is not a rate itself — it is a scaling factor that converts an observed concentration into an elimination rate. This perspective is sufficient for empirical pharmacokinetics and routine dosing decisions (e.g., once-daily vs. twice-daily dosing based on whether clearance is low or high).

For a deeper mechanistic understanding, clearance is also examined through the lens of **mass balance**, as described in the following section.

---

## 3. Clearance via Mass Balance — Extraction Ratio

### The Eliminating Organ Model

Consider a single sinusoid (capillary) of the liver as the eliminating organ. Blood enters with flow rate $Q$ (L/hr) and arterial drug concentration $C_A$, and exits with the same flow rate and venous concentration $C_V$.

- **Rate of entry** = $Q \cdot C_A$
- **Rate of exit** = $Q \cdot C_V$
- **Rate of extraction** = $Q \cdot (C_A - C_V)$

Elimination is occurring when $C_A \neq C_V$, i.e., when the venous concentration is lower than the arterial concentration.

### Extraction Ratio

Normalizing the rate of extraction by the rate of entry:

$$E = \frac{Q(C_A - C_V)}{Q \cdot C_A} = 1 - \frac{C_V}{C_A}$$

The term $C_V / C_A$ represents the fraction of drug leaving the organ relative to the fraction entering. Therefore:

- $C_V/C_A = 1$: No drug is extracted (extraction ratio = 0).
- $C_V/C_A = 0.5$: 50% of the drug is extracted.
- $C_V/C_A = 0.1$: 90% of the drug is extracted (high extraction ratio).

The **extraction ratio** $E$ is thus:

$$E = 1 - \frac{C_V}{C_A}$$

Normalizing by arterial concentration rather than by rate of entry gives:

$$Q \cdot C_A \rightarrow Q, \quad Q \cdot C_V \rightarrow Q(1 - E), \quad \text{extraction} = Q \cdot E$$

This mass balance framework is the foundation for understanding hepatic clearance, drug–drug interactions, protein binding effects, and dose individualization.

---

## 4. Terminology and Classification of Clearance

Clearance can be classified along several dimensions depending on the context and available data:

| Classification basis | Examples |
|---|---|
| Organ | Renal, hepatic, pulmonary, skin |
| Comparison basis | Renal vs. non-renal; hepatic vs. non-hepatic |
| Elimination process | Metabolic vs. excretory |
| Measured fluid | Blood clearance vs. plasma clearance |

In all cases, **total clearance** is the observed quantity, and it equals the sum of all individual clearances:

$$CL_{\text{total}} = CL_{\text{renal}} + CL_{\text{hepatic}} + CL_{\text{pulmonary}} + \cdots$$

or equivalently:

$$CL_{\text{total}} = CL_{\text{metabolic}} + CL_{\text{excretory}}$$

In the literature, authors adapt terminology to the context. Papers focused on drug interactions emphasize metabolic clearance; clinical dosing papers report total clearance. It is important to identify which definition of clearance is being used when reading any given paper or textbook.

---

## 5. Plasma vs. Blood Clearance

### Relevance

The most commonly measured biological fluid is plasma. However, from a mass balance standpoint, elimination occurs from whole blood. Understanding the relationship between plasma and blood clearance is therefore essential — particularly for drugs that are extensively bound to red blood cells.

Let:
- $CL_U$ = unbound plasma clearance (since only unbound drug is eliminated)
- $CL_B$ = blood clearance

The general rate of elimination equation can be written equivalently as:

$$\text{Rate of elimination} = CL \cdot C = CL_B \cdot C_B = CL_U \cdot C_U$$

where $C_B$ is blood concentration and $C_U$ is unbound plasma concentration.

From the equality $CL_B \cdot C_B = CL \cdot C$:

$$CL_B = CL \cdot \frac{C}{C_B}$$

This is the plasma-to-blood concentration ratio, $C/C_B$.

### Illustrative Example

Suppose a drug has:
- Observed clearance $CL = 1.3$ L/min
- Hepatic blood flow $Q_H = 1.35$ L/min
- The drug is extensively hepatically metabolized

Without additional information, $CL / Q_H \approx 0.96$ suggests a **high extraction ratio** drug — nearly all drug presented to the liver is eliminated.

However, if the **plasma-to-blood concentration ratio** $C/C_B = 0.1$, then:

$$CL_B = 1.3 \times 0.1 = 0.13 \text{ L/min}$$

This means the blood clearance is actually much lower than it first appeared. The reason: a large fraction of the drug in the blood resides in red blood cells ($C_B$ is high), while the unbound plasma concentration ($C_U$) is low. Only the unbound drug in plasma is available for elimination. Therefore, even though blood flow is ample, relatively little drug is being cleared per unit time.

This concept is critical for:
- Predicting drug–drug interactions
- Understanding the impact of protein binding changes in disease states
- Distinguishing high vs. low extraction ratio drugs

### Plasma-to-Blood Concentration Ratio: Derivation

The total amount of drug in blood is distributed between plasma and red blood cells:

$$C_B \cdot V_B = C \cdot V_P + C_{BC} \cdot V_{BC}$$

where $V_B$ = blood volume, $V_P$ = plasma volume, $V_{BC}$ = volume occupied by blood cells.

Key relationships:
- Unbound plasma concentration: $C_U = f_U \cdot C$
- Affinity of drug for blood cells: $K_{P,BC} = C_{BC} / C_U$, so $C_{BC} = K_{P,BC} \cdot f_U \cdot C$
- Volume of blood cells: $V_{BC} = H \cdot V_B$ (where $H$ = hematocrit)
- Plasma volume: $V_P = (1 - H) \cdot V_B$

Substituting and simplifying:

$$\frac{C}{C_B} = \frac{1}{1 - H + H \cdot f_U \cdot K_{P,BC}}$$

The inverse gives the blood-to-plasma concentration ratio. Key determinants are hematocrit ($H$), fraction unbound ($f_U$), and the blood cell affinity constant ($K_{P,BC}$). In practice:
- Hematocrit is relatively constant and easily measured.
- Fraction unbound is measurable from plasma protein binding assays.
- $K_{P,BC}$ is derived experimentally from the measured blood-to-plasma ratio along with known $H$ and $f_U$.

---

## 6. Hepatic Clearance

### Liver Physiology

Hepatic blood flow ($Q_H$) is the sum of:
- **Hepatic portal venous flow**: ~1,050 mL/min (venous drainage from the gastrointestinal tract via the hepatic portal vein)
- **Hepatic arterial blood flow**: ~300 mL/min

Total: $Q_H \approx 1,350$ mL/min = **1.35 L/min**

The hepatic portal vein carries drug absorbed from the gut directly to the liver before it reaches systemic circulation. This anatomical arrangement is the basis for the **first-pass effect** (to be discussed in detail in the oral absorption section).

The fundamental functional unit of the liver is the **acinus**, which contains hepatocytes (the primary metabolizing cells) and Kupffer cells, organized around sinusoidal capillaries.

### Processes Occurring in a Single Hepatic Sinusoid

Considering a single sinusoid as a representative unit, the following six processes govern drug extraction by the liver:

1. **Perfusion**: Blood delivers drug to the sinusoid at rate $Q \cdot C_A$.
2. **Permeation**: Only unbound drug permeates into the hepatocyte (via passive or active transport).
3. **Metabolism**: Unbound intracellular drug is biotransformed by enzymes.
4. **Biliary excretion (secretion)**: Unbound drug is secreted into the bile duct.
5. **Excretion**: Drug in bile is excreted from the body.
6. **Reflux**: Drug can diffuse back from the hepatocyte into the sinusoidal blood (bidirectional permeability).

Processes 3 and 4 can occur simultaneously. If elimination within the hepatocyte is not fast enough, drug refluxes back into the blood (process 6), re-enters systemic circulation, and is re-presented to the liver.

### High vs. Low Extraction Ratio Drugs

**High extraction ratio** ($E \approx 0.9$):
- Elimination within the hepatocyte is extremely rapid.
- As soon as unbound drug enters the hepatocyte, it is metabolized or secreted before it can reflux back.
- The rate-limiting step is **perfusion** (delivery of drug via blood flow) and **permeation** (ability of unbound drug to enter the hepatocyte).
- Protein binding is critical: if $f_U$ is low (high protein binding), less drug is available for uptake even with high blood flow.

**Low extraction ratio** ($E \approx 0.1$):
- Elimination within the hepatocyte is slow.
- A large fraction of drug re-enters systemic circulation after each pass.
- The rate-limiting step is the **intrinsic eliminating activity** of the hepatocyte itself.

### Clinical Implications

Understanding extraction ratio enables prediction of how changes in physiological parameters affect drug exposure:

- **Genetic polymorphism** (e.g., CYP2D6 poor metabolizer): The metabolic capacity is reduced; for a drug that is normally high extraction, clearance may drop substantially (e.g., 40–50-fold difference in clearance between extensive and poor metabolizers, with up to ~10-fold difference in half-life).
- **Disease states** (e.g., liver cirrhosis): Fibrosis alters hepatocyte membrane integrity, reducing passive permeability and active transporter function, thereby impairing drug uptake.
- **Infection/inflammation**: Elevated albumin or other acute-phase proteins increase drug binding, reducing unbound concentration and thereby reducing hepatic clearance even if metabolic capacity is unchanged.
- **Drug–drug interactions**: A perpetrator drug competing for the same metabolic enzyme reduces intrinsic clearance of the victim drug; the magnitude of the effect depends on whether the victim drug is a high- or low-extraction ratio compound.

---

## 7. Intrinsic Clearance

### Definition

**Intrinsic clearance** ($CL_{\text{int}}$) is the inherent eliminating capacity of the hepatocyte, measured in isolation from the effects of blood flow and protein binding. It is defined by:

$$\text{Rate of elimination} = CL_{\text{int}} \cdot C_{U,\text{cell}}$$

where $C_{U,\text{cell}}$ is the unbound drug concentration inside the hepatocyte.

Intrinsic clearance is a measure of **intrinsic hepatocellular eliminating activity**. By focusing on only what occurs inside the hepatocyte, it separates enzymatic and transporter capacity from delivery (perfusion) and availability (protein binding) effects.

### Components of Intrinsic Clearance

Intrinsic clearance is the sum of all eliminating mechanisms within the hepatocyte:

$$CL_{\text{int}} = \sum CL_{\text{metabolic},i} + \sum CL_{\text{secretory},j}$$

where $i$ indexes metabolizing enzymes and $j$ indexes biliary secretion transporters. Most drugs are substrates of more than one enzyme and more than one transporter.

The overall hepatic intrinsic clearance is the summation of the intrinsic clearances contributed by all hepatocytes within the liver.

### Relationship to Observed Hepatic Clearance

Observed hepatic clearance integrates all three components:
- **Perfusion** ($Q_H$)
- **Protein binding** ($f_U$)
- **Intrinsic eliminating activity** ($CL_{\text{int}}$)

The relative magnitudes of these three factors determine whether a drug behaves as a high- or low-extraction compound. Subsequent lectures will cover the mathematical models (e.g., the well-stirred model) that formally relate $CL_{\text{int}}$, $f_U$, and $Q_H$ to the observable hepatic clearance.

---

## 8. Looking Ahead

The following topics remain to be covered to complete the discussion of elimination:

1. **Perfusion-limited hepatic clearance** (well-stirred model)
2. **Impact of protein binding** on hepatic clearance
3. **Intrinsic eliminating activity** in detail (enzyme kinetics, Michaelis–Menten)
4. **Permeability and transporter-mediated uptake** into hepatocytes
5. **Biliary excretion**
6. **Renal clearance** (glomerular filtration, tubular secretion, tubular reabsorption)
7. **Renal metabolism** (brief overview)

---

*End of Week 6 Lecture Notes*
