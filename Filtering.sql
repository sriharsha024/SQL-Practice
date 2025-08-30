-- Use the database named 'mydatabase'
USE mydatabase;

-- Select all customers who are from Germany
SELECT 
    *
FROM
    customers
WHERE
    country = 'Germany';

-- Select all customers who are NOT from the USA
SELECT 
    *
FROM
    customers
WHERE
    country != 'USA';

-- Select all customers with a score greater than 800
SELECT 
    *
FROM
    customers
WHERE
    score > 800;

-- Select all customers with a score greater than or equal to 500
SELECT 
    *
FROM
    customers
WHERE
    score >= 500;

-- Select all customers with a score less than 400
SELECT 
    *
FROM
    customers
WHERE
    score < 400;

-- Select all customers with a score less than or equal to 500
SELECT 
    *
FROM
    customers
WHERE
    score <= 500;

-- Select all customers who are from the USA AND have a score greater than 500
SELECT 
    *
FROM
    customers
WHERE
    country = 'USA' AND score > 500;

-- Select all customers who are from the USA OR have a score greater than 500
SELECT 
    *
FROM
    customers
WHERE
    country = 'USA' OR score > 500;

-- Select all customers who are NOT from the USA
SELECT 
    *
FROM
    customers
WHERE
    NOT country = 'USA';

-- Select all customers with scores BETWEEN 350 and 750 (inclusive)
SELECT 
    *
FROM
    customers
WHERE
    score BETWEEN 350 AND 750;

-- Same as above using explicit >= and <=
SELECT 
    *
FROM
    customers
WHERE
    score >= 350 AND score <= 750;

-- Select all customers whose country is either Canada, Tokyo, China, or Germany
SELECT 
    *
FROM
    customers
WHERE
    country IN ('Canada' , 'Tokyo', 'China', 'Germany');

-- Select all customers whose country is NOT Canada, Tokyo, China, or Germany
SELECT 
    *
FROM
    customers
WHERE
    country NOT IN ('Canada' , 'Tokyo', 'China', 'Germany');

-- Select all customers whose first name starts with 'M'
SELECT 
    *
FROM
    customers
WHERE
    first_name LIKE 'M%';

-- Select all customers whose first name contains the letter 'i'
SELECT 
    *
FROM
    customers
WHERE
    first_name LIKE '%i%';

-- Select all customers whose first name ends with 'i' followed by any one character
SELECT 
    *
FROM
    customers
WHERE
    first_name LIKE '%i_';

-- Select all customers whose first name has 'i' as the second letter
SELECT 
    *
FROM
    customers
WHERE
    first_name LIKE '_i%';

-- Select all customers whose first name does NOT contain the letter 'a'
SELECT 
    *
FROM
    customers
WHERE
    first_name NOT LIKE '%a%';
