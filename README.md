# Loan Default & Credit Risk Analysis

## Project Overview

This project analyzes borrower and loan characteristics to identify patterns associated with loan default risk.

The project uses Python, PostgreSQL, SQL, and Power BI to perform data cleaning, exploratory data analysis, risk segmentation, and interactive dashboard development.

## Business Problem

Loan defaults create financial risk for lending institutions. The objective of this project is to analyze borrower and loan characteristics and identify segments with higher observed default rates.

The analysis focuses on factors such as:

- Loan grade
- Loan intent
- Home ownership
- Previous credit default history
- Borrower income
- Loan amount
- Interest rate
- Loan-to-income ratio
- Borrower age

## Dataset

- Dataset: Credit Risk / Loan Default Dataset
- Original records: 32,581
- Cleaned records: 32,416
- Columns: 12
- Target variable: `loan_status`
- `0` = No Default
- `1` = Default

## Tools & Technologies

- Python
- Pandas
- Matplotlib
- PostgreSQL
- SQL
- Power BI
- DAX
- Jupyter Notebook
- VS Code

## Project Workflow

1. Business problem definition
2. Raw dataset understanding
3. Data loading using Python
4. Data quality analysis
5. Data cleaning
6. Cleaned dataset export
7. PostgreSQL database creation
8. SQL-based risk analysis
9. Python exploratory data analysis
10. Power BI dashboard development
11. DAX measures
12. Business insights
13. Recommendations

## Data Cleaning

The raw dataset was analyzed using Pandas.

Data-quality checks included:

- Missing-value analysis
- Duplicate detection
- Invalid age detection
- Invalid employment-length detection
- Categorical-value validation
- Target-variable validation

### Cleaning actions

- Removed 165 duplicate records
- Identified 5 invalid age values above 100 and treated them as missing
- Identified invalid employment-length values above 50 years and treated them as missing
- Retained legitimate missing values for employment length and interest rate instead of applying arbitrary imputation
- Validated the final dataset
- Exported the cleaned dataset as `credit_risk_cleaned.csv`

### Final Dataset

- Rows: 32,416
- Columns: 12
- Duplicate rows: 0

## PostgreSQL Analysis

The cleaned dataset was imported into PostgreSQL and analyzed using SQL.

The final portfolio contains:

- Total loans: 32,416
- Total defaults: 7,089
- Overall observed default rate: 21.87%

### Key SQL Analyses

Default rates were analyzed by:

- Loan grade
- Loan intent
- Home ownership
- Previous default history
- Age group
- Income group
- Loan amount group
- Interest-rate group
- Loan-to-income group
- Combined borrower and loan segments

## Key Findings

### 1. Loan Grade

Observed default rates increased substantially across higher-risk loan grades.

- Grade A: 9.96%
- Grade B: 16.32%
- Grade C: 20.75%
- Grade D: 59.06%
- Grade E: 64.49%
- Grade F: 70.54%
- Grade G: 98.44%

Smaller groups, particularly Grade G, should be interpreted cautiously.

### 2. Previous Credit Default

Borrowers with a previous default on file showed a higher observed current-loan default rate:

- Previous default = Y: 37.87%
- Previous default = N: 18.43%

### 3. Income

Observed default rates were higher among lower-income groups:

- Below 30K: 47.20%
- 30K–49K: 28.21%
- 50K–74K: 17.66%
- 75K–99K: 10.95%
- 100K+: 8.94%

### 4. Loan-to-Income Ratio

Loan-to-income ratio showed a strong association with observed default rates:

- Below 10%: 11.59%
- 10%–19%: 14.74%
- 20%–29%: 20.97%
- 30%–39%: 61.93%
- 40%+: 73.59%

### 5. Loan Amount

Higher loan-amount groups showed higher observed default rates:

- Below 5K: 20.81%
- 5K–9.9K: 18.01%
- 10K–14.9K: 21.00%
- 15K–19.9K: 28.19%
- 20K+: 33.78%

### 6. Loan Intent

Observed default rates varied across loan purposes:

- Debt Consolidation: 28.68%
- Medical: 26.76%
- Home Improvement: 26.15%
- Personal: 19.90%
- Education: 17.25%
- Venture: 14.85%

## Power BI Dashboard

The Power BI dashboard provides an interactive overview of the credit-risk portfolio.

### KPI Cards

- Total Loans
- Total Defaults
- Default Rate

### Dashboard Visuals

- Default Rate by Loan Grade
- Default Rate by Loan Intent
- Default Rate by Home Ownership
- Default Rate by Loan Amount
- Default Rate by Previous Default History
- Default Rate by Loan-to-Income Ratio
- Default vs Non-Default Loan Distribution

### Interactive Filters

- Loan Grade
- Loan Intent
- Home Ownership

## DAX Measures

### Total Loans

```DAX
Total Loans = COUNTROWS(credit_risk_cleaned)

Total Defaults =
CALCULATE(
    COUNTROWS(credit_risk_cleaned),
    credit_risk_cleaned[loan_status] = 1
)

Default Rate =
DIVIDE(
    [Total Defaults],
    [Total Loans],
    0
)