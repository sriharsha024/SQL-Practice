-- Switch to the 'mydatabase' database
USE mydatabase;

-- Calculate the average score from the 'customers' table
-- If 'score' is NULL, treat it as 0 using COALESCE
SELECT 
    AVG(COALESCE(score, 0))
FROM
    customers;

-- Switch to the 'salesDB' database
USE salesDB;

-- Select full name and adjusted score from 'customer' table
-- Use COALESCE to handle NULLs in 'firstName' and 'lastName'
-- Concatenate first and last names with a space
-- Add 10 to the score, treating NULL as 0
SELECT 
    CONCAT(COALESCE(firstName, ''),
            ' ',
            COALESCE(lastName, '')) AS full_name,
    COALESCE(score, 0) + 10 AS score
FROM
    customer;

-- Select customer ID and score, and flag whether score is NULL
-- Order results to show non-NULL scores first
SELECT 
    customerID,
    score,
    CASE
        WHEN score IS NULL THEN 1
        ELSE 0
    END AS is_null_score
FROM
    customer
ORDER BY CASE
    WHEN score IS NULL THEN 1
    ELSE 0
END ASC;

-- Calculate sales price (sales divided by quantity)
-- Use NULLIF to avoid division by zero (returns NULL if quantity is 0)
SELECT 
    sales, quantity, sales / NULLIF(quantity, 0) AS sales_price
FROM
    orders;

-- Select all customers with NULL scores
SELECT 
    *
FROM
    customer
WHERE
    score IS NULL;

-- Select all customers with non-NULL scores
SELECT 
    *
FROM
    customer
WHERE
    score IS NOT NULL;

-- Find customers who have no corresponding order
-- LEFT JOIN keeps all customers; filter where order is missing (NULL)
SELECT 
    c.*, o.orderID
FROM
    customer AS c
        LEFT JOIN
    orders AS o ON c.customerId = o.customerID
WHERE
    o.customerId IS NULL;

-- Create a temporary table 'Orders' with 4 rows of category data
WITH Orders AS (
    SELECT 1 AS Id, 'A' AS Category UNION
    SELECT 2, NULL UNION
    SELECT 3, '' UNION
    SELECT 4, '   '
)
-- Apply transformation policies to 'Category' field
SELECT
    *,
    TRIM(Category) AS Policy1,  -- Remove spaces
    NULLIF(TRIM(Category), '') AS Policy2,  -- Set to NULL if empty after trimming
    COALESCE(NULLIF(TRIM(Category), ''), 'unknown') AS Policy3  -- Replace NULL/empty with 'unknown'
FROM Orders;
