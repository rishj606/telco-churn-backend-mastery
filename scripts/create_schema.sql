-- scripts/create_schema.sql (updated)
-- Create the raw table for Telco Customer Churn dataset with quoted column names to match CSV case
-- Business Justification: Ensures compatibility with Kaggle CSV headers for seamless import.

CREATE TABLE IF NOT EXISTS telco_churn_raw (
    "customerID" VARCHAR(20) PRIMARY KEY,
    "gender" VARCHAR(10),
    "SeniorCitizen" INTEGER,
    "Partner" VARCHAR(5),
    "Dependents" VARCHAR(5),
    "tenure" INTEGER,
    "PhoneService" VARCHAR(5),
    "MultipleLines" VARCHAR(20),
    "InternetService" VARCHAR(20),
    "OnlineSecurity" VARCHAR(20),
    "OnlineBackup" VARCHAR(20),
    "DeviceProtection" VARCHAR(20),
    "TechSupport" VARCHAR(20),
    "StreamingTV" VARCHAR(20),
    "StreamingMovies" VARCHAR(20),
    "Contract" VARCHAR(20),
    "PaperlessBilling" VARCHAR(5),
    "PaymentMethod" VARCHAR(30),
    "MonthlyCharges" NUMERIC(10,2),
    "TotalCharges" VARCHAR(20),
    "Churn" VARCHAR(5)
);

-- Add a comment to the table for documentation
COMMENT ON TABLE telco_churn_raw IS 'Raw Telco Customer Churn data from Kaggle, ingested for analysis.';
