-- Switch to the salesDB database
USE salesDB;

-- ===========================================
-- 1. Total Sales Calculations
-- ===========================================

SELECT 
    SUM(sales) AS totalSales
FROM
    orders;

-- Total sales grouped by productId
SELECT 
    productId, SUM(sales) AS totalSalesByProductId
FROM
    orders
GROUP BY productId;

-- ===========================================
-- 2. Window Functions for Sales Analysis
-- ===========================================

-- Running total sales per productId ordered by orderDate descending
SELECT 
    orderID, 
    orderDate, 
    productId,
    sales,
    SUM(sales) OVER (
        PARTITION BY productId 
        ORDER BY orderDate DESC
    ) AS runningTotalSalesByProductId
FROM 
    orders;

-- Total sales across all orders using window function
SELECT 
    orderID, 
    orderDate,
    SUM(sales) OVER () AS totalSales
FROM 
    orders;

-- Total sales across all orders and per productId using window functions
SELECT 
    orderID, 
    orderDate, 
    productId,
    sales,
    SUM(sales) OVER () AS totalSales,
    SUM(sales) OVER (PARTITION BY productId) AS totalSalesByProductId
FROM 
    orders;

-- Total sales across all orders, per productId, and per productId with orderStatus
SELECT 
    orderID, 
    orderDate, 
    productId,
    sales,
    orderStatus,
    SUM(sales) OVER () AS totalSales,
    SUM(sales) OVER (PARTITION BY productId) AS totalSalesByProductId,
    SUM(sales) OVER (PARTITION BY productId, orderStatus) AS totalSalesByProductIdAndOrderStatus
FROM 
    orders;

-- ===========================================
-- 3. Ranking and Aggregation
-- ===========================================

-- Rank orders by sales in descending order
SELECT 
    orderID, 
    orderDate,
    sales,
    RANK() OVER(ORDER BY sales DESC) AS rankSales
FROM 
    orders;

-- Sum of sales within the current row and next 2 rows per orderStatus
SELECT 
    orderID,
    orderDate,
    orderStatus,
    sales,
    SUM(sales) OVER(
        PARTITION BY orderStatus 
        ORDER BY orderStatus 
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS sumFollowingRows
FROM 
    orders;

-- Sum of sales for the current and previous 2 rows per orderStatus
SELECT 
    orderID,
    orderDate,
    orderStatus,
    sales,
    SUM(sales) OVER(
        PARTITION BY orderStatus 
        ORDER BY orderStatus 
        ROWS 2 PRECEDING
    ) AS sumPrecedingRows
FROM 
    orders;

-- Sales per product (101, 102) and orderStatus
SELECT 
    orderID,
    orderDate,
    orderStatus,
    productId,
    sales,
    SUM(sales) OVER(PARTITION BY orderStatus) AS salesByStatus
FROM 
    orders
WHERE 
    productID IN (101, 102);

-- Rank customers by total sales (descending)
SELECT 
    customerID, 
    SUM(sales) AS TotalSales,
    RANK() OVER(ORDER BY SUM(sales) DESC) AS RankCustomers
FROM 
    orders 
GROUP BY 
    customerID;

-- Count number of orders per productId
SELECT 
    customerID, 
    orderID,
    productId,
    COUNT(sales) OVER(PARTITION BY productID) AS orderCountByProduct
FROM 
    orders;

-- Count total and per-customer orders
SELECT 
    orderId,
    orderDate,
    customerID,
    COUNT(*) OVER() AS TotalOrders,
    COUNT(*) OVER(PARTITION BY customerID) AS CustomerOrders
FROM 
    orders;

-- ===========================================
-- 4. Customer Data Aggregation
-- ===========================================

-- Count total rows, scores, and countries in customer table
SELECT 
    *, 
    COUNT(*) OVER() AS totalCustomers,
    COUNT(score) OVER() AS TotalScores,
    COUNT(country) OVER() AS TotalCountries
FROM 
    customer;

-- ===========================================
-- 5. Primary Key Integrity Check
-- ===========================================

-- Check for duplicates in orderID in 'orders' table
SELECT 
    orderId,
    COUNT(*) OVER(PARTITION BY orderID) AS CheckPK
FROM 
    orders;

-- Check for duplicates in orderID in 'ordersArchive' table
SELECT 
    orderId,
    COUNT(*) OVER(PARTITION BY orderID) AS CheckPK
FROM 
    ordersArchive;

-- Find duplicate orderIDs in 'ordersArchive'
SELECT 
    * 
FROM (
    SELECT 
        orderId,
        COUNT(*) OVER(PARTITION BY orderID) AS CheckPK 
    FROM 
        ordersArchive
) AS t 
WHERE 
    CheckPK > 1;

-- ===========================================
-- 6. Percentage Contribution of Sales
-- ===========================================

-- Calculate sales by product, total sales, and percentage contribution
SELECT 
    orderId,
    orderDate,
    sales,
    productID,
    SUM(sales) OVER(PARTITION BY productId) AS salesByProduct, 
    SUM(sales) OVER() AS totalSales,
    ROUND((sales / SUM(sales) OVER()) * 100, 2) AS percent
FROM 
    orders;

-- ===========================================
-- 7. Averages and Comparisons
-- ===========================================

-- Average sales overall and by productId
SELECT 
    orderId,
    orderDate,
    sales,
    productId,
    ROUND(AVG(COALESCE(sales, 0)) OVER(), 1) AS totalAvg,
    ROUND(AVG(COALESCE(sales, 0)) OVER(PARTITION BY productID), 1) AS totalAvgByProduct
FROM 
    orders;

-- Average score from customer table (overall and with NULLs treated as 0)
SELECT 
    customerId,
    LastName,
    score,
    ROUND(AVG(score) OVER(), 1) AS avgScore,
    ROUND(AVG(COALESCE(score, 0)) OVER(), 1) AS avgScoreWithNulls
FROM 
    customer;

-- Orders where sales are greater than the average
SELECT 
    * 
FROM (
    SELECT 
        orderId,
        sales, 
        AVG(sales) OVER() AS avgSales 
    FROM 
        orders
) AS t  
WHERE 
    sales > avgSales;

-- ===========================================
-- 8. Min/Max and Deviations
-- ===========================================

-- Get max and min sales overall and by productId
SELECT 
    orderID,
    orderDate,
    productID, 
    sales,
    MAX(sales) OVER() AS MaxSales,
    MIN(sales) OVER() AS MinSales,
    MAX(sales) OVER(PARTITION BY productID) AS MaxSalesByProduct,
    MIN(sales) OVER(PARTITION BY productID) AS MinSalesByProduct
FROM 
    orders;

-- Find employees with the highest salary
SELECT 
    * 
FROM (
    SELECT 
        *, 
        MAX(salary) OVER() AS maxSalary 
    FROM 
        employee
) AS t 
WHERE 
    salary = maxSalary;

-- Calculate deviation from max and min sales
SELECT 
    orderID,
    orderDate,
    productID, 
    sales,
    MAX(sales) OVER() AS MaxSales,
    MIN(sales) OVER() AS MinSales,
    (MAX(sales) OVER() - sales) AS deviationFromHigh,
    (sales - MIN(sales) OVER()) AS deviationFromLow
FROM 
    orders;

-- ===========================================
-- 9. Moving and Rolling Averages
-- ===========================================

-- Average, moving average, and rolling average of sales by product
SELECT 
    orderID, 
    orderDate, 
    productID, 
    sales,
    ROUND(AVG(sales) OVER(PARTITION BY productID), 1) AS Average,
    ROUND(AVG(sales) OVER(PARTITION BY productID ORDER BY orderDate), 1) AS MovingAvg,
    ROUND(AVG(sales) OVER(
        PARTITION BY productID 
        ORDER BY orderDate 
        ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING
    ), 1) AS RollingAvg
FROM 
    orders;
