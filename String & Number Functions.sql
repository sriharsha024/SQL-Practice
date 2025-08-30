-- Switch to the desired database
USE mydatabase;

-- ========================================
-- String Function Demonstrations on 'customers' table
-- ========================================
SELECT 
    -- Concatenate first_name and country with a space in between
    CONCAT(first_name, ' ', country) AS full_name,

    -- Convert first_name to uppercase
    UPPER(first_name) AS FIRST_NAME,

    -- Convert first_name to lowercase
    LOWER(first_name) AS lower_name,

    -- Trim leading and trailing spaces from first_name
    TRIM(first_name) AS trimmed_name,

    -- Get length of first_name before trimming
    LENGTH(first_name) AS length_before_trim,

    -- Get length of first_name after trimming
    LENGTH(TRIM(first_name)) AS length_after_trim,

    -- Calculate number of leading/trailing spaces trimmed
    LENGTH(first_name) - LENGTH(TRIM(first_name)) AS spaces_trimmed,

    -- Get the first 3 characters of first_name
    LEFT(first_name, 3) AS left_name,

    -- Get the last 3 characters of first_name
    RIGHT(first_name, 3) AS right_name,

    -- Return the full country name
    country,

    -- Extract 5 characters from country starting at position 2
    SUBSTRING(country, 2, 5) AS country_substring
FROM
    customers;


-- ========================================
-- Find rows where first_name has leading or trailing spaces
-- ========================================
SELECT 
    first_name
FROM
    customers
WHERE
    first_name != TRIM(first_name); -- Detects names with extra whitespace


-- ========================================
-- Replace dashes with spaces in a phone number
-- ========================================
SELECT 
    '123-456-7890' AS original_number,
    REPLACE('123-456-7890', '-', ' ') AS cleaned_number;


-- ========================================
-- Replace file extension and get string length
-- ========================================
SELECT 
    'report.txt' AS original_filename,
    REPLACE('report.txt', '.txt', '.ppt') AS new_filename,
    LENGTH('report.txt') AS filename_length;


-- ========================================
-- Round a number to different decimal places
-- ========================================
SELECT 
    3.2516 AS original_value,
    ROUND(3.2516, 3) AS round_3_decimals,
    ROUND(3.2516, 2) AS round_2_decimals,
    ROUND(3.2516, 1) AS round_1_decimal;


-- ========================================
-- Absolute value of a negative number
-- ========================================
SELECT 
    -50 AS original_number,
    ABS(-50) AS absolute_value;
