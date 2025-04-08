# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Tool**: MySQL Workbench  
**Database**: `sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), extracting meaningful business insights and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_p1;

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
```

### 2. Sample Data Preview, Data Exploration & Cleaning

- **Sample Data**: View first 10 rows of the dataset.
- **Record Count**: Determine the total number of records in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.

```sql
SELECT 
    *
FROM
    sql_project_p1.retail_sales
LIMIT 10;

SELECT 
    COUNT(*)
FROM
    sql_project_p1.retail_sales;

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

SELECT 
    COUNT(DISTINCT customer_id) AS total_sale
FROM
    sql_project_p1.retail_sales;

SELECT DISTINCT
    category
FROM
    sql_project_p1.retail_sales;
```

### 3. Data Analysis & Key Business Problems with Solutions

The following SQL queries were developed to answer specific business questions:

1. **Retrieve all columns for sales made on '2022-11-05'**:
```sql
SELECT 
    *
FROM
    sql_project_p1.retail_sales
WHERE
    sale_date = '2022-11-05';
```

2. **Retrieve all transactions where the category is 'clothing' and the quantity sold is greater than or equal to 4 in the month of November 2022**:
```sql
SELECT 
    *
FROM
    sql_project_p1.retail_sales
WHERE
    category = 'Clothing'
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
        AND quantity >= 4;
```

3. **Calculate the total sales for each category**:
```sql
SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM
    sql_project_p1.retail_sales
GROUP BY 1;
```

4. **Find the average age of customers who purchased items from the 'beauty' category**:
```sql
SELECT 
    ROUND(AVG(age)) AS avg_age
FROM
    sql_project_p1.retail_sales
WHERE
    category = 'Beauty';
```

5. **Retrieve all transactions where the total_sale amount is greater than 1000**:
```sql
SELECT 
    *
FROM
    sql_project_p1.retail_sales
WHERE
    total_sale > 1000;
```

6. **Count the total numbers of transactions made by each gender in each category**:
```sql
SELECT 
    category, gender, COUNT(*) AS total_trans
FROM
    sql_project_p1.retail_sales
GROUP BY category , gender
ORDER BY 1;
```

7. **Calculate the average sales for each month and identify the best selling month in each year**:
```sql
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
```

8. **Retrieve the top 5 customers based on the highest total sales**:
```sql
SELECT 
    customer_id, SUM(total_sale) AS total_sales
FROM
    sql_project_p1.retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

9. **Find the number of unique customers who purchased items from each category**:
```sql
SELECT 
    category, COUNT(DISTINCT customer_id) AS cnt_unique
FROM
    sql_project_p1.retail_sales
GROUP BY category;
```

10. **Create time based shifts (Morning, Afternoon, Evening) and count the number of orders in each shift**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

A comprehensive SQL project involving database creation, data preprocessing, exploratory analysis, and performance-driven queries. This analysis helps businesses gain actionable insights into customer trends, sales performance, and category-wise product performance to optimize strategies and enhance decision-making.

## How to Run the Project

1.	Import the dataset into your SQL environment (MySQL/PostgreSQL).
2.	Copy-paste the queries from sql_retail_sales_p1.sql into your SQL editor.
3.	Run them one by one to see the results and tweak as needed.



If you'd like to connect or collaborate on data projects, feel free to reach out on: 
• LinkedIn: 
• Email: adityaakumaarr@gmail.com
