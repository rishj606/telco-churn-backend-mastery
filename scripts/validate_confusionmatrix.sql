SELECT
    t."Churn" as actual_status,
    p.predicted_label,
    COUNT(*) as count
FROM public.predictions_churn p
JOIN public.telco_churn_clean t ON p.customer_id = t."customerID"
GROUP BY t."Churn", p.predicted_label
ORDER BY t."Churn";
