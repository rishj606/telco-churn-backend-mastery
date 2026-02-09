import os
import pandas as pd
import numpy as np
from sqlalchemy import create_engine, text
from sqlalchemy.pool import NullPool
from sklearn.cluster import KMeans
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
from dotenv import load_dotenv

# 1. Load Credentials
load_dotenv()
db_string = os.getenv("DB_URL")

# DEBUG: Print host to confirm connection details
print(f"DEBUG: Connecting to host -> {db_string.split('@')[1].split(':')[0]}")

# Connect to Database (Using NullPool for Port 6543)
engine = create_engine(db_string, poolclass=NullPool)

print("Starting Analytics Pipeline...")

# 2. Fetch Data
# UPDATED: Changed "Churn_Label" to "Churn"
query = """
SELECT "customerID", "tenure", "MonthlyCharges", "TotalCharges", "Contract", "Churn"
FROM telco_churn_clean
"""
df = pd.read_sql(query, engine)
print(f"Data Fetched: {len(df)} rows")

# 3. Preprocessing
# Ensure TotalCharges is numeric and handle any missing values
df['TotalCharges'] = pd.to_numeric(df['TotalCharges'], errors='coerce').fillna(0)

# UPDATED: Convert 'Churn' (Yes/No) to 'Churn_Label' (1/0) for the model
df['Churn_Label'] = df['Churn'].apply(lambda x: 1 if x == 'Yes' else 0)

# Feature Selection for Clustering (The "Insight" Layer)
features = df[['tenure', 'MonthlyCharges', 'TotalCharges']]
scaler = StandardScaler()
features_scaled = scaler.fit_transform(features)

# 4. K-Means Clustering (Segmentation)
# Logic: Group customers into 3 personas (e.g., New/Low, Loyal/High, etc.)
kmeans = KMeans(n_clusters=3, random_state=42)
df['cluster_id'] = kmeans.fit_predict(features_scaled)

# Map clusters to generic names (You can rename these after analyzing the data)
cluster_map = {0: 'Segment A', 1: 'Segment B', 2: 'Segment C'}
df['cluster_name'] = df['cluster_id'].map(cluster_map)

# 5. Churn Prediction (Logistic Regression)
X = features_scaled
y = df['Churn_Label']

model = LogisticRegression()
model.fit(X, y)
probs = model.predict_proba(X)[:, 1] # Probability of Churn (0-1)

df['churn_prob'] = np.round(probs, 4)
# Create a text label for easy reading in Power BI
df['predicted_label'] = np.where(probs > 0.5, 'Likely Churn', 'Retain')

# 6. Risk Factor Identification
# Simple logic to explain "Why" they might churn
df['top_risk_factor'] = np.where(df['MonthlyCharges'] > 80, 'High Spend',
                                 np.where(df['tenure'] < 12, 'New Customer', 'Contract/Other'))

# 7. Write Back to Supabase
# Select only the columns we want to push back to the database
output_df = df[['customerID', 'churn_prob', 'predicted_label', 'cluster_id', 'cluster_name', 'top_risk_factor']]
# Rename columns to match the SQL table schema exactly
output_df.columns = ['customer_id', 'churn_prob', 'predicted_label', 'cluster_id', 'cluster_name', 'top_risk_factor']

print("Writing to Supabase...")

try:
    with engine.connect() as conn:
        # Clear the table first so we don't have duplicate predictions
        conn.execute(text("TRUNCATE TABLE public.predictions_churn"))
        conn.commit()
        
    # Append the new predictions
    output_df.to_sql('predictions_churn', engine, if_exists='append', index=False, schema='public')
    print("Success! Analytics data pushed to 'predictions_churn' table.")

except Exception as e:
    print(f"Error occurred: {e}")
