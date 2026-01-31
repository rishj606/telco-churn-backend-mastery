-- scripts/create_schema.sql
-- Create the raw table for Telco Customer Churn dataset
-- Business Justification: This table stores unprocessed data for initial ingestion and cleaning, enabling ETL in Supabase without Power Query.

CREATE TABLE IF NOT EXISTS telco_churn_raw (
    customerID VARCHAR(20) PRIMARY KEY,  -- Unique identifier for each customer (string, up to 20 chars)
    gender VARCHAR(10),                  -- Customer gender (Male/Female)
    SeniorCitizen INTEGER,               -- Whether customer is a senior (0 or 1)
    Partner VARCHAR(5),                  -- Has partner (Yes/No)
    Dependents VARCHAR(5),               -- Has dependents (Yes/No)
    tenure INTEGER,                      -- Months with the company (integer)
    PhoneService VARCHAR(5),             -- Has phone service (Yes/No)
    MultipleLines VARCHAR(20),           -- Multiple lines option (Yes/No/No phone service)
    InternetService VARCHAR(20),         -- Internet service type (DSL/Fiber optic/No)
    OnlineSecurity VARCHAR(20),          -- Online security add-on (Yes/No/No internet service)
    OnlineBackup VARCHAR(20),            -- Online backup add-on (Yes/No/No internet service)
    DeviceProtection VARCHAR(20),        -- Device protection add-on (Yes/No/No internet service)
    TechSupport VARCHAR(20),             -- Tech support add-on (Yes/No/No internet service)
    StreamingTV VARCHAR(20),             -- Streaming TV add-on (Yes/No/No internet service)
    StreamingMovies VARCHAR(20),         -- Streaming movies add-on (Yes/No/No internet service)
    Contract VARCHAR(20),                -- Contract type (Month-to-month/One year/Two year)
    PaperlessBilling VARCHAR(5),         -- Paperless billing (Yes/No)
    PaymentMethod VARCHAR(30),           -- Payment method (e.g., Electronic check)
    MonthlyCharges NUMERIC(10,2),        -- Monthly charges (decimal, e.g., 29.85)
    TotalCharges VARCHAR(20),            -- Total charges (string due to some empty values; we'll clean later)
    Churn VARCHAR(5)                     -- Churn status (Yes/No)
);

-- Add a comment to the table for documentation
COMMENT ON TABLE telco_churn_raw IS 'Raw Telco Customer Churn data from Kaggle, ingested for analysis.';
