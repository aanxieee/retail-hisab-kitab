--  retail sales analysis 
CREATE DATABASE retail_hisab_kitab;


--  table raw retail transactions 
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales
LIMIT 10


    

-- yeh query dekhne ke liye hai ki total kitni rows load hui hain
SELECT 
    COUNT(*) 
FROM retail_sales

-- ab data cleaning phase hoga, yahan null ya missing values ko identify karenge
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

-- yeh combined check sabhi important columns me null values dhundhne ke liye hai
SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- ab jo rows incomplete hain unhe delete karenge taaki analysis clean data par ho
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- ab exploration phase hoga, yahan se basic questions ka answer nikalenge

-- sabse pehle dekhte hain total kitni sales entries hain
SELECT COUNT(*) as total_sale FROM retail_sales

-- ab check karte hain kitne unique customers ne purchase kiya hai
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales



SELECT DISTINCT category FROM retail_sales


-- ab data analysis phase hoga, jahan se business questions ka answer milega

-- yahan se apni queries likh ke step by step learning aur findings note karenge

-- sql query jo 2022-11-05 wale saare sales records ko detail me dikhayegi

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- sql query jo clothing category me november 2022 me quantity 4 ya usse zyada wali sales dikhayegi

SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4

-- sql query jo har category ke liye total sales aur total orders nikaalegi

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

-- sql query jo beauty category ke customers ki average age find karegi

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category

-- sql query jo 1000 se upar total sale wali saari transactions dikhayegi

SELECT * FROM retail_sales
WHERE total_sale > 1000


-- sql query jo har category aur gender ke combination ke liye total transactions count karegi

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1


-- sql query jo har saal ke liye har month ki average sale nikaalegi aur best month identify karegi

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
    
-- ORDER BY 1, 3 DESC

-- sql query jo sabse zyada total sales wale top 5 customers dikhayegi

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- sql query jo har category ke liye unique customers ki counting karegi
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category


-- sql query jo sale_time se shift banayegi (morning, afternoon, evening) aur har shift me orders count karegi

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

-- sql query jo har category ke liye total quantity sold nikaalegi aur descending order me dikhayegi
SELECT 
    category,
    SUM(quantity) as total_qty_sold
FROM retail_sales
GROUP BY category
ORDER BY 2 DESC;
-- sql query jo dataset me highest total sales wala din dikhayegi
SELECT 
    sale_date,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY sale_date
ORDER BY total_sales DESC
LIMIT 1;
-- sql query jo har category ke liye average price per unit nikaalegi
SELECT
    category,
    AVG(price_per_unit) as avg_price_per_unit
FROM retail_sales
GROUP BY category;
-- sql query jo har category ke liye total cost of goods sold (cogs) nikaalegi
SELECT 
    category,
    SUM(cogs) as total_cogs
FROM retail_sales
GROUP BY category;
-- sql query jo 25 se 35 age range wale customers ki saari transactions dikhayegi
SELECT * FROM retail_sales
WHERE age BETWEEN 25 AND 35;
-- sql query jo december 2022 me har category ke total sales nikaalegi
SELECT
    category,
    SUM(total_sale) as total_sales_dec_2022
FROM retail_sales
WHERE TO_CHAR(sale_date, 'YYYY-MM') = '2022-12'
GROUP BY category;
-- sql query jo saturday aur sunday wale weekends par total transactions count karegi
SELECT
    COUNT(*) as total_weekend_transactions
FROM retail_sales
WHERE EXTRACT(DOW FROM sale_date) IN (0, 6);
-- sql query jo har gender ke liye average total sale nikaalne ke liye plan ki gayi hai (yahan se aage future me query complete hogi)

SELECT


