-- scripts/create_clean_view.sql
-- Create a view for initial data cleaning
-- Business Justification: Handles empty TotalCharges strings, enabling clean data for Power BI.

CREATE OR REPLACE VIEW telco_churn_clean AS
SELECT *,
       CASE WHEN "TotalCharges" = '' THEN 0 ELSE CAST("TotalCharges" AS NUMERIC) END AS TotalCharges_clean
FROM telco_churn_raw;
