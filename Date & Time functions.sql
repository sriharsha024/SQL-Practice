-- Switch to the salesDB database
USE salesDB;

-- Retrieve basic order info
SELECT 
    orderID, orderDate, shipDate, creationTime
FROM
    orders;

-- Detailed date/time breakdown for orders, with explanations
SELECT 
    orderID,
    creationTime,
    '2026-08-02' AS hard_code,
    NOW() AS today,
    YEAR(creationTime) AS year,
    DATE(creationTime) AS day_start,
    DAY(creationTime) AS day,
    DAYOFYEAR(creationTime) AS dayyear,
    MONTH(creationTime) AS month,
    MONTHNAME(creationTime) AS monthname,
    DATE_FORMAT(creationTime, '%Y-%m-01') AS month_start,
    LAST_DAY(creationTime) AS month_end,
    WEEK(creationTime, 1) AS week,
    STR_TO_DATE(DATE_FORMAT(creationTime, '%x%v Monday'),
            '%x%v %W') AS week_start,
    DAYOFWEEK(creationTime) AS weekday,
    DAYNAME(creationTime) AS weekname,
    QUARTER(creationTime) AS quarter,
    HOUR(creationTime) AS hour
FROM
    orders;


-- Count orders grouped by first day of the month
SELECT 
    DATE_FORMAT(creationTime, '%Y-%m-01') AS month_start,
    COUNT(*) AS order_count
FROM
    orders
GROUP BY month_start;

-- Count orders grouped by first day of the year
SELECT 
    DATE_FORMAT(creationTime, '%Y-01-01') AS year_start,
    COUNT(*) AS order_count
FROM
    orders
GROUP BY year_start;

-- Count orders grouped by week starting Sunday
SELECT 
    STR_TO_DATE(DATE_FORMAT(creationTime, '%x%v Sunday'),
            '%x%v %W') AS week_start,
    COUNT(*) AS order_count
FROM
    orders
GROUP BY week_start;

-- Count orders grouped by order year
SELECT 
    YEAR(orderDate) AS order_year, COUNT(*) AS order_count
FROM
    orders
GROUP BY order_year;

-- Count orders grouped by month name
SELECT 
    MONTHNAME(orderDate) AS month_name, COUNT(*) AS order_count
FROM
    orders
GROUP BY month_name;

-- Retrieve all orders placed in February (month = 2)
SELECT 
    *
FROM
    orders
WHERE
    MONTH(orderDate) = 2;

-- Count orders grouped by quarter
SELECT 
    QUARTER(orderDate) AS order_quarter, COUNT(*) AS order_count
FROM
    orders
GROUP BY order_quarter;

-- Count orders grouped by week number
SELECT 
    WEEK(orderDate) AS order_week, COUNT(*) AS order_count
FROM
    orders
GROUP BY order_week;


-- Display different date formats for orderDate
SELECT 
    orderDate,
    DATE_FORMAT(orderDate, '%d %b %Y') AS format1,
    DATE_FORMAT(orderDate, '%d/%m/%Y') AS format2,
    DATE_FORMAT(orderDate, '%d %M %Y') AS format3,
    DATE_FORMAT(orderDate, '%d %b %y') AS format4
FROM
    orders;


-- Concatenate and format creationTime with quarter and time info
SELECT 
    creationTime,
    CONCAT(DATE_FORMAT(creationTime, '%d %a %b '),
            'Q',
            QUARTER(creationTime),
            ' ',
            DATE_FORMAT(creationTime, '%Y %h:%i:%s %p')) AS formatted_datetime
FROM
    orders;


-- Count orders grouped by month and year (e.g. August 25)
SELECT 
    DATE_FORMAT(orderDate, '%M %y') AS month_year,
    COUNT(*) AS order_count
FROM
    orders
GROUP BY month_year;


-- Demonstrate CAST conversions of various data types
SELECT 
    CAST(1234 AS CHAR) AS as_string,
    CAST('2025-08-21' AS CHAR) AS as_date_char,
    CAST('2025-08-21' AS DATETIME) AS as_datetime,
    CAST('2025-08-21' AS DATE) AS as_date,
    CAST('456' AS UNSIGNED) AS as_number,
    CAST(5 AS DECIMAL (5 , 2 )) AS as_decimal
;


-- Demonstrate DATE_ADD and DATE_SUB on creationTime with different intervals
SELECT 
    creationTime,
    DATE_ADD(creationTime,
        INTERVAL 10 MINUTE) AS add_10_minutes,
    DATE_SUB(creationTime,
        INTERVAL 10 MINUTE) AS sub_10_minutes,
    DATE_ADD(creationTime, INTERVAL 10 HOUR) AS add_10_hours,
    DATE_SUB(creationTime, INTERVAL 10 HOUR) AS sub_10_hours,
    DATE_ADD(creationTime, INTERVAL 10 DAY) AS add_10_days,
    DATE_SUB(creationTime, INTERVAL 10 DAY) AS sub_10_days,
    DATE_ADD(creationTime,
        INTERVAL 10 MONTH) AS add_10_months,
    DATE_SUB(creationTime,
        INTERVAL 10 MONTH) AS sub_10_months,
    DATE_ADD(creationTime, INTERVAL 10 YEAR) AS add_10_years,
    DATE_SUB(creationTime, INTERVAL 10 YEAR) AS sub_10_years
FROM
    orders;


-- Calculate days difference between current date and employee birthdate
SELECT 
    DATEDIFF(NOW(), birthdate) AS days_since_birth
FROM
    employee;

-- Calculate employee age in years using TIMESTAMPDIFF
SELECT 
    TIMESTAMPDIFF(YEAR,
        birthdate,
        CURDATE()) AS age_years
FROM
    employee;


-- Calculate average shipping days grouped by order month (rounded)
SELECT 
    MONTH(orderDate) AS order_month,
    ROUND(AVG(DATEDIFF(shipDate, orderDate)), 0) AS avg_shipping_days
FROM
    orders
GROUP BY order_month;


-- Use window function LAG to compare orderDate with previous orderDate and calculate difference
SELECT 
    orderID,
    orderDate,
    LAG(orderDate) OVER (ORDER BY orderDate) AS previous_orderDate,
    DATEDIFF(orderDate, LAG(orderDate) OVER (ORDER BY orderDate)) AS days_diff_from_prev
FROM orders;
