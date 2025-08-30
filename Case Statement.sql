-- Switch to the 'salesDB' database
USE salesDB;

-- Categorize orders based on sales amount and summarize total sales per category
SELECT 
    category, SUM(sales) AS total_sales
FROM
    (SELECT 
        orderID,
            sales,
            CASE
                WHEN sales > 50 THEN 'high'
                WHEN sales > 20 THEN 'medium'
                ELSE 'low'
            END AS category
    FROM
        orders) AS t
GROUP BY category
ORDER BY total_sales DESC;-- Show the category with the highest total sales first


SELECT 
    *,
    CASE
        WHEN gender = 'M' THEN 'Male'
        WHEN gender = 'F' THEN 'False'
        ELSE 'N/A'
    END AS gender
FROM
    employee;


-- Display customer records with standardized country codes using CASE with condition
SELECT 
    *,
    CASE
        WHEN country = 'USA' THEN 'US'
        WHEN country = 'Germany' THEN 'GER'
        ELSE 'N/A'
    END AS country_code
FROM
    customer;


-- Same as above, but using simple CASE instead of searched CASE
SELECT 
    *,
    CASE country
        WHEN 'USA' THEN 'US'
        WHEN 'Germany' THEN 'GER'
        ELSE 'N/A'
    END AS country_code
FROM
    customer;


-- Calculate average score, treating NULL scores as 0
SELECT 
    AVG(CASE
        WHEN score IS NULL THEN 0
        ELSE score
    END)
FROM
    customer;


-- Count high-value orders and total orders per customer
-- High-value: sales > 30
SELECT 
    customerID,
    SUM(CASE
        WHEN sales > 30 THEN 1
        ELSE 0
    END) AS total_orders,
    COUNT(*) AS total
FROM
    orders
GROUP BY customerID;


-- Summary statistics for each customer
-- Includes count, sum, average, max, and min of sales
SELECT 
    customerId,
    COUNT(*) AS order_count,
    SUM(sales) AS total_sales,
    AVG(sales) AS average_sales,
    MAX(sales) AS max_sale,
    MIN(sales) AS min_sale
FROM
    orders
GROUP BY customerId;
