-- ========================================================
-- 📁 PROJECT TITLE: RETAIL SALES ANALYSIS USING SQL
-- 📊 DATASET: SQL - Retail Sales Analysis_utf.csv
-- 🛠️ TOOL: MySQL Workbench
-- ========================================================


-- ========================================================
-- CREATE TABLE
-- ========================================================

CREATE TABLE sql_project_p1.retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);


-- ========================================================
-- SAMPLE DATA PREVIEW
-- ========================================================

-- ========================================================
-- VIEWING FIRST 10 ROWS OF THE DATASET
-- ========================================================

SELECT 
    *
FROM
    sql_project_p1.retail_sales
LIMIT 10;

-- ========================================================
-- TOTAL ROWS IN DATASET
-- ========================================================

SELECT 
    COUNT(*)
FROM
    sql_project_p1.retail_sales;
    

-- ========================================================
-- DATA CLEANING : CHECK FOR NULLS
-- ========================================================

SELECT 
    *
FROM
    sql_project_p1.retail_sales
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR gender IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;
    

-- ====================================
-- DATA EXPLORATION
-- ====================================

-- ====================================
-- HOW MANY SALES HAVE BEEN RECORDED?
-- ====================================

SELECT 
    COUNT(*) AS total_sales
FROM
    sql_project_p1.retail_sales;

-- ====================================
-- HOW MANY UNIQUE CUSTOMERS ARE THERE?
-- ====================================

SELECT 
    COUNT(DISTINCT customer_id) AS total_sale
FROM
    sql_project_p1.retail_sales;

-- =============================================
-- HOW MANY UNIQUE PRODUCT CATEGORIES ARE THERE?
-- =============================================

SELECT DISTINCT
    category
FROM
    sql_project_p1.retail_sales;
    

-- ====================================================
-- DATA ANALYSIS & KEY BUSINESS PROBLEMS WITH SOLUTIONS
-- ====================================================

-- =======================================================
-- Q1. RETRIEVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'
-- =======================================================

SELECT 
    *
FROM
    sql_project_p1.retail_sales
WHERE
    sale_date = '2022-11-05';

-- ================================================================================================================================================
-- Q2. RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS GREATER THAN OR EQUAL TO 4 IN THE MONTH OF NOVEMBER 2022
-- ================================================================================================================================================

SELECT 
    *
FROM
    sql_project_p1.retail_sales
WHERE
    category = 'Clothing'
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
        AND quantity >= 4;
        
-- ====================================================================
-- Q3. CALCULATE THE TOTAL SALES FOR EACH PRODUCT CATEGORY
-- ====================================================================

SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM
    sql_project_p1.retail_sales
GROUP BY 1;

-- ====================================================================================
-- Q4. FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY
-- ====================================================================================

SELECT 
    ROUND(AVG(age)) AS avg_age
FROM
    sql_project_p1.retail_sales
WHERE
    category = 'Beauty';

-- ==============================================================================
-- Q5. RETRIEVE ALL TRANSACTIONS WHERE THE TOTAL_SALE AMOUNT IS GREATER THAN 1000
-- ==============================================================================

SELECT 
    *
FROM
    sql_project_p1.retail_sales
WHERE
    total_sale > 1000;

-- ===============================================================================
-- Q6. COUNT THE TOTAL NUMBER OF TRANSACTIONS MADE BY EACH GENDER IN EACH CATEGORY
-- ===============================================================================

SELECT 
    category, gender, COUNT(*) AS total_trans
FROM
    sql_project_p1.retail_sales
GROUP BY category , gender
ORDER BY 1;

-- ===============================================================================================
-- Q7. CALCULATE THE AVERAGE SALES FOR EACH MONTH AND IDENTIFY THE BEST SELLING MONTH IN EACH YEAR
-- ===============================================================================================

SELECT 
	year,
    month,
    avg_sale
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM sql_project_p1.retail_sales
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1
WHERE rnk = 1;

-- =================================================================
-- Q8. RETRIEVE THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES
-- =================================================================

SELECT 
    customer_id, SUM(total_sale) AS total_sales
FROM
    sql_project_p1.retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- ==============================================================================
-- Q9. FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY
-- ==============================================================================

SELECT 
    category, COUNT(DISTINCT customer_id) AS cnt_unique
FROM
    sql_project_p1.retail_sales
GROUP BY category;

-- ========================================================================================================
-- Q10. CREATE TIME-BASED SHIFTS (MORNING, AFTERNOON, EVENING) AND COUNT THE NUMBER OF ORDERS IN EACH SHIFT
-- ========================================================================================================

WITH hourly_sale
AS
(
SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS shift
FROM sql_project_p1.retail_sales
)
SELECT
	shift,
    COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift


-- ====================================
-- END OF PROJECT
-- ====================================







