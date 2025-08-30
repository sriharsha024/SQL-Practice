-- Switch to the database
USE mydatabase;

-- Select all records from the 'customers' table
SELECT 
    *
FROM
    customers;

-- Select all records from the 'orders' table
SELECT 
    *
FROM
    orders;

-- INNER JOIN: Fetch records where customers have made orders
SELECT 
    c.id, c.first_name, o.order_date, o.order_id, o.sales
FROM
    customers AS c
        INNER JOIN
    orders AS o ON c.id = o.customer_id;

-- LEFT JOIN: Fetch all customers, including those without orders
SELECT 
    c.id, c.first_name, o.order_date, o.order_id, o.sales
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.id = o.customer_id;

-- RIGHT JOIN: Fetch all orders, including those without a matching customer
SELECT 
    o.order_date, o.order_id, o.sales, c.id, c.first_name
FROM
    customers AS c
        RIGHT JOIN
    orders AS o ON c.id = o.customer_id;

-- Equivalent LEFT JOIN with tables reversed: Fetch all orders, including those with no customer
SELECT 
    o.order_date, o.order_id, o.sales, c.id, c.first_name
FROM
    orders AS o
        LEFT JOIN
    customers AS c ON c.id = o.customer_id;

-- FULL OUTER JOIN equivalent using UNION:
-- Part 1: All customers and their orders (if any)
-- Part 2: All orders with no matching customer
SELECT 
    c.id AS customer_id,
    c.first_name,
    c.country,
    c.score,
    o.order_id,
    o.order_date,
    o.sales
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.id = o.customer_id 
UNION SELECT 
    c.id AS customer_id,
    c.first_name,
    c.country,
    c.score,
    o.order_id,
    o.order_date,
    o.sales
FROM
    orders AS o
        LEFT JOIN
    customers AS c ON o.customer_id = c.id
WHERE
    c.id IS NULL;

-- Customers who have not made any orders
SELECT 
    c.id, c.first_name, o.order_date, o.order_id, o.sales
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.id = o.customer_id
WHERE
    o.customer_id IS NULL;

-- Orders that do not belong to any customer
SELECT 
    o.order_date, o.order_id, o.sales, c.id, c.first_name
FROM
    customers AS c
        RIGHT JOIN
    orders AS o ON c.id = o.customer_id
WHERE
    c.id IS NULL;

-- Same as above, but starting from 'orders' table
SELECT 
    o.order_date, o.order_id, o.sales, c.id, c.first_name
FROM
    orders AS o
        LEFT JOIN
    customers AS c ON c.id = o.customer_id
WHERE
    c.id IS NULL;

-- UNION of:
-- 1. Customers without orders
-- 2. Orders without matching customers
-- This mimics a FULL OUTER JOIN with NULLs for missing matches
SELECT 
    c.id AS customer_id,
    c.first_name,
    c.country,
    c.score,
    NULL AS order_id,
    NULL AS order_date,
    NULL AS sales
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.id = o.customer_id
WHERE
    o.order_id IS NULL 
UNION SELECT 
    NULL AS customer_id,
    NULL AS first_name,
    NULL AS country,
    NULL AS score,
    o.order_id,
    o.order_date,
    o.sales
FROM
    orders AS o
        LEFT JOIN
    customers AS c ON o.customer_id = c.id
WHERE
    c.id IS NULL;

-- Customers who have made at least one order
SELECT 
    *
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.id = o.customer_id
WHERE
    o.customer_id IS NOT NULL;

-- CROSS JOIN: Cartesian product of customers and orders
-- Be cautious: this can produce a large number of rows
SELECT 
    *
FROM
    customers AS c
        CROSS JOIN
    orders AS o
ORDER BY c.id , o.customer_id;
