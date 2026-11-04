# 🧹 Advanced Data Cleansing: Fixing Corrupt Data

## 📌 Project Overview

This project focuses on identifying, analyzing, and cleaning corrupted or invalid data using **MySQL**.

The objective is to improve data quality by detecting missing values, invalid entries, inconsistent records, and duplicate data, then applying appropriate SQL techniques to clean and validate the dataset.

## 🎯 Objectives

- Identify missing and NULL values.
- Detect invalid data using range checks.
- Find and remove duplicate records.
- Replace or remove incorrect data entries.
- Standardize inconsistent data.
- Validate data after cleansing.
- Improve overall data accuracy and consistency.

## 🛠️ Technologies Used

- 🗄️ **MySQL Server** – Database management and data cleansing.
- 💻 **MySQL Workbench** – SQL query execution and database analysis.

## 📋 Prerequisites

- MySQL Server 8.0+
- MySQL Workbench 8.0+

## 🔍 Tasks Performed

### 1. Data Analysis
- Analyzed datasets for inconsistencies.
- Checked database records and data quality.
- Identified corrupted and suspicious records.

### 2. Identifying Missing Values
- Used `IS NULL` to identify missing values.
- Identified missing names, ages, salaries, and departments.

### 3. Detecting Invalid Values
- Performed age range checks.
- Identified negative and invalid salaries.
- Checked inconsistent department names.
- Identified duplicate Employee IDs.

### 4. Data Cleaning
- Used `UPDATE` to replace missing and invalid values.
- Used `DELETE` to remove unwanted records.
- Used `ROW_NUMBER()` window function to identify duplicate records.
- Used `DISTINCT` to eliminate identical duplicate records.
- Standardized department names using `UPPER()`.

### 5. Data Validation
- Rechecked missing values.
- Verified age and salary ranges.
- Checked duplicate records.
- Compared the dataset before and after cleaning.

## 💻 MySQL Concepts Used

| SQL Concept | Purpose |
|---|---|
| `IS NULL` | Identify missing values |
| `WHERE` | Filter invalid records |
| `BETWEEN` | Perform range checks |
| `UPDATE` | Fix invalid data |
| `DELETE` | Remove unwanted records |
| `GROUP BY` | Group duplicate records |
| `HAVING` | Filter duplicate groups |
| `ROW_NUMBER()` | Identify duplicate rows |
| `CTE` | Organize cleaning queries |
| `DISTINCT` | Remove identical duplicate records |
| `UPPER()` | Standardize text values |
| `CHECK` | Enforce data validation |
| `UNIQUE` | Prevent duplicate values |

## 📝 SQL Query Examples

### 1. Identify Missing Values

```sql
SELECT *
FROM Employees
WHERE Name IS NULL
   OR Age IS NULL
   OR Salary IS NULL
   OR Department IS NULL;
```

### 2. Identify Invalid Ages

```sql
SELECT *
FROM Employees
WHERE Age < 18 OR Age > 60;
```

### 3. Identify Invalid Salaries

```sql
SELECT *
FROM Employees
WHERE Salary <= 0;
```

### 4. Identify Duplicate Records Using Window Function

```sql
WITH Duplicate_CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Employee_ID
               ORDER BY Row_ID
           ) AS row_num
    FROM Employees
)
SELECT *
FROM Duplicate_CTE
WHERE row_num > 1;
```

### 5. Remove Duplicate Records

```sql
WITH Duplicate_CTE AS (
    SELECT Row_ID,
           ROW_NUMBER() OVER (
               PARTITION BY Employee_ID
               ORDER BY Row_ID
           ) AS row_num
    FROM Employees
)
DELETE FROM Employees
WHERE Row_ID IN (
    SELECT Row_ID
    FROM Duplicate_CTE
    WHERE row_num > 1
);
```

### 6. Standardize Department Names

```sql
UPDATE Employees
SET Department = UPPER(Department)
WHERE Department IS NOT NULL;
```

## 📊 Expected Outcomes

After completing this project:

- Missing values are identified and handled.
- Invalid age and salary values are corrected.
- Duplicate records are detected and removed.
- Inconsistent department names are standardized.
- Data quality and consistency are improved.
- Cleaned data is validated successfully.

## 📚 Key Learnings

- Practical data-cleaning techniques using MySQL.
- Handling missing and corrupted data.
- Applying SQL Window Functions.
- Identifying duplicate records using `ROW_NUMBER()`.
- Using CTEs for structured SQL queries.
- Data validation and database integrity.

## 👨‍💻 Author

**Atharva**

Software Developer | MySQL | SQL | Data Analytics

---

⭐ If you find this project useful, feel free to explore the repository and learn from the implementation.

#MySQL #SQL #DataCleaning #DataCleansing #DataAnalytics #WindowFunctions #DataQuality #MySQLWorkbench
