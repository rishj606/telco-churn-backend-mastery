CREATE OR REPLACE VIEW fact_churn AS
SELECT
    "customerID",
    "Churn",
    CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END AS "Churn_Flag"
FROM telco_churn_raw;
