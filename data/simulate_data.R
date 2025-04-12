# simulate_data.R
# Simulate survival data with treatment, cell-type proportions, and missing values
# Author: Shiwen 

library(survival)
library(dplyr)

set.seed(42)

# Parameters
n <- 300  # number of patients
n_cell_types <- 5

# Simulate baseline covariates
age <- round(rnorm(n, mean = 60, sd = 10))
sex <- rbinom(n, 1, 0.5)

# Simulate treatment assignment with confounding (e.g., older more likely treated)
prop_score <- plogis(0.05 * (age - 60) + 0.3 * sex)
treatment <- rbinom(n, 1, prop_score)

# Simulate cell-type proportions (sum to 1)
raw_cell_props <- matrix(rbeta(n * n_cell_types, 2, 5), nrow = n)
cell_sums <- rowSums(raw_cell_props)
cell_props <- raw_cell_props / cell_sums
colnames(cell_props) <- paste0("cell_type_", 1:n_cell_types)

# Simulate baseline hazard
baseline_hazard <- 0.01

# True treatment effect + cell-type effect (only cell_type_3 matters here)
linpred <- 0.5 * treatment - 1.2 * cell_props[,3] + 0.02 * (age - 60)
hazard <- baseline_hazard * exp(linpred)
time <- rexp(n, rate = hazard)
censoring_time <- rexp(n, rate = 1/200)
status <- as.integer(time <= censoring_time)
obs_time <- pmin(time, censoring_time)

# Combine into data.frame
df <- data.frame(
  patient_id = paste0("P", sprintf("%03d", 1:n)),
  age = age,
  sex = sex,
  treatment = treatment,
  time = round(obs_time, 1),
  status = status
)

# Add cell-type proportions
df <- cbind(df, round(cell_props, 3))

# Inject missing values (for later imputation analysis)
missing_idx <- sample(1:n, size = round(n * 0.1))
df$age[missing_idx] <- NA

# Save
write.csv(df, file = "simulated_data_sample.csv", row.names = FALSE)
