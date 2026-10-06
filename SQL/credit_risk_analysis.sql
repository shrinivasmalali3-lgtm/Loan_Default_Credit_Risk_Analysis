-- =====================================================
-- Loan Default & Credit Risk Analysis
-- PostgreSQL Analysis
-- =====================================================

-- Database: credit_risk_db
-- Table: loan_data

-- =====================================================
-- 1. DATASET OVERVIEW
-- =====================================================

SELECT COUNT(*) AS total_records
FROM loan_data;

SELECT *
FROM loan_data
LIMIT 5;


-- =====================================================
-- 2. LOAN STATUS DISTRIBUTION
-- =====================================================

SELECT
    loan_status,
    COUNT(*) AS total_loans
FROM loan_data
GROUP BY loan_status
ORDER BY loan_status;


-- =====================================================
-- 3. OVERALL DEFAULT RATE
-- =====================================================

SELECT
    ROUND(
        100.0 * SUM(
            CASE WHEN loan_status = 1 THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS default_rate
FROM loan_data;


-- =====================================================
-- 4. DEFAULT RATE BY LOAN GRADE
-- =====================================================

SELECT
    loan_grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(
            CASE WHEN loan_status = 1 THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
GROUP BY loan_grade
ORDER BY default_rate DESC;

-- =====================================================
-- 5. DEFAULT RATE BY LOAN INTENT
-- =====================================================

SELECT
    loan_intent,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
GROUP BY loan_intent
ORDER BY default_rate DESC;


-- =====================================================
-- 6. DEFAULT RATE BY HOME OWNERSHIP
-- =====================================================

SELECT
    person_home_ownership,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
GROUP BY person_home_ownership
ORDER BY default_rate DESC;


-- =====================================================
-- 7. PREVIOUS DEFAULT HISTORY VS CURRENT DEFAULT
-- =====================================================

SELECT
    cb_person_default_on_file,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
GROUP BY cb_person_default_on_file
ORDER BY default_rate DESC;


-- =====================================================
-- 8. DEFAULT RATE BY AGE GROUP
-- =====================================================

SELECT
    CASE
        WHEN person_age < 25 THEN 'Under 25'
        WHEN person_age BETWEEN 25 AND 34 THEN '25-34'
        WHEN person_age BETWEEN 35 AND 44 THEN '35-44'
        WHEN person_age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
WHERE person_age IS NOT NULL
GROUP BY age_group
ORDER BY default_rate DESC;


-- =====================================================
-- 9. DEFAULT RATE BY INCOME GROUP
-- =====================================================

SELECT
    CASE
        WHEN person_income < 30000 THEN 'Below 30K'
        WHEN person_income < 50000 THEN '30K-49K'
        WHEN person_income < 75000 THEN '50K-74K'
        WHEN person_income < 100000 THEN '75K-99K'
        ELSE '100K+'
    END AS income_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
GROUP BY income_group
ORDER BY default_rate DESC;

-- =====================================================
-- 10. DEFAULT RATE BY LOAN AMOUNT GROUP
-- =====================================================

SELECT
    CASE
        WHEN loan_amnt < 5000 THEN 'Below 5K'
        WHEN loan_amnt < 10000 THEN '5K-9.9K'
        WHEN loan_amnt < 15000 THEN '10K-14.9K'
        WHEN loan_amnt < 20000 THEN '15K-19.9K'
        ELSE '20K+'
    END AS loan_amount_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
GROUP BY loan_amount_group
ORDER BY default_rate DESC;


-- =====================================================
-- 11. DEFAULT RATE BY LOAN PERCENT INCOME
-- =====================================================

SELECT
    CASE
        WHEN loan_percent_income < 0.08 THEN 'Below 8%'
        WHEN loan_percent_income < 0.12 THEN '8%-11.99%'
        WHEN loan_percent_income < 0.16 THEN '12%-15.99%'
        WHEN loan_percent_income < 0.20 THEN '16%-19.99%'
        ELSE '20%+'
    END AS loan_percent_income_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
GROUP BY loan_percent_income_group
ORDER BY default_rate DESC;


-- =====================================================
-- 12. DEFAULT RATE BY LOAN-TO-INCOME GROUP
-- =====================================================

SELECT
    CASE
        WHEN loan_percent_income < 0.10 THEN 'Below 10%'
        WHEN loan_percent_income < 0.20 THEN '10%-19%'
        WHEN loan_percent_income < 0.30 THEN '20%-29%'
        WHEN loan_percent_income < 0.40 THEN '30%-39%'
        ELSE '40%+'
    END AS loan_income_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
GROUP BY loan_income_group
ORDER BY default_rate DESC;

-- =====================================================
-- 13. DEFAULT RATE BY INTEREST RATE GROUP
-- =====================================================

SELECT
    CASE
        WHEN loan_int_rate < 8 THEN 'Below 8%'
        WHEN loan_int_rate < 12 THEN '8%-11.99%'
        WHEN loan_int_rate < 16 THEN '12%-15.99%'
        WHEN loan_int_rate < 20 THEN '16%-19.99%'
        ELSE '20%+'
    END AS interest_rate_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
WHERE loan_int_rate IS NOT NULL
GROUP BY interest_rate_group
ORDER BY default_rate DESC;


-- =====================================================
-- 14. HOME OWNERSHIP + LOAN GRADE RISK
-- =====================================================

SELECT
    person_home_ownership,
    loan_grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
GROUP BY person_home_ownership, loan_grade
ORDER BY default_rate DESC;


-- =====================================================
-- 15. LOAN INTENT + LOAN GRADE RISK
-- =====================================================

SELECT
    loan_intent,
    loan_grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loan_data
GROUP BY loan_intent, loan_grade
ORDER BY default_rate DESC;


-- =====================================================
-- 16. FINAL DATA QUALITY CHECK
-- =====================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT person_age) AS unique_ages
FROM loan_data;