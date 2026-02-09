-- This script helps validate the Churn risk buckets

SELECT
  CASE
    WHEN p.churn_prob < 0.2 THEN '0.0 - 0.2 (Safe)'
    WHEN p.churn_prob < 0.4 THEN '0.2 - 0.4 (Low Risk)'
    WHEN p.churn_prob < 0.6 THEN '0.4 - 0.6 (Uncertain)'
    WHEN p.churn_prob < 0.8 THEN '0.6 - 0.8 (High Risk)'
    ELSE '0.8 - 1.0 (Gone)'
  END as risk_bucket,
  COUNT(*) as count,
  ROUND(AVG(t.tenure)::numeric, 1) as avg_tenure
FROM predictions_churn p
JOIN telco_churn_clean t ON p.customer_id = t."customerID"
GROUP BY 1
ORDER BY 1;
