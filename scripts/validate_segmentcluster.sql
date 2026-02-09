--This script validates the clusters segment wise

SELECT
    p.cluster_name,
    COUNT(*) as customer_count,
    ROUND(AVG(t."MonthlyCharges")::numeric, 2) as avg_bill,
    ROUND(AVG(t.tenure)::numeric, 1) as avg_tenure,
    ROUND(AVG(p.churn_prob)::numeric, 2) as avg_risk
FROM public.predictions_churn p
JOIN public.telco_churn_clean t ON p.customer_id = t."customerID"
GROUP BY p.cluster_name
ORDER BY avg_risk DESC;
