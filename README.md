# Retail Hisab Kitab – SQL Mini Project

Unmanageable data → clean metrics → business insight → automation

## problem statement

- ek retail store ke paas saara sales data csv file me pada hai (transaction wise details: date, time, customer, gender, age, category, quantity, price, cogs, total_sale etc.).  
- raw file itni badi hai ki directly excel me samajhna mushkil hai – na pata lagta hai kitni sales hui, kaunse customers zyada kharid rahe hain, kaunsi category best perform kar rahi hai.  
- management ko chahiye simple metrics aur insights: total sales, unique customers, top categories, top customers, best month, weekend vs weekday performance, shifts (morning/afternoon/evening) ka effect, etc.

is project ka goal hai is raw, unmanageable data ko sql use karke clean metrics aur useful business insights me convert karna, taki aage chalke ye queries automation / dashboard me use ho saken.

## tech stack & data flow

- database: sql (standard relational database – create database + tables + queries).  
- data source: `sql - retail sales analysis_utf .csv` file jisme raw sales data hai.  
- main script: `sql_query_p1.sql` jisme poora flow likha hai – database & table creation, data cleaning, exploratory analysis aur business queries.

high level data flow:
1. **raw csv → sql table**: pehle `retail_sales` naam ka table create kiya gaya jisme transaction level columns define hain (transaction_id, sale_date, sale_time, customer_id, gender, age, category, quantity, price_per_unit, cogs, total_sale).  
2. **data cleaning**: null / missing values ko identify karke un rows ko delete kiya gaya jisse analysis galat na ho.  
3. **basic metrics**: total rows (sales), unique customers, distinct categories jaise questions ke answer nikale.  
4. **business analysis queries**: specific questions ki queries likhi gayi (date wise, category wise, customer wise, monthly & shift wise analysis).  
5. **automation-ready sql**: saari queries clearly structured hain, jise future me dashboards, reports ya scheduled jobs me reuse kiya ja sakta hai.

## phase 1 – unmanageable data → clean metrics

is phase me focus basic structure aur cleaning par hai:

- **database & table setup**  
  - `create database sql_project_p2;` se dedicated db banaya.  
  - `create table retail_sales (...)` se schema fix kiya jisse har column ka type clear ho (date, time, int, float, varchar, etc.).

- **data validation & cleaning**  
  - alag‑alag columns me null check kiya gaya (sale_date, sale_time, gender, category, quantity, cogs, total_sale).  
  - combined condition se wo rows identify ki gayi jahan essential fields missing hain.  
  - `delete from retail_sales where ... is null` se incomplete records hata diye, taki aage ke metrics reliable ho.

# Retail Hisab Kitab – SQL Mini Project

Unmanageable data → clean metrics → business insight → automation

## Problem Statement

- A retail store has all its sales data stored in a CSV file (transaction-level details: date, time, customer, gender, age, category, quantity, price, COGS, total_sale, etc.).  
- The raw file is large and difficult to analyze directly in Excel – it is hard to see how many sales happened, which customers buy the most, and which product categories perform the best.  
- Management needs simple metrics and insights: total sales, unique customers, top categories, top customers, best months, weekend vs weekday performance, and the impact of shifts (morning/afternoon/evening).

The goal of this project is to transform this raw, unmanageable data into clean metrics and actionable business insights using SQL, so that the same queries can later be used for automation or dashboards.

## Tech Stack & Data Flow

- **Database**: SQL (standard relational database – using CREATE DATABASE, CREATE TABLE, and SELECT queries).  
- **Data source**: `SQL - Retail Sales Analysis_utf .csv`, which contains the raw sales data.  
- **Main script**: `sql_query_p1.sql`, which contains the full workflow – database and table creation, data cleaning, exploratory analysis, and business queries.

High-level data flow:
1. **Raw CSV → SQL table**: Create the `retail_sales` table with all transaction-level columns (transaction_id, sale_date, sale_time, customer_id, gender, age, category, quantity, price_per_unit, COGS, total_sale).  
2. **Data cleaning**: Identify and remove rows with null or missing values in critical columns so that the analysis is not skewed.  
3. **Basic metrics**: Compute simple metrics like total rows (sales), unique customers, and distinct categories.  
4. **Business analysis queries**: Write targeted queries to analyze data by date, category, customer, month, and shift.  
5. **Automation-ready SQL**: Keep all queries structured and reusable so they can be plugged into dashboards, reports, or scheduled jobs later.

## Phase 1 – Unmanageable Data → Clean Metrics

In this phase the focus is on building the basic structure and cleaning the data:

- **Database & table setup**  
  - `CREATE DATABASE sql_project_p2;` creates a dedicated database for this mini-project.  
  - `CREATE TABLE retail_sales (...);` defines the schema, making each column’s data type explicit (date, time, integer, float, varchar, etc.).

- **Data validation & cleaning**  
  - Check for NULL values across key columns (sale_date, sale_time, gender, category, quantity, COGS, total_sale).  
  - Identify rows where any essential field is missing.  
  - Use `DELETE FROM retail_sales WHERE ... IS NULL` to remove incomplete records so that downstream metrics are reliable.

- **Core metrics**  
  - `COUNT(*)` to get the total number of sales records.  
  - `COUNT(DISTINCT customer_id)` to get the total number of unique customers.  
  - `SELECT DISTINCT category` to understand the spread of product categories.

Together, these steps convert the raw CSV into a clean, query-friendly table.

## Phase 2 – Clean Metrics → Business Insight

Once the data is cleaned, `sql_query_p1.sql` defines multiple business-oriented queries, such as:

- **Date-specific analysis**  
  - Retrieve all transactions for a specific date (for example, `2022-11-05`).

- **Category + quantity filters**  
  - For November 2022, fetch orders in the `Clothing` category where quantity ≥ 4 to understand bulk or high-value purchase patterns.

- **Category-wise performance**  
  - Use `SUM(total_sale)` and `COUNT(*)` per category to see which categories are strongest in terms of revenue and volume.  
  - Use `COUNT(DISTINCT customer_id)` per category to understand how many unique buyers each category attracts.

- **Customer segmentation**  
  - Find the top 5 customers based on `SUM(total_sale)` – useful for loyalty programs or targeted campaigns.  
  - Filter transactions for customers aged between 25 and 35 to study the behavior of a specific age segment.

- **Time-based insights**  
  - **Monthly**: Calculate `AVG(total_sale)` at a year–month level and identify the best-performing month in each year.  
  - **Shift-wise**: Derive `Morning`, `Afternoon`, and `Evening` shifts from `sale_time` and count how many orders fall into each shift – helpful for staffing and store timing decisions.  
  - **Daily peaks**: Find which `sale_date` has the highest total sales.  
  - **Weekend impact**: Count total transactions on Saturdays and Sundays to understand weekend traffic.

- **Pricing & cost insight**  
  - Use category-wise `AVG(price_per_unit)` to get a high-level view of pricing behavior.  
  - Use category-wise `SUM(COGS)` to understand cost structure, which can later feed into profit and margin analysis.

These queries show how simple SQL functions (SUM, AVG, COUNT, DISTINCT, GROUP BY, window functions, CASE WHEN, EXTRACT, TO_CHAR, etc.) can be used to answer real business questions.

## Phase 3 – Insight → Automation

Currently, the project is implemented as a single SQL script, but it is designed to be a foundation for future automation:

- The same queries can be used inside **BI dashboards** (Power BI, Tableau, Excel Power Query, etc.).  
- The queries can be wrapped into **scheduled reports** to generate daily or weekly summaries automatically.  
- Shift-wise, weekend-wise, and category-wise metrics can be integrated into an **alerting or KPI monitoring system**.

So the full journey looks like:

> Raw CSV (unmanageable data) → clean SQL table & metrics → clear business insight → future dashboard / automation-ready queries

## Learning Focus (Student Perspective)

This project is designed as a learning exercise to help understand:

- The end-to-end SQL flow: from creating a database and tables to writing analysis queries.  
- How to think about data cleaning, null handling, and basic data quality using a real dataset.  
- How to apply GROUP BY, window functions, date/time functions, and CASE WHEN in the context of practical business questions.  
- How to write SQL that can later be reused in dashboards or automation pipelines.

Possible next steps to extend this project:

- Add profit margin and trend analysis over time.  
- Build an interactive dashboard using the same SQL logic.  
- Convert core queries into views or stored procedures for better reusability.

## Author

Aanya Mittal – https://www.aanxiee.com/
