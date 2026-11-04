# 🧹 Advanced Data Cleansing: Fixing Corrupt Data

## 📌 Project Overview

This project focuses on identifying, analyzing, and cleaning corrupted or invalid data using **MySQL and Python (Pandas)**.

The objective is to improve data quality by detecting missing values, invalid entries, inconsistent records, and duplicate data, then applying appropriate cleaning techniques.

## 🎯 Objectives

- Identify missing and NULL values.
- Detect invalid data using range checks.
- Find and remove duplicate records.
- Replace or remove incorrect data entries.
- Standardize inconsistent data.
- Validate data after cleansing.
- Improve overall data accuracy and consistency.

## 🛠️ Technologies Used

- 🗄️ **MySQL** – Data analysis and database cleansing.
- 🐍 **Python** – Data cleaning using Pandas and NumPy.
- 📓 **Jupyter Notebook** – Python execution and analysis.
- 📊 **SQL Queries** – Data validation and transformation.



## 🔍 Tasks Performed

### 1. Data Analysis
- Analyzed datasets for inconsistencies.
- Checked dataset structure and statistical information.
- Identified corrupted and suspicious records.

### 2. Identifying Missing Values
- Used `IS NULL` in MySQL.
- Used `isnull()` in Python.
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
- Used `fillna()` in Python to handle missing values.
- Used `drop_duplicates()` to remove duplicate records.
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
| `DISTINCT` | Remove duplicate records |
| `CHECK` | Enforce data validation |

### Example: Identify Missing Values

```sql
SELECT *
FROM Employees
WHERE Name IS NULL
   OR Age IS NULL
   OR Salary IS NULL;
```

### Example: Identify Invalid Ages

```sql
SELECT *
FROM Employees
WHERE Age < 18 OR Age > 60;
```

### Example: Identify Duplicate Records Using Window Function

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

### Example: Remove Duplicate Records

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

## 🐍 Python Concepts Used

| Python Function | Purpose |
|---|---|
| `head()` | Display initial records |
| `info()` | Check dataset information |
| `describe()` | Generate statistical summary |
| `isnull()` | Identify missing values |
| `fillna()` | Replace missing values |
| `between()` | Perform range checks |
| `loc[]` | Update selected records |
| `drop_duplicates()` | Remove duplicate records |
| `str.upper()` | Standardize text |
| `to_csv()` | Export cleaned dataset |

### Example: Handle Missing Values

```python
df['Name'] = df['Name'].fillna('Unknown')

df['Age'] = df['Age'].fillna(df['Age'].mean())

df['Salary'] = df['Salary'].fillna(df['Salary'].mean())
```

### Example: Remove Duplicate Records

```python
df = df.drop_duplicates()
```

### Example: Validate Cleaned Data

```python
print(df.isnull().sum())

print(df[df['Age'] < 18])

print(df[df['Salary'] <= 0])

print(df.duplicated().sum())
```

## 📊 Expected Outcomes

After completing this project:

- Missing values are identified and handled.
- Invalid age and salary values are corrected.
- Duplicate records are detected and removed.
- Inconsistent department names are standardized.
- Data quality and consistency are improved.
- Cleaned data is validated and exported.

## 📚 Key Learnings

- Practical data-cleaning techniques using MySQL.
- Handling missing and corrupted data using Python.
- Applying SQL Window Functions.
- Identifying duplicate records using `ROW_NUMBER()`.
- Using CTEs for structured SQL queries.
- Data validation and quality improvement.

## 👨‍💻 Author

**Atharva**

Software Developer | SQL | Python | Data Analytics

---

⭐ If you find this project useful, feel free to explore the repository and learn from the implementation.

#DataCleaning #MySQL #Python #Pandas #DataAnalytics #SQL #JupyterNotebook #DataQuality
