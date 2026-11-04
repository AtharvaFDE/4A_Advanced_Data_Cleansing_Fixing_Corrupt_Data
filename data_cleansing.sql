CREATE DATABASE IF NOT EXISTS Data_Cleansing_DB;

USE Data_Cleansing_DB;

CREATE TABLE IF NOT EXISTS Employees (
	Employee_ID INT,
    Name Varchar(50),
    Age INT,
    Salary DECIMAL(10,2),
    Department VARCHAR(50)
);

INSERT INTO Employees
(Employee_ID, Name, Age, Salary, Department)
VALUES
(101, 'Rahul', 25, 25000, 'IT'),
(102, 'Priya', 30, 35000, 'HR'),
(103, 'Amit', -5, 40000, 'Finance'),
(104, 'Sneha', 28, -1000, 'IT'),
(105, NULL, 150, 50000, NULL),
(106, 'Rohit', NULL, 30000, 'HR'),
(107, 'Neha', 26, NULL, 'it'),
(107, 'Neha', 26, NULL, 'it');


SELECT * FROM Employees;

-- Check Total Records 

SELECT COUNT(*) AS Total_Employees
FROM Employees;

-- Check statistical information

SELECT
	MIN(Age) AS Minimum_Age,
    Max(Age) AS Maximum_Age,
    AVG(Age) AS Average_Age,
    MIN(Salary) AS Minimum_Salary,
    MAX(Salary) AS Minimum_Salary,
    AVG(Salary) AS Average_Salary
FROM
	Employees;
    
-- Identify Missing Values Using IS NULL

-- Find the Missing Employee names

SELECT *
FROM
	Employees
WHERE Name IS NULL;

-- Find missing ages

SELECT *
FROM
	Employees
WHERE 
	Age IS NULL;
    
-- Find missing salaries

SELECT *
FROM Employees
WHERE Salary IS NULL;

-- Find all records containing missing values 

SELECT *
FROM
	Employees
WHERE 
	Name is NULL
  OR Age is NULL
  OR Salary is NULL
  OR Department is NULL;
  

-- Count missing values in each column

SELECT
	SUM(NAME IS NULL) AS Missing_Names,
    SUM(Age IS NULL) AS Missing_Ages,
    SUM(Salary IS NULL) AS Missing_Salaries,
    SUM(Department IS NULL) AS Missing_Departments
FROM
	Employees;
    
-- Identify Invalid Values Using Range Checks

-- Assume valid employee age is between 18 and 60.

SELECT *
FROM
	Employees
WHERE
	Age < 18 OR Age > 60;
    
-- Find invalid or negative salaries

SELECT * 
FROM
	Employees
WHERE Salary <=0;

-- Find invalid department names

SELECT DISTINCT Department
FROM Employees;

-- Find duplicate Employee IDs

SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY Employee_ID
        ORDER BY Employee_ID
    ) as rank_data
FROM
	Employees;
    

SELECT 
	Employee_ID,
    COUNT(*) as Duplicate_Count
FROM
	Employees 
Group By Employee_ID
Having COUNT(*) > 1;
	
-- Fix Missing Values Using UPDATE

SET SQL_SAFE_UPDATES = 0;

UPDATE Employees
SET Name="Unknown"
WHERE Name IS NULL;

SET SQL_SAFE_UPDATES = 1;

-- Replace missing departments with Unknown.

SET SQL_SAFE_UPDATES = 0;

UPDATE Employees
SET Department = 'Unknown'
WHERE Department IS NULL;

SET SQL_SAFE_UPDATES = 1;

-- Replace missing ages with the average of valid ages.

SET SQL_SAFE_UPDATES = 0;

UPDATE Employees
SET Age = (
    SELECT avg_age
    FROM (
        SELECT AVG(Age) AS avg_age
        FROM Employees
        WHERE Age BETWEEN 18 AND 60
    ) AS temp
)
WHERE Age IS NULL;

SET SQL_SAFE_UPDATES = 1;


-- Replace missing salaries with the average of valid salaries.

SET SQL_SAFE_UPDATES = 0;
	
UPDATE Employees
SET Salary = (
    SELECT avg_salary
    FROM (
        SELECT AVG(Salary) AS avg_salary
        FROM Employees
        WHERE Salary > 0
    ) AS temp
)
WHERE Salary IS NULL;
    
SET SQL_SAFE_UPDATES = 1;


-- Fix Invalid Values
-- Replace invalid ages with the average of valid ages.

SET SQL_SAFE_UPDATES = 0;

UPDATE Employees
SET Age = (
    SELECT avg_age
    FROM (
        SELECT AVG(Age) AS avg_age
        FROM Employees
        WHERE Age BETWEEN 18 AND 60
    ) AS temp
)
WHERE Age < 18 OR Age > 60;

SET SQL_SAFE_UPDATES = 1;


-- Replace negative salaries with the average valid salary

SET SQL_SAFE_UPDATES = 0;

UPDATE Employees
SET Salary = (
    SELECT avg_salary
    FROM (
        SELECT AVG(Salary) AS avg_salary
        FROM Employees
        WHERE Salary > 0
    ) AS temp
)
WHERE Salary <= 0;

SET SQL_SAFE_UPDATES = 1;


-- Standardize Department Names

SET SQL_SAFE_UPDATES = 0;

UPDATE Employees
SET Department = UPPER(Department)
WHERE Department IS NOT NULL;

SET SQL_SAFE_UPDATES = 1;

-- Now check department names:

SELECT DISTINCT Department
FROM Employees;

-- Remove Duplicate Records

SELECT
	Employee_ID,
    Name,
    Age,
    Salary,
    Department,
    COUNT(*) AS Duplicate_Count
FROM
	Employees
GROUP BY
	Employee_ID,
    Name,
    Age,
    Salary,
    Department
HAVING COUNT(*) > 1;

-- For safe duplicate removal, create a temporary table with a unique row identifier

CREATE TABLE Employees_Cleaned AS
	SELECT DISTINCT *
    FROM Employees;

DROP TABLE Employees;

RENAME TABLE Employees_Cleaned TO Employees;

SELECT * FROM Employees;

-- Validate the Cleansed Data
-- Now check whether the dataset is clean.

-- 1. Check the Missing Values

SELECT * 
FROM Employees
WHERE Name IS NULL
OR Age IS NULL
OR Salary IS NULL
OR Department IS NULL;

-- 2. Check invalid ages

SELECT * 
FROM
	Employees
WHERE Age < 18 OR Age > 60;

-- 3. Check invalid salaries

SELECT *
FROM Employees
WHERE Salary <= 0;

-- 4. Check duplicate records

SELECT
	Employee_ID,
    COUNT(*) as Total
FROM Employees
GROUP BY Employee_ID
HAVING COUNT(*) > 1; 

-- 5 Display final cleaned dataset

SELECT * FROM Employees;




