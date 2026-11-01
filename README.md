# Employee Resignation Analysis Using Logistic Regression

## Project Overview

This project analyzes factors associated with employees leaving an organization using statistical analysis and binary logistic regression.

The study aims to examine the relationship between employee characteristics and their decision to leave the company, as well as develop a logistic regression model to estimate the probability of employee resignation.

The analysis uses a publicly available employee dataset and focuses on factors such as job satisfaction, performance evaluation, workload, years of service, workplace accidents, promotion history, department, and salary level.

## Project Objectives

- Perform data preprocessing and exploratory data analysis.
- Analyze the relationship between employee characteristics and resignation.
- Identify significant predictors using statistical hypothesis testing.
- Develop binary logistic regression models.
- Compare models with and without interaction terms.
- Evaluate model performance using classification metrics and ROC analysis.

## Dataset

**Source:** [Employee Worker Dataset – Kaggle](https://www.kaggle.com/datasets/aminaidhm23386/employee-worker)

The dataset contains employee information with the following variables:

| Variable | Description |
|---|---|
| satisfaction_level | Employee job satisfaction |
| last_evaluation | Last performance evaluation |
| number_project | Number of projects |
| average_montly_hours | Average monthly working hours |
| time_spend_company | Years spent at the company |
| Work_accident | Workplace accident indicator |
| promotion_last_5years | Promotion within the last five years |
| sales | Employee department |
| salary | Salary category |
| left | Employee status (1 = left, 0 = stayed) |

**Note:** The target variable `left` indicates whether an employee left the company. The dataset does not specify whether the departure was necessarily voluntary.

## Tools & Technologies

- **R** – Statistical analysis and modeling.
- **dplyr** – Data manipulation.
- **car** – Multicollinearity diagnostics.
- **pROC** – ROC curve and AUC evaluation.
- **ResourceSelection** – Hosmer-Lemeshow goodness-of-fit test.
- **gmodels** – Classification table.

## Methodology

### 1. Data Preprocessing
- Inspect dataset structure and descriptive statistics.
- Identify variable types.
- Encode categorical variables.
- Prepare response and predictor variables.

### 2. Statistical Hypothesis Testing

Statistical tests were conducted to examine the relationship between predictors and employee resignation:

- Independent t-test for numerical variables.
- Chi-square test for categorical variables.
- Wald test for predictor significance.

A significance level of 5% was used.

### 3. Logistic Regression Modeling

Two logistic regression models were developed:

**Model 1: Without Interaction Terms**

A binary logistic regression model containing selected predictor variables without interaction effects.

**Model 2: With Interaction Terms**

A logistic regression model incorporating selected interactions between employee characteristics.

Backward elimination was applied for model selection. The likelihood ratio test (ANOVA) was used to compare the two models.

### 4. Model Evaluation

The selected model was evaluated using:

- Hosmer-Lemeshow goodness-of-fit test.
- Confusion matrix.
- Accuracy and error rate.
- Receiver Operating Characteristic (ROC) curve.
- Area Under the Curve (AUC).

## Key Findings

The analysis resulted in the following evaluation metrics:

| Metric | Result |
|---|---:|
| Accuracy | 79.1% |
| Error Rate | 20.9% |
| AUC | 0.825 |
| Hosmer-Lemeshow p-value | 2.2 × 10⁻¹⁶ |

The likelihood ratio test indicated that the model incorporating interaction terms provided a statistically significant improvement over the model without interaction terms.

The analysis identified several employee characteristics associated with the probability of leaving the company, including:

- Job satisfaction level.
- Number of projects.
- Average monthly working hours.
- Length of service.
- Workplace accident history.
- Promotion history.
- Salary level.

## Limitations

- The reported classification metrics were calculated using fitted predictions on the modeling dataset, not an independent test dataset.
- The Hosmer-Lemeshow test indicated potential goodness-of-fit issues.
- Further model validation is required to assess generalization to unseen observations.
- The analysis identifies statistical associations and does not establish causal relationships.

## Future Improvements

- Improve categorical variable encoding.
- Implement train-test splitting or cross-validation.
- Evaluate precision, recall, F1-score, and ROC-AUC on unseen data.
- Investigate classification threshold selection.
- Improve model calibration and goodness-of-fit.


*This project demonstrates the application of statistical hypothesis testing and binary logistic regression in analyzing employee departure patterns.*
