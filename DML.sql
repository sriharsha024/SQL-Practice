-- Switch to the database 'mydatabase'
USE mydatabase;

-- Insert a customer with id=24, first_name='Wao', and score=400
INSERT INTO customers(id, first_name, score) 
VALUES 
    (24, "Wao", 400);

-- Insert a customer with id=25, first_name='Aki', country='India', and score=400
INSERT INTO customers(id, first_name, country, score) 
VALUES 
    (25, "Aki", "India", 400);

-- Insert multiple customers with some NULL scores
INSERT INTO customers(id, first_name, country, score) 
VALUES 
    (36, "Balu", "Tokyo", NULL),
    (38, "Karim", "India", NULL);

-- Insert a customer with id=30, first_name='Mani', country='India', and score=950
INSERT INTO customers
VALUES 
    (30, "Mani", "India", 950);

-- Retrieve and display all rows from customers table
SELECT 
    *
FROM
    customers;

-- Create the 'person' table with columns: id, name, birth_date, phone
-- 'id' is primary key, 'name' and 'phone' are NOT NULL, 'birth_date' can be NULL
CREATE TABLE person (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (id)
);

-- Insert into 'person' table from 'customers' table
-- Map 'id' to 'id', 'first_name' to 'name', set birth_date to NULL, phone to "Unknown"
INSERT INTO person(id, name, birth_date, phone)
SELECT 
    id,
    first_name,
    NULL,
    "Unknown"
FROM customers;

-- Show all rows from person table
SELECT 
    *
FROM
    person;

-- Update score to 800 for customer with id=28 (if exists)
UPDATE customers 
SET 
    score = 800
WHERE
    id = 28;

-- Update country to 'USA' and score to 200 for customer with id=12 (if exists)
UPDATE customers 
SET 
    country = 'USA',
    score = 200
WHERE
    id = 12;

-- Disable safe update mode to allow updating rows without key column in WHERE clause
SET SQL_SAFE_UPDATES = 0;

-- Update customers to set score=100 where score is NULL and id is not NULL
UPDATE customers 
SET 
    score = 100
WHERE
    score IS NULL AND id IS NOT NULL;

-- Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;

-- Delete customers with ids between 25 and 30 inclusive
DELETE FROM customers 
WHERE
    id BETWEEN 25 AND 30;

-- Display remaining customers after deletion
SELECT 
    *
FROM
    customers;

-- Delete all rows from person table (keeps the table structure)
DELETE FROM person;

-- Remove all rows from person table quickly (also keeps table structure)
TRUNCATE TABLE person;

-- Display all rows from person table (should be empty)
SELECT 
    *
FROM
    person;
