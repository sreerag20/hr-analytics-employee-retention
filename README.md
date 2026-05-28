# HR Analytics – Employee Retention Dashboard

> End-to-end HR analytics project analyzing employee attrition, work-life balance, job satisfaction, and retention patterns across 50,000 employee records using SQL, Excel, Tableau, and Power BI.

![SQL](https://img.shields.io/badge/SQL-MySQL-blue?logo=mysql&logoColor=white)
![Excel](https://img.shields.io/badge/Data-Excel-217346?logo=microsoft-excel&logoColor=white)
![Tableau](https://img.shields.io/badge/Viz-Tableau-E97627?logo=tableau&logoColor=white)
![PowerBI](https://img.shields.io/badge/Viz-PowerBI-F2C811?logo=powerbi&logoColor=black)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

---

## Table of Contents

- [Project Overview](#project-overview)
- [Tech Stack](#tech-stack)
- [Folder Structure](#folder-structure)
- [Data Sources](#data-sources)
- [How to Run / Reproduce](#how-to-run--reproduce)
- [Key Findings](#key-findings)
- [Future Improvements](#future-improvements)
- [License](#license)

---

## Project Overview

This project performs a comprehensive analysis of HR employee data to identify drivers of attrition, understand compensation and satisfaction trends, and surface actionable retention insights for HR leadership.

Two interactive dashboards were built:

- **Tableau Dashboard** (`hr_tableau_dashboard.twb`) — Focuses on department-level KPIs: attrition rates, employee count distribution, average working years, job-role satisfaction, and work-life balance scores.
- **Power BI Dashboard** — Employee Retention view with gauge KPIs (50K total employees, 25K active, 25K male, 25K female), income-vs-attrition by department, promotion tenure analysis, and a job role vs work-life balance breakdown table.

The analysis pipeline begins with raw Excel data, proceeds through MySQL for data transformation and feature engineering, and culminates in visual dashboards designed for non-technical stakeholders.

---

## Tech Stack

| Layer         | Tool / Format            | Purpose                                        |
|---------------|--------------------------|------------------------------------------------|
| Raw Data      | Microsoft Excel (.xlsx)  | Source employee records (HR_1, HR_2)           |
| Database      | MySQL                    | Schema creation, joins, aggregations           |
| Query Script  | SQL (.sql)               | 8 analytical queries across both tables        |
| Visualization | Tableau (.twb)           | Interactive departmental HR dashboard          |
| Visualization | Power BI (.pbix)         | Employee retention KPI dashboard               |
| Presentation  | PowerPoint (.pptx)       | Project summary and findings deck              |

---

## Folder Structure

```
hr-analytics-employee-retention/
│
├── data/
│   ├── raw/
│   │   ├── hr_1_raw.xlsx            # Employee demographics & job attributes (50K rows)
│   │   └── hr_2_raw.xlsx            # Compensation, satisfaction & tenure (50K rows)
│   └── processed/
│       └── hr_combined_export.csv   # Merged dataset after SQL join (optional export)
│
├── sql/
│   └── hr_analytics_final.sql       # All 8 analytical queries
│
├── dashboards/
│   ├── hr_tableau_dashboard.twb     # Tableau workbook
│   └── hr_analytics_powerbi.pbix    # Power BI report file
│
├── visualizations/
│   ├── tableau_dashboard_v1.png     # Screenshot of Tableau dashboard
│   └── powerbi_retention_v1.png     # Screenshot of Power BI dashboard
│
├── presentations/
│   ├── P214_project_bootcamp.pptx   # Project bootcamp deck
│   └── hr_analytics_slides.pptx     # HR analytics findings presentation
│
├── docs/
│   └── data_dictionary.md           # Field definitions for both HR tables
│
├── .gitignore
├── LICENSE
└── README.md
```

---

## Data Sources

### HR_1 — Employee Demographics & Job Attributes
- **File:** `data/raw/hr_1_raw.xlsx`
- **Rows:** 50,000 &nbsp;|&nbsp; **Columns:** 18

| Field                   | Type    | Description                                          |
|-------------------------|---------|------------------------------------------------------|
| `EmployeeNumber`        | INT     | Unique employee identifier (join key)                |
| `Age`                   | INT     | Employee age                                         |
| `Attrition`             | VARCHAR | Whether employee left: `Yes` / `No`                  |
| `Department`            | VARCHAR | Hardware, HR, R&D, Sales, Software, Support          |
| `Gender`                | VARCHAR | Male / Female                                        |
| `JobRole`               | VARCHAR | Role title (10 distinct roles)                       |
| `JobSatisfaction`       | INT     | Rating 1–4                                           |
| `HourlyRate`            | FLOAT   | Hourly compensation                                  |
| `BusinessTravel`        | VARCHAR | Travel frequency                                     |
| `MaritalStatus`         | VARCHAR | Single / Married / Divorced                          |

### HR_2 — Compensation, Satisfaction & Tenure
- **File:** `data/raw/hr_2_raw.xlsx`
- **Rows:** 50,000 &nbsp;|&nbsp; **Columns:** 18

| Field                      | Type    | Description                                       |
|----------------------------|---------|---------------------------------------------------|
| `EmployeeID`               | INT     | Foreign key → `HR_1.EmployeeNumber`               |
| `MonthlyIncome`            | FLOAT   | Monthly salary                                    |
| `TotalWorkingYears`        | INT     | Total career experience in years                  |
| `WorkLifeBalance`          | INT     | Rating 1–4                                        |
| `PerformanceRating`        | INT     | Rating 1–4                                        |
| `YearsSinceLastPromotion`  | INT     | Tenure since last promotion                       |
| `YearsAtCompany`           | INT     | Years with current employer                       |
| `OverTime`                 | VARCHAR | Whether employee works overtime                   |

> **Join Key:** `HR_1.EmployeeNumber = HR_2.EmployeeID`

---

## How to Run / Reproduce

### Prerequisites
- MySQL 8.0+
- Tableau Desktop (to open `.twb`)
- Power BI Desktop (to open `.pbix`)
- Microsoft Excel or LibreOffice Calc

### Step 1 — Set Up the Database

```sql
CREATE SCHEMA hr_analyst;
USE hr_analyst;
```

### Step 2 — Import Raw Data

Import `hr_1_raw.xlsx` and `hr_2_raw.xlsx` into MySQL as `hr_1csv` and `hr_2csv` using MySQL Workbench's Table Data Import Wizard, or convert to CSV first:

```bash
python3 -c "
import pandas as pd
pd.read_excel('data/raw/hr_1_raw.xlsx').to_csv('data/raw/hr_1.csv', index=False)
pd.read_excel('data/raw/hr_2_raw.xlsx').to_csv('data/raw/hr_2.csv', index=False)
"
```

### Step 3 — Run SQL Queries

```bash
mysql -u your_user -p hr_analyst < sql/hr_analytics_final.sql
```

The script executes 8 analytical queries covering:

1. Average attrition rate by department
2. Average hourly rate for male Research Scientists
3. Attrition rate vs monthly income by department
4. Average working years per department
5. Job role vs work-life balance ratings
6. Attrition rate vs years since last promotion by job role
7. Job role vs average job satisfaction
8. Gender vs average work-life balance

### Step 4 — Open Dashboards

**Tableau:**
```
File → Open → dashboards/hr_tableau_dashboard.twb
```
Reconnect the data source to your local MySQL instance or CSV exports if prompted.

**Power BI:**
```
File → Open → dashboards/hr_analytics_powerbi.pbix
```

---

## Key Findings

- **Research & Development has the highest attrition rate (~51.21%)** despite competitive average monthly incomes (~$26,058), suggesting compensation alone does not drive retention in technical roles.
- **Average working years are consistent across all departments (~20.3–20.6 years)**, indicating a tenured workforce with potential promotion bottlenecks contributing to attrition.
- **Sales Representatives have the highest total work-life balance scores (12,542)** while also showing elevated attrition, pointing to burnout as a compounding retention risk.
- **Gender split is nearly equal (50.12% Female, 49.88% Male)** with negligible difference in average work-life balance scores, suggesting gender is not a primary driver of satisfaction disparities.

---

## Future Improvements

1. **Predictive Attrition Modeling** — Build a logistic regression or random forest classifier using the combined HR dataset to predict individual attrition probability, enabling proactive HR intervention.
2. **Time-Series Analysis** — Incorporate hire date and exit date fields to enable cohort-based attrition trending across fiscal quarters.
3. **Live Dashboard Publishing** — Publish to Tableau Public or Power BI Service for stakeholder access without requiring desktop software installation.

---

## License

This project is licensed under the [MIT License](LICENSE).

> Dataset is synthetic/anonymized HR data used for educational and analytical purposes only.
