USE salesDB;

-- UNION combines unique firstName, lastName pairs from customer and employee tables
SELECT 
    firstName, lastName
FROM
    customer 
UNION SELECT 
    firstName, lastName
FROM
    employee;

-- UNION combines unique IDs and last names from customer and employee tables
SELECT 
    customerID AS ID, lastName
FROM
    customer 
UNION SELECT 
    employeeID, lastName
FROM
    employee;

-- UNION ALL returns all firstName, lastName pairs from both tables including duplicates
SELECT 
    firstName, lastName
FROM
    customer 
UNION ALL SELECT 
    firstName, lastName
FROM
    employee;

-- UNION ALL returns all IDs and last names from both tables including duplicates
SELECT 
    customerID AS ID, lastName
FROM
    customer 
UNION ALL SELECT 
    employeeID, lastName
FROM
    employee;

-- Equivalent to EXCEPT: Select customers whose (firstName, lastName) do NOT appear in employees
SELECT 
    c.firstName, c.lastName
FROM
    customer AS c
        LEFT JOIN
    employee AS e ON c.firstName = e.firstName
        AND (c.lastName = e.lastName
        OR (c.lastName IS NULL
        AND e.lastName IS NULL))
WHERE
    e.firstName IS NULL;

-- Equivalent to INTERSECT: Select (firstName, lastName) pairs appearing in BOTH customer and employee
SELECT 
    c.firstName, c.lastName
FROM
    customer c
        INNER JOIN
    employee e ON c.firstName = e.firstName
        AND (c.lastName = e.lastName
        OR (c.lastName IS NULL
        AND e.lastName IS NULL));

-- Another INTERSECT example: Select matching IDs and first names between customer and employee tables
SELECT 
    c.customerID AS ID, c.firstName
FROM
    customer c
        INNER JOIN
    employee e ON c.customerID = e.employeeID
        AND (c.firstName = e.firstName
        OR (c.firstName IS NULL
        AND e.firstName IS NULL));

-- UNION of two order tables with an extra column indicating source table,
-- combining all order records from 'orders' and 'ordersarchive', ordered by orderID
SELECT 
    'Orders' AS sourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
FROM
    orders 
UNION SELECT 
    'Ordersarchive' AS sourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
FROM
    ordersarchive
ORDER BY OrderID;
