-- Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(
            transactions_id	INT,
            sale_date DATE,
            sale_time TIME,
            customer_id INT,
            gender VARCHAR(15),
            age	INT,
            category VARCHAR(15),
            quantity INT,
            price_per_unit FLOAT,
            cogs FLOAT,
            total_sale FLOAT
			);

-- Whole table
SELECT * FROM retail_sales;

-- Count of ROWS
SELECT COUNT(*) FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE price_per_unit IS NULL;

SELECT * FROM retail_sales
WHERE 
	price_per_unit IS NULL
    OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
	age IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL
    ;

-- 
DELETE FROM retail_sales
WHERE 
	price_per_unit IS NULL
    OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
	age IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL
    ;
    
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) AS total_sale FROM retail_sales;

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) AS total_sael FROM retail_sales; 

-- What are the uniuqe categoryes?
SELECT DISTINCT category FROM retail_sales;

-- Data Analysis & Business Key Problem and Answers


-- Q.1 Write a SQL query to retrive all colums for sales made on '2022-11-05

 SELECT *
 FROM retail_sales 
 WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE
	category = 'Clothing'
    AND
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND 
    quantity >= 4;
    
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
   
SELECT 
	category,
    SUM(total_sale) as net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchesed item from the 'Beauty' category.

SELECT 
	ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > '1000';

-- Q.6 Write a SQL query to find the total number of trasactions (transactions_id) made by each gender in each category.

SELECT 
	category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP BY category,
    gender
ORDER BY 1;

-- Q.7 Wriete a SQL query to calculate the average sale for each month. Find out best selling month in each year.

SELECT 
	year, 
	month,
	avg_sale
FROM
(
SELECT 
	YEAR(sale_date) AS year,
	MONTH(sale_date) AS month,
	AVG(total_sale) AS avg_sale,
	RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranking
FROM retail_sales
GROUP BY 1,2
) AS t1
WHERE ranking = 1
-- ORDER BY 1,3 DESC
;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT * FROM retail_sales