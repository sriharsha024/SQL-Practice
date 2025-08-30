-- Use the salesDB database
USE salesDB;

-- 1️⃣ Calculate percentage change in sales compared to the previous order
SELECT 
    orderID, 
    orderDate,
    sales,
    ((sales - LAG(sales) OVER (ORDER BY orderDate)) / sales) * 100 AS sales_change_percentage
FROM orders;

-- 2️⃣ Month-over-month sales growth percentage
SELECT 
    *, 
    ROUND(((total - prevMonthSales) / prevMonthSales) * 100, 2) AS growth_percent
FROM (
    SELECT 
        MONTH(orderDate) AS month,
        SUM(sales) AS total,
        LAG(SUM(sales)) OVER (ORDER BY MONTH(orderDate)) AS prevMonthSales
    FROM orders
    GROUP BY MONTH(orderDate)
) AS t;

-- 3️⃣ Average days between orders per customer with row ranking (NULLs treated as high)
SELECT 
    CustomerID, 
    AVG(diff) AS avg_days_between_orders,
    ROW_NUMBER() OVER (ORDER BY COALESCE(AVG(diff), 99999)) AS rank
FROM (
    SELECT 
        orderId,
        customerID,
        orderDate AS currentOrder,
        LEAD(orderDate) OVER (PARTITION BY customerID ORDER BY orderDate) AS nextOrder,
        DATEDIFF(
            LEAD(orderDate) OVER (PARTITION BY customerID ORDER BY orderDate),
            orderDate
        ) AS diff
    FROM orders
) AS t
GROUP BY CustomerID;

-- 4️⃣ Product-wise sales insights (lowest/highest using window functions)
SELECT 
    orderId, 
    productID, 
    sales,

    -- First (lowest) sale for this product
    FIRST_VALUE(sales) OVER (PARTITION BY productId ORDER BY sales) AS lowestSales_first,

    -- Last value in descending order = lowest due to window frame
    LAST_VALUE(sales) OVER (
        PARTITION BY productId 
        ORDER BY sales DESC 
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) AS lowestSales_last,

    -- Minimum sale value for this product
    MIN(sales) OVER (PARTITION BY productID) AS lowestSales_min,

    -- First value in descending order = highest sale
    FIRST_VALUE(sales) OVER (PARTITION BY productId ORDER BY sales DESC) AS highestSales_first,

    -- Last value in ascending order = highest due to window frame
    LAST_VALUE(sales) OVER (
        PARTITION BY productId 
        ORDER BY sales 
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) AS highestSales_last,

    -- Maximum sale value for this product
    MAX(sales) OVER (PARTITION BY productID) AS highestSales_max

FROM orders;
