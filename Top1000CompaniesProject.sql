-- Step 1: Create a new database

CREATE DATABASE TechCompanies;

-- Step 2: Use the database

USE TechCompanies;

-- Step 3: Create a table to hold the data

CREATE TABLE TopTechCompanies (
    Ranking INT,
    Company NVARCHAR(255),
    MarketCap NVARCHAR(50), -- Initial format as text; we'll clean later if needed
    Stock NVARCHAR(50),
    Country NVARCHAR(255),
    Industry NVARCHAR(255)
);

-- Step 4: Import the CSV file using SQL Server's BULK INSERT
-- Make sure the file path matches your environment

BULK INSERT TopTechCompanies
FROM "D:\TopCompanies\Top 1000 technology companies.csv"
WITH (
    FIRSTROW = 2, -- Skip the header row
    FIELDTERMINATOR = ',', -- CSV column delimiter
    ROWTERMINATOR = '\n'  -- Row delimiter
);

-- Viewing data

SELECT *
FROM TopTechCompanies

-- Find rows with NULL or empty values in any column

SELECT *
FROM TopTechCompanies
WHERE Ranking IS NULL
   OR Company IS NULL OR Company = ''
   OR MarketCap IS NULL OR MarketCap = ''
   OR Stock IS NULL OR Stock = ''
   OR Country IS NULL OR Country = ''
   OR Industry IS NULL OR Industry = '';

 -- Checking duplicates

SELECT 
    Ranking, 
    Company, 
    MarketCap, 
    Stock, 
    Country, 
    Industry, 
    COUNT(*) AS CountOfDuplicates
FROM 
    TopTechCompanies
GROUP BY 
    Ranking, 
    Company, 
    MarketCap, 
    Stock, 
    Country, 
    Industry
HAVING 
    COUNT(*) > 1
ORDER BY 
    CountOfDuplicates DESC;

-- Cleaning 

SELECT *
FROM TopTechCompanies
WHERE 
    MarketCap NOT LIKE '%$%';

UPDATE TopTechCompanies
SET Company = Company + ' ' + MarketCap
WHERE 
    MarketCap NOT LIKE '%$%';

UPDATE TopTechCompanies
SET MarketCap = Stock
WHERE 
    MarketCap NOT LIKE '%$%';

UPDATE TopTechCompanies
SET MarketCap = Country
WHERE 
    MarketCap NOT LIKE '%$%';

SELECT *
FROM TopTechCompanies
WHERE 
    Stock LIKE '%$%';

UPDATE TopTechCompanies
SET Stock = Country
WHERE 
    Stock LIKE '%$%';

SELECT *
FROM TopTechCompanies
WHERE 
    Company LIKE '%"%';

ALTER TABLE TopTechCompanies
ADD Country_1 NVARCHAR(255),
    Industry_1 NVARCHAR(255);

UPDATE TopTechCompanies
SET Country_1 = 
    CASE 
        WHEN CHARINDEX(',', Industry) > 0 THEN 
            SUBSTRING(Industry, 1, CHARINDEX(',', Industry) - 1)
        ELSE 
            Country
    END;

UPDATE TopTechCompanies
SET Industry_1 = 
    CASE 
        WHEN CHARINDEX(',', Industry) > 0 THEN 
            LTRIM(SUBSTRING(Industry, CHARINDEX(',', Industry) + 1, LEN(Industry)))
        ELSE 
            Industry -- If there is no comma, keep the original value
    END;

--Renaming columns

EXEC sp_rename 'TopTechCompanies.Country_1', 'CountryOfOrigin', 'COLUMN';
EXEC sp_rename 'TopTechCompanies.NameOfTheCompany', 'CompanyName', 'COLUMN';
EXEC sp_rename 'TopTechCompanies.MarketCap', 'MarketCapitalization', 'COLUMN';
EXEC sp_rename 'TopTechCompanies.Stock', 'StockCode', 'COLUMN';
EXEC sp_rename 'TopTechCompanies.Industry_1', 'IndustryType', 'COLUMN';

--Viewing the updated Table
SELECT 
	Ranking,
	CompanyName,
	MarketCapitalization,
	StockCode,
	CountryOfOrigin,
	IndustryType
FROM TopTechCompanies


SELECT *
FROM TopTechCompanies
WHERE 
    CompanyName LIKE '%"%';

-- Removing unwanted symbol from texts in the "CompanyName" column

UPDATE TopTechCompanies
SET CompanyName = REPLACE(CompanyName, '"', '')
WHERE CompanyName LIKE '%"%' -- This checks if the CompanyName contains double quotes

-- Deleting unwanted columns

ALTER TABLE TopTechCompanies
DROP COLUMN Country, Industry;

SELECT DISTINCT IndustryType
FROM TopTechCompanies

SELECT IndustryType
FROM TopTechCompanies
WHERE 
    IndustryType LIKE '%,%';

-- Updating wrong input

UPDATE TopTechCompanies
SET IndustryType = 'Software Infrastructure'
WHERE IndustryType LIKE '%Infrastructure%'

--Check if the column contains non-numeric characters

SELECT MarketCapitalization
FROM TopTechCompanies
WHERE MarketCapitalization NOT LIKE '%[0-9]%';


--Standardize "MarketCapitalization" to a numeric format
-- Remove symbols like $, B, M, and T and convert text to numeric

SELECT MarketCapitalization
FROM TopTechCompanies
WHERE MarketCapitalization LIKE '%[B,M,T]%';


ALTER TABLE TopTechCompanies
ADD MarketCapitalization_Clean NVARCHAR(MAX);

UPDATE TopTechCompanies
SET MarketCapitalization_Clean = REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(MarketCapitalization, '$', ''),   -- Remove '$'
                ' T', '000000000000'           -- Replace 'T' with twelve zeros
            ),
            ' B', '000000000'                 -- Replace 'B' with nine zeros
        ),
        ' M', '000000'                       -- Replace 'M' with six zeros
    )
WHERE MarketCapitalization LIKE '%[BMT]%';             -- Only target rows with symbols

SELECT *
FROM TopTechCompanies

UPDATE TopTechCompanies
SET MarketCapitalization_Clean = REPLACE(MarketCapitalization_Clean, '.', '')
WHERE MarketCapitalization_Clean LIKE '%.%'


-- Trim spaces

UPDATE TopTechCompanies
SET Ranking = LTRIM(RTRIM(Ranking)),
    CompanyName = LTRIM(RTRIM(CompanyName)),
    MarketCapitalization_Clean = LTRIM(RTRIM(MarketCapitalization_Clean)),
	MarketCapitalization = LTRIM(RTRIM(MarketCapitalization)),
    StockCode = LTRIM(RTRIM(StockCode)),
    CountryOfOrigin = LTRIM(RTRIM(CountryOfOrigin)),
    IndustryType = LTRIM(RTRIM(IndustryType));

-- Changing datatype of MarketCapitalization_Clean from nvarchar to bigint

ALTER TABLE TopTechCompanies
ALTER COLUMN MarketCapitalization_Clean BIGINT;


-- Data Analysis and Insights
-- Top 10 Companies by MarketCapitalization

SELECT TOP 10 
	CompanyName, 
	MarketCapitalization_Clean, 
	CountryOfOrigin, 
	IndustryType
FROM 
	TopTechCompanies
ORDER BY 
	MarketCapitalization_Clean DESC;

-- Number of companies by country

SELECT 
	CountryOfOrigin,
	COUNT(*) AS CompanyCount
FROM 
	TopTechCompanies
GROUP BY 
	CountryOfOrigin
ORDER BY 
	CompanyCount DESC;

-- Number of companies by industry

SELECT 
	IndustryType, 
	COUNT(*) AS CompanyCount
FROM 
	TopTechCompanies
GROUP BY 
	IndustryType
ORDER BY 
	CompanyCount DESC;


-- Number of companies by country and industry

SELECT 
	CountryOfOrigin, 
	IndustryType, 
	COUNT(*) AS CompanyCount
FROM 
	TopTechCompanies
GROUP BY 
	CountryOfOrigin, 
	IndustryType
ORDER BY 
	CompanyCount DESC;

-- Average Market Cap by Industry

SELECT 
	IndustryType, 
	AVG(MarketCapitalization_Clean) AS AvgMarketCapitalization
FROM 
	TopTechCompanies
GROUP BY 
	IndustryType
ORDER BY 
	AvgMarketCapitalization DESC;

-- Market Share by Country

SELECT 
    CountryOfOrigin AS Country,
    SUM(MarketCapitalization_Clean) AS TotalMarketCap,
    CONCAT(CAST(ROUND(SUM(MarketCapitalization_Clean) * 100.0 / (SELECT SUM(MarketCapitalization_Clean) FROM TopTechCompanies), 2) AS DECIMAL(10, 2)), '%') AS MarketSharePercentage
FROM 
	TopTechCompanies
GROUP BY 
	CountryOfOrigin
ORDER BY 
	TotalMarketCap DESC;

-- Market Share by Industry

SELECT 
    IndustryType AS Industry,
    SUM(MarketCapitalization_Clean) AS TotalMarketCap,
    CONCAT(CAST(ROUND(SUM(MarketCapitalization_Clean) * 100.0 / (SELECT SUM(MarketCapitalization_Clean) FROM TopTechCompanies), 2) AS DECIMAL(10, 2)), '%') AS MarketSharePercentage
FROM 
	TopTechCompanies
GROUP BY 
	IndustryType
ORDER BY 
	TotalMarketCap DESC;

-- List Trillion-Dollar Companies within top 1000 with Total Count using CTE (Common Table Expression)

WITH TrillionDollarCompanies AS (
    SELECT 
        CompanyName, 
        MarketCapitalization
    FROM TopTechCompanies
    WHERE MarketCapitalization LIKE '%T%' -- Filtering for companies with a market cap of 1 trillion or more
)
SELECT 
    CompanyName, 
    MarketCapitalization,
    (SELECT COUNT(*) FROM TrillionDollarCompanies) AS TotalTrillionDollarCompanies
FROM TrillionDollarCompanies
ORDER BY MarketCapitalization DESC; -- Order by Market Cap in descending order


-- List Billion-Dollar Companies within top 1000 with Total Count using CTE (Common Table Expression)

WITH BillionDollarCompanies AS (
    SELECT 
        CompanyName, 
        MarketCapitalization
    FROM TopTechCompanies
    WHERE MarketCapitalization LIKE '%B%' -- Filtering for companies with a market cap of 1 Billion or more
)
SELECT 
    CompanyName, 
    MarketCapitalization,
    (SELECT COUNT(*) FROM BillionDollarCompanies) AS TotalBillionDollarCompanies
FROM BillionDollarCompanies
ORDER BY MarketCapitalization DESC; -- Order by Market Cap in descending order


-- List Million-Dollar Companies within top 1000 with Total Count using CTE (Common Table Expression)

WITH MillionDollarCompanies AS (
    SELECT 
        CompanyName, 
        MarketCapitalization
    FROM TopTechCompanies
    WHERE MarketCapitalization LIKE '%M%' -- Filtering for companies with a market cap of 1 Million or more
)
SELECT 
    CompanyName, 
    MarketCapitalization,
    (SELECT COUNT(*) FROM MillionDollarCompanies) AS TotalMillionDollarCompanies
FROM MillionDollarCompanies
ORDER BY MarketCapitalization DESC; -- Order by Market Cap in descending order

-- Percentage Share of Company Categories within top 1000 using Common Table Expression and Subquery

WITH CompanyCategories AS (
    SELECT 
        CASE 
            WHEN MarketCapitalization LIKE '%T%' THEN 'Trillion Dollar Companies'
            WHEN MarketCapitalization LIKE '%B%' THEN 'Billion Dollar Companies'
            WHEN MarketCapitalization LIKE '%M%' THEN 'Million Dollar Companies'
            ELSE 'Other'
        END AS Category,
        COUNT(*) AS CompanyCount,
        SUM(MarketCapitalization_Clean) AS TotalMarketCap
    FROM TopTechCompanies
    GROUP BY 
        CASE 
            WHEN MarketCapitalization LIKE '%T%' THEN 'Trillion Dollar Companies'
            WHEN MarketCapitalization LIKE '%B%' THEN 'Billion Dollar Companies'
            WHEN MarketCapitalization LIKE '%M%' THEN 'Million Dollar Companies'
            ELSE 'Other'
        END
)
SELECT 
    Category,
    CompanyCount,
    TotalMarketCap,
    CONCAT(CAST(ROUND((CompanyCount * 100.0 / (SELECT COUNT(*) FROM TopTechCompanies)), 2) AS DECIMAL(5,2)), '%') AS PercentageShareOfTotalCompanyCount
FROM CompanyCategories
WHERE Category <> 'Other'
ORDER BY CompanyCount DESC;

-- Thank you
