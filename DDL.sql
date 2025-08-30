-- Switch to the database named 'mydatabase'
USE mydatabase;

-- Create a table named 'person' with columns: id, name, birth_date, and phone
-- Set 'id' as the PRIMARY KEY and make 'id', 'name', and 'phone' NOT NULL
CREATE TABLE person (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (id)
);

-- Add a new column 'email' to the 'person' table, and make it NOT NULL
ALTER TABLE person ADD email VARCHAR(50) NOT NULL;

-- Add a new column 'address' to the 'person' table, and make it NOT NULL
ALTER TABLE person ADD address VARCHAR(50) NOT NULL;

-- Remove the 'address' column from the 'person' table
ALTER TABLE person DROP COLUMN address;

-- Retrieve all records from the 'person' table
SELECT 
    *
FROM
    person;

-- Delete the 'person' table entirely
DROP TABLE person;
