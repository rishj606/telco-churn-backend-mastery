CREATE OR REPLACE VIEW dim_customer AS
SELECT
    "customerID",
    "gender",
    "SeniorCitizen",
    "Partner",
    "Dependents"
FROM telco_churn_raw;
