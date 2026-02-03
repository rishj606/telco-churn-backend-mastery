CREATE OR REPLACE VIEW dim_contract AS
SELECT
    "customerID",
    "Contract",
    "PaperlessBilling",
    "PaymentMethod",
    "tenure",
    "MonthlyCharges",
    CASE 
        WHEN "TotalCharges" = '' THEN 0 
        ELSE CAST("TotalCharges" AS NUMERIC) 
    END AS "TotalCharges"
FROM telco_churn_raw;
