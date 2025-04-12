# DeconvSurvivalCancer
# Integrative Survival Modeling with Deconvolved Tumor Profiles

This repository presents a modular research project integrating RNA-seq deconvolution and causal survival modeling to investigate cancer treatment outcomes. 
## Objectives

- Simulate realistic survival data with gene expression features and treatment assignment under confounding
- Infer tumor-infiltrating cell-type compositions via deconvolution from bulk RNA-seq data
- Model survival outcomes using Cox regression, incorporating deconvolved features and treatment indicators
- Apply causal inference techniques (IPW, doubly robust estimation) to estimate treatment effects
- Evaluate the impact of missing data using multiple imputation methods

## Project Structure

- `data/`: Simulation scripts and input data (real or synthetic)
- `analysis/`: Scripts and notebooks for each modeling stage (deconvolution, survival, causal estimation)
- `figures/`: Key result visualizations (e.g., Kaplan–Meier curves, heatmaps)
- `results/`: Summary tables and model outputs
- `report/`: Final formatted summary (e.g., proposal, PDF handout)

## Methods and Tools

- R packages: `survival`, `mice`, `MatchIt`, `twang`, `ggplot2`
- Deconvolution tools: CIBERSORTx, MuSiC, DeMixSC
- Data: Simulated datasets, with future integration of public TCGA or PBMC references

## Author

Developed by Shiwen 
