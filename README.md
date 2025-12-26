# Retail Hisab Kitab – SQL Mini Project

Turn raw CSV sales data into clean SQL metrics, business insights, and automation‑ready queries.

## Problem Statement

- A retail store has all its sales data stored in a CSV file with transaction‑level details: date, time, customer, gender, age, category, quantity, price, COGS, total_sale, etc.  
- The raw file is large and difficult to analyze directly in Excel – it is hard to quickly see how many sales happened, which customers buy the most, or which product categories perform the best.  
- Management wants simple, reliable metrics and insights: total sales, number of unique customers, top categories, top customers, best months, weekend vs weekday performance, and the impact of shifts (morning/afternoon/evening).

The goal of this project is to transform raw, unmanageable data into clean metrics and actionable business insights using SQL. The same queries can later be reused in dashboards, scheduled reports, or automation scripts.

## Tech Stack & Data Flow

- **Database**: Any standard SQL relational database (using `CREATE DATABASE`, `CREATE TABLE`, and `SELECT` queries).  
- **Data source**: `SQL - Retail Sales Analysis_utf .csv`, which contains the raw sales data.  
- **Main script**: `sql_query_p1.sql`, which contains the full workflow – database and table creation, data cleaning, exploratory analysis, and business queries.

High‑level data flow:
1. **Raw CSV → SQL table**  
   Create the `retail_sales` table with all transaction‑level columns: `transaction_id`, `sale_date`, `sale_time`, `customer_id`, `gender`, `age`, `category`, `quantity`, `price_per_unit`, `COGS`, `total_sale`.  
2. **Data cleaning**  
   Identify and remove rows with null or missing values in critical columns so that the analysis is accurate and not biased.  
3. **Basic metrics**  
   Calculate simple metrics such as total number of sales (rows), unique customers, and distinct product categories.  
4. **Business analysis queries**  
   Run focused queries by date, category, customer, month, and time‑of‑day shifts to answer real business questions.  
5. **Automation‑ready SQL**  
   Keep all queries clearly structured so they can be reused in dashboards, reports, or scheduled jobs.

## Phase 1 – Unmanageable Data → Clean Metrics

In this phase, the focus is on building the basic structure and cleaning the data.

- **Database & table setup**  
  - `CREATE DATABASE sql_project_p2;` creates a dedicated database for this mini‑project.  
  - `CREATE TABLE retail_sales (...);` defines the schema so that each column has a clear data type (date, time, integer, float, varchar, etc.).

- **Data validation & cleaning**  
  - Check for `NULL` values in key columns (`sale_date`, `sale_time`, `gender`, `category`, `quantity`, `COGS`, `total_sale`).  
  - Identify rows where any essential field is missing.  
  - Use `DELETE FROM retail_sales WHERE ... IS NULL` to remove incomplete records so that downstream metrics are reliable.

- **Core metrics**  
  - `COUNT(*)` to get the total number of sales records.  
  - `COUNT(DISTINCT customer_id)` to get the total number of unique customers.  
  - `SELECT DISTINCT category` to see the spread of product categories.

Together, these steps convert the raw CSV file into a clean, query‑friendly SQL table.

## Phase 2 – Clean Metrics → Business Insight

Once the data is cleaned, `sql_query_p1.sql` defines multiple business‑oriented queries, including:

- **Date‑specific analysis**  
  - Retrieve all transactions for a specific date (for example, `2022-11-05`).

- **Category + quantity filters**  
  - For November 2022, fetch orders in the `Clothing` category where `quantity ≥ 4` to study bulk or high‑value purchases.

- **Category‑wise performance**  
  - Use `SUM(total_sale)` and `COUNT(*)` per category to find which categories drive the most revenue and volume.  
  - Use `COUNT(DISTINCT customer_id)` per category to see how many unique buyers each category attracts.

- **Customer segmentation**  
  - Find the top 5 customers based on `SUM(total_sale)` – useful for loyalty programs or targeted campaigns.  
  - Filter transactions for customers aged between 25 and 35 to analyze a specific age segment.

- **Time‑based insights**  
  - **Monthly**: Calculate `AVG(total_sale)` at a year–month level and identify the best‑performing month in each year.  
  - **Shift‑wise**: Derive `Morning`, `Afternoon`, and `Evening` shifts from `sale_time` using a `CASE WHEN` expression, then count how many orders fall into each shift – useful for staffing and store‑timing decisions.  
  - **Daily peaks**: Find which `sale_date` has the highest total sales.  
  - **Weekend impact**: Count total transactions on Saturdays and Sundays to understand weekend traffic.

- **Pricing & cost insight**  
  - Use category‑wise `AVG(price_per_unit)` to get a high‑level view of pricing.  
  - Use category‑wise `SUM(COGS)` to understand cost structure, which can later be extended to profit and margin analysis.

These queries show how standard SQL functions such as `SUM`, `AVG`, `COUNT`, `DISTINCT`, `GROUP BY`, window functions, date/time functions, and `CASE WHEN` can be used to answer real business questions.

## Phase 3 – Insight → Automation

Right now, the project is implemented as a single SQL script, but it is designed as a foundation for future automation:

- The same queries can power **BI dashboards** (Power BI, Tableau, Excel Power Query, etc.).  
- The queries can be wrapped into **scheduled reports** to generate daily or weekly summaries automatically.  
- Shift‑wise, weekend‑wise, and category‑wise metrics can be integrated into an **alerting or KPI monitoring system**.

End‑to‑end journey:

> Raw CSV (unmanageable data) → clean SQL tables & metrics → clear business insight → dashboard / automation‑ready queries

## Learning Focus

From a student or beginner’s perspective, this project helps you learn:

- The end‑to‑end SQL workflow: from creating a database and tables to writing analysis queries.  
- How to think about data cleaning, `NULL` handling, and basic data quality on a real dataset.  
- How to apply `GROUP BY`, window functions, date/time functions, and `CASE WHEN` to practical business questions.  
- How to write SQL that can later be reused in dashboards or automation pipelines.

Possible next steps to extend the project:

- Add profit, margin, and trend analysis over time.  
- Build an interactive dashboard using the same SQL logic.  
- Convert core queries into views or stored procedures for easier reuse.

## Author

**Aanya Mittal** – https://www.aanxiee.com/
