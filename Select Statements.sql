-- Select the database to work with
USE MyDatabase;

-- Display all records from the customers table
SELECT *
FROM customers;

-- Display all records from the orders table
SELECT *
FROM orders;

-- Select specific columns from customers
SELECT 
    first_name, 
    country, 
    score
FROM customers;

-- Select customers whose score is not zero
SELECT 
    id,
    first_name, 
    score
FROM customers
WHERE score != 0;

-- Select customers from Germany (case-sensitive depending on DBMS)
SELECT 
    id,
    first_name, 
    country
FROM customers
WHERE country = "GERMANY";  -- Note: May need 'Germany' depending on case sensitivity

-- Display all customers ordered by score from highest to lowest
SELECT *
FROM customers
ORDER BY score DESC;

-- Display all customers ordered by score from lowest to highest
SELECT *
FROM customers
ORDER BY score ASC;

-- Display all customers ordered alphabetically by country
SELECT *
FROM customers
ORDER BY country ASC;

-- Display all customers ordered by country (A–Z), and within each country by highest score
SELECT *
FROM customers
ORDER BY country ASC, score DESC;

-- Show total score and number of customers per country
SELECT 
    country,
    SUM(score) AS total_score,
    COUNT(*) AS total_customers
FROM customers
GROUP BY country;

-- Show countries where total score > 900 OR more than 1 customer
SELECT 
    country,
    SUM(score) AS total_score,
    COUNT(*) AS total_customers
FROM customers
GROUP BY country
HAVING total_score > 900 OR total_customers > 1;

-- Show countries with customers having score > 400, 
-- and only include groups where the total score > 700
SELECT 
    country,
    SUM(score) AS total_score,
    COUNT(*) AS total_customers
FROM customers
WHERE score > 400
GROUP BY country
HAVING total_score > 700;

-- Show average score per country for customers with non-zero score,
-- and only include countries where the average is greater than 430
SELECT 
    country,
    AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING avg_score > 430;

-- Display unique countries from the customers table
SELECT DISTINCT
    country
FROM customers;

-- Limit result to first 10 customers (MySQL/PostgreSQL syntax)
SELECT *
FROM customers
LIMIT 10;

-- Get top 3 customers by score (highest scores first)
SELECT *
FROM customers
ORDER BY score DESC
LIMIT 3;

-- Get bottom 2 customers by score (lowest scores first)
SELECT *
FROM customers
ORDER BY score ASC
LIMIT 2;

-- Get the 2 most recent orders (by order date descending)
SELECT *
FROM orders 
ORDER BY order_date DESC
LIMIT 2;

-- Select a constant numeric value
SELECT 456 AS num;

-- Select a constant text value
SELECT "SQL LEARN" AS txt;

-- Add a fixed label 'New customer' for each record from customers
SELECT 
    first_name, 
    country, 
    "New customer" AS customer_type
FROM customers;
