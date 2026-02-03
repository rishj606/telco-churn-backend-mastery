# PROJECT CONTEXT BRIEF: Telco Customer Churn & Retention Analytics

## User Profile
- Completed "Frontend Mastery" Power BI project (Superstore Sales) focused on UX/DAX.
- Building "Backend Mastery" portfolio project to demonstrate full-stack data skills (SQL + Python + Power BI).
- Target: Senior Data Analyst role; must align with PL-300 objectives.
- Skill Level: New to GitHub, Supabase, and Python integration; experienced in Power BI.

## Project Constraints (CRITICAL)
1. **Hybrid Environment**:
   - Personal PC: Hosts Supabase access, Python scripts, GitHub repo management, AND Power BI (connection issues on work laptop resolved by using personal PC).
   - Work Laptop: Originally planned for Power BI but connection failed; now using Personal PC for everything.
2. **Tech Stack (Free Tier)**:
   - Database: Supabase (PostgreSQL) - Cloud-hosted.
   - ETL: SQL (Views/Stored Procs in Supabase) - "Push to Source" philosophy (minimal Power Query).
   - Analytics: Python (Correlation Analysis, Churn Prediction) - Runs locally on Personal PC.
   - Visualization: Power BI Desktop.
3. **Connection Details (Supabase)**:
   - Using Transaction Pooler mode.
   - Port: 6543 (not default 5432).
   - Host: db.[project-id].supabase.co
   - Database: postgres
   - User: postgres
4. **GitHub Repo**: `telco-churn-backend-mastery`
   - Structure: `data/`, `scripts/`, `docs/`, `screenshots/`, `pbix/`
   - Naming: `screenshot-vX-feature.png` for images.

## Completed Work (Day 1 - Phase 1)
1. **GitHub Setup**: Repo created with folder structure, .gitkeep files pushed.
2. **Supabase Initialized**: Project "Telco Churn Analytics" created, public access enabled.
3. **SQL Schema Created**: Table `telco_churn_raw` with 21 quoted columns (case-sensitive to match CSV).
4. **CSV Imported**: ~7,043 rows loaded into `telco_churn_raw`.
5. **Cleaning View Created**: `telco_churn_clean` handles empty TotalCharges.
6. **Scripts Saved**: `scripts/create_schema.sql`, `scripts/create_clean_view.sql` pushed to GitHub.

## Current Status (Day 2 - Phase 2 In Progress)
- Power BI connected to Supabase successfully on Personal PC (Transaction Pooler, Port 6543).
- User can see `telco_churn_clean` view in Power Query Transform Data.
- **Paused**: About to create Star Schema dimension views in Supabase SQL before loading into Power BI.

## Star Schema Plan (To Be Implemented)
- **Fact Table**: `fact_churn` (customerID, Churn, Churn_Flag)
- **Dimensions**:
  - `dim_customer` (customerID, gender, SeniorCitizen, Partner, Dependents)
  - `dim_services` (customerID, PhoneService, MultipleLines, InternetService, OnlineSecurity, OnlineBackup, DeviceProtection, TechSupport, StreamingTV, StreamingMovies)
  - `dim_contract` (customerID, Contract, PaperlessBilling, PaymentMethod, tenure, MonthlyCharges, TotalCharges)

## Python Usage (Phase 3 - Future)
- Correlation Matrix: Calculate feature correlations with Churn.
- Predictive Model: Logistic Regression for Churn Probability Score (0-100%).
- Workflow: Supabase → Python (analyze) → Supabase (write scores) → Power BI (visualize).

## Project Roadmap
- Phase 1 (Days 1-2): Supabase Setup & Data Ingestion ✅ COMPLETE
- Phase 2 (Days 3-5): Power BI Connection & Star Schema Modeling ⏳ IN PROGRESS
- Phase 3 (Days 6-9): Python Advanced Analytics
- Phase 4 (Days 10+): UX, RLS, Final Documentation

## Immediate Next Steps
1. Create 4 SQL views in Supabase (dim_customer, dim_services, dim_contract, fact_churn).
2. Load all 4 views into Power BI.
3. Build relationships in Model View (Star Schema).
4. Save as `telco_churn.pbix`.

## Key Decisions Made
- Using quoted column names in SQL (e.g., "customerID") for CSV compatibility.
- Star Schema via SQL views (not Power Query) to align with "Push to Source" philosophy.
- Transaction Pooler + Port 6543 for Supabase connection.
- Personal PC used for all work (work laptop connection failed).
