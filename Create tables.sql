-- Delete the database if it already exists (prevents errors on re-run)
DROP DATABASE IF EXISTS MyDatabase;

-- Create a new database named 'MyDatabase'
CREATE DATABASE MyDatabase;

-- Select the newly created database for use
USE MyDatabase;

-- Delete the 'customers' table if it already exists
DROP TABLE IF EXISTS customers;

-- Create the 'customers' table with four columns: id, first_name, country, score
CREATE TABLE customers (
    id INT NOT NULL,
    first_name VARCHAR(50),
    country VARCHAR(50),
    score INT,
    PRIMARY KEY (id)
);

-- Insert initial set of customer records into the 'customers' table
INSERT INTO customers (id, first_name, country, score) VALUES
    (1, 'Maria', 'Germany', 350),
    (2, ' John', 'USA', 900),
    (3, 'Georg', 'UK', 750),
    (4, 'Martin', 'Germany', 500),
    (5, 'Peter', 'USA', 0);

-- Insert additional customer records
INSERT INTO customers (id, first_name, country, score) VALUES
    (6, 'Anna', 'France', 620),
    (7, 'Luis', 'Spain', 430),
    (8, 'Emma', 'Germany', 810),
    (9, 'Liam', 'USA', 670),
    (10, 'Sophia', 'Canada', 720),
    (11, 'Noah', 'USA', 300),
    (12, 'Chloe', 'UK', 560),
    (13, 'Mia', 'France', 890),
    (14, 'Lucas', 'Spain', 220),
    (15, 'Ella', 'Germany', 940);

-- Delete the 'orders' table if it already exists
DROP TABLE IF EXISTS orders;

-- Create the 'orders' table with four columns: order_id, customer_id, order_date, sales
CREATE TABLE orders (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE,
    sales INT,
    PRIMARY KEY (order_id)
);

-- Insert initial order records into the 'orders' table
INSERT INTO orders (order_id, customer_id, order_date, sales) VALUES
    (1001, 1, '2021-01-11', 35),
    (1002, 2, '2021-04-05', 15),
    (1003, 3, '2021-06-18', 20),
    (1004, 6, '2021-08-31', 10);

-- Insert additional order records into the 'orders' table
INSERT INTO orders (order_id, customer_id, order_date, sales) VALUES
    (1005, 4, '2021-09-10', 50),
    (1006, 5, '2021-10-21', 0),
    (1007, 7, '2021-11-03', 25),
    (1008, 8, '2021-11-15', 75),
    (1009, 9, '2021-12-01', 30),
    (1010, 10, '2022-01-12', 40),
    (1011, 11, '2022-02-25', 20),
    (1012, 12, '2022-03-05', 35),
    (1013, 13, '2022-03-17', 80),
    (1014, 14, '2022-04-09', 10),
    (1015, 15, '2022-05-22', 95);
