-- Use the salesDB database
USE salesDB;

-- 1. Generate various rankings based on sales
SELECT 
    orderId,
    orderDate,
    productId,
    sales,
    ROW_NUMBER() OVER (ORDER BY sales DESC) AS salesRowRank, -- Unique row number per row, even if sales values are the same
    RANK()        OVER (ORDER BY sales DESC) AS salesRank,    -- Ranks with gaps if there are ties
    DENSE_RANK()  OVER (ORDER BY sales DESC) AS salesDenseRank -- Ranks without gaps for ties
FROM orders;


-- 2. Get the top-selling order (highest sales) per product
SELECT * 
FROM (
    SELECT 
        orderId,
        orderDate,
        productId,
        sales,
        ROW_NUMBER() OVER (PARTITION BY productID ORDER BY sales DESC) AS Salesrank
    FROM orders
) AS t
WHERE Salesrank = 1;


-- 3. Get the bottom 2 customers in terms of total sales
SELECT * 
FROM (
    SELECT 
        CustomerID,
        SUM(sales) AS totalSales,
        ROW_NUMBER() OVER (ORDER BY SUM(sales) ASC) AS Salesrank
    FROM orders
    GROUP BY CustomerID
) AS t
WHERE Salesrank < 3;


-- 4. Generate new sequential OrderID across the ordersarchive table
SELECT
    ROW_NUMBER() OVER (ORDER BY OrderId, OrderDate) AS OrderIDNew,
    OrderId,
    OrderDate,
    CustomerId
FROM ordersarchive;


-- 5. Get the latest record per OrderID from ordersarchive (based on CreationTime)
SELECT * 
FROM (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY CreationTime DESC) AS rn
    FROM ordersarchive
) AS t
WHERE rn = 1;


-- 6. Divide orders into 2, 3, and 4 quantile buckets based on sales
SELECT 
    orderID,
    sales,
    NTILE(2) OVER (ORDER BY sales DESC) AS two_buckets,   -- Splits into 2 quantiles
    NTILE(3) OVER (ORDER BY sales DESC) AS three_buckets, -- Splits into 3 quantiles
    NTILE(4) OVER (ORDER BY sales DESC) AS four_buckets   -- Splits into 4 quantiles
FROM orders;


-- 7. Label sales into "High", "Medium", and "Low" categories using NTILE(3)
SELECT *,
    CASE 
        WHEN buckets = 1 THEN "High"
        WHEN buckets = 2 THEN "Medium"
        ELSE "Low"
    END AS SalesCategory
FROM (
    SELECT 
        orderID,
        sales,
        NTILE(3) OVER (ORDER BY sales DESC) AS buckets
    FROM orders
) AS t;


-- 8. Get top 40% most expensive products using CUME_DIST()
SELECT * 
FROM (
    SELECT 
        product,
        price,
        CUME_DIST() OVER (ORDER BY price DESC) AS distRank
    FROM product
) AS t
WHERE distRank <= 0.4;
