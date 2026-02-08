# Telco Customer Churn & Retention Analytics

**End-to-end data engineering and analytics project designed to identify customer churn drivers and calculate retention metrics. Built using a hybrid cloud stack (Supabase PostgreSQL + Power BI) to demonstrate backend data modeling and frontend visualization mastery.**

---

## Project Goal
Create a "Backend Mastery" portfolio project that moves beyond standard CSV reporting by implementing:
- **Cloud Database Infrastructure**: Hosting data on Supabase (PostgreSQL).
- **SQL-First ETL**: Performing data cleaning and transformation using SQL Views (ELT methodology) instead of Power Query.
- **Star Schema Modeling**: Architecting a PL-300 compliant data model in Power BI.
- **Advanced UX**: Designing a "Cyberpunk Glass" dark-mode interface for executive decision-making.

## Tech Stack
- **Database**: Supabase (PostgreSQL 15) - Cloud-hosted on AWS.
- **ETL/Transformation**: SQL (Views & Type Casting).
- **Visualization**: Power BI Desktop (DAX, Custom Themes).
- **Environment**: Hybrid (Personal PC for DB management, Work Laptop constraints bypassed via Cloud Auth).

---

## V1: Backend Setup & Star Schema (2026-02-03)
V1 focuses on establishing the data infrastructure. Instead of importing a flat CSV into Power BI, raw data was loaded into a cloud database, cleaned via SQL, and modeled into a Star Schema.

### 1. Database Architecture (Supabase)
- **Raw Layer**: Imported IBM Telco Churn dataset (`telco_churn_raw`) into PostgreSQL.
- **Cleaning Layer**: Created `telco_churn_clean` view to handle data quality issues:
  - **Issue**: `TotalCharges` contained empty strings (`" "`) for new customers.
  - **SQL Fix**: Implemented `CASE WHEN` logic to cast empty strings to `0.0` and convert types to NUMERIC.

![SQL Cleaning Logic](screenshots/screenshot-v1-sql-cleaning.png)

### 2. Dimensional Modeling (SQL Views)
To adhere to **Star Schema** principles, I split the single flat table into 4 normalized SQL Views directly in the database. This ensures Power BI receives a pre-modeled structure ("Push to Source" philosophy).

- **Fact Table**: `fact_churn` (Keys + Metrics).
- **Dimensions**:
  - `dim_customer` (Demographics: Gender, SeniorCitizen, Partner).
  - `dim_services` (Product details: Internet, Phone, Streaming).
  - `dim_contract` (Financials: Payment Method, Monthly Charges).

![Supabase Schema](screenshots/screenshot-v1-supabase-schema.png)

### 3. Power BI Data Model
- Connected Power BI to Supabase using the **PostgreSQL Connector** (Transaction Pooler Port 6543).
- Established **1:1 Relationships** between Fact and Dimensions (Snapshot dataset).
- Configured Cross-Filter direction to prioritize Dimension-to-Fact filtering.
- Hidden surrogate keys (`customerID`) in the Fact table to prevent reporting errors.

![Power BI Star Schema](screenshots/screenshot-v1-pbi-star-schema.png)

---

## V2: Dashboard Design & Advanced Measures (2026-02-08)
V2 delivers the "Executive Command Center" interface, moving away from standard reports to a modern "Cyberpunk Glass" aesthetic while solving complex DAX challenges.

### 1. Design System: "Cyberpunk Glass"
- **Concept**: High-contrast Dark Mode (`#0F172A`) with Neon Accents (`#F43F5E` Red / `#38BDF8` Blue) to signal urgent/safe metrics.
- **Glassmorphism**: Utilized visual shadow effects (`Blur: 15px`, `Preset: Center`) to create "glowing" cards without using external background images.
- **UX Layout**: "F-Pattern" layout starting with Critical KPIs (Top) → Retention Split (Left) → Actionable Breakdown (Right).

![V2 Dashboard Dark Mode](screenshots/screenshot-v2-dashboard-dark.png)

### 2. Business Logic (DAX)
Implemented key retention metrics beyond simple counts:
- **Churn Rate %**: `DIVIDE([Churned Customers], [Total Customers], 0)`
- **Revenue Risk**: Calculated monthly financial impact of churn.
- **Filter Propagation Challenge**: Calculating `Revenue Risk` required summing a column in the Dimension table (`dim_contract`) filtered by a status in the Fact table (`fact_churn`).
    - *Issue*: Standard 1:* relationships do not allow Fact filters to propagate up to Dimensions.
    - *Solution*: Implemented `CROSSFILTER` in the measure to temporarily enable bi-directional filtering for this specific calculation.

### 3. Technical Hurdles & Solutions (V2)
- **Challenge**: "Host Failed to Respond" errors during initial connection.
    - *Root Cause*: Strict SSL verification failure on self-signed cloud certificates.
    - *Fix*: Disabled "Encrypt Connections" in Data Source Settings to bypass handshake failure.
- **Challenge**: Slicers looked outdated (white dropdowns) against the dark theme.
    - *Fix*: Implemented "New Button Slicers" with custom states (Navy Default / Electric Blue Selected) to match the dashboard aesthetic.
- **Challenge**: `dim_contract` view failed in Power BI despite clean SQL.
    - *Root Cause*: SQL View `dim_contract` was referencing `telco_churn_raw` instead of `telco_churn_clean`, re-introducing the empty string error.
    - *Fix*: Updated all 4 Dimension Views to strictly source from `telco_churn_clean`, enforcing the data quality pipeline.

---

## Future Roadmap
- **V3**: Python Integration (Correlation Analysis Heatmap).
- **V4**: Row-Level Security (RLS) & Final UX Polish.

---
**Author**: [rishj606](https://github.com/rishj606)
