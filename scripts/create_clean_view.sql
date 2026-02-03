-- scripts/create_clean_view.sql
-- Create a view for initial data cleaning
-- Business Justification: Handles empty TotalCharges strings, enabling clean data for Power BI.

-- changed the script to handle '' as well as ' '
CREATE VIEW telco_churn_clean AS
SELECT
    "customerID",
    "gender",
    "SeniorCitizen",
    "Partner",
    "Dependents",
    "tenure",
    "PhoneService",
    "MultipleLines",
    "InternetService",
    "OnlineSecurity",
    "OnlineBackup",
    "DeviceProtection",
    "TechSupport",
    "StreamingTV",
    "StreamingMovies",
    "Contract",
    "PaperlessBilling",
    "PaymentMethod",
    "MonthlyCharges",
    "Churn",
    -- The Fix: Handle ' ' (space), '' (empty), and NULL
    CAST(
        CASE 
            WHEN "TotalCharges" = ' ' THEN '0'
            WHEN "TotalCharges" = '' THEN '0'
            WHEN "TotalCharges" IS NULL THEN '0'
            ELSE "TotalCharges"
        END AS NUMERIC
    ) AS "TotalCharges"
FROM telco_churn_raw;
