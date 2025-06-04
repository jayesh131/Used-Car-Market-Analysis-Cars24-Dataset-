create database cars24

Use cars24

select * from cars24data;

-- Data Consistency Audit
SELECT *
FROM cars24data
WHERE Manufacturing_year IS NULL OR Price IS NULL OR Model_Name IS NULL;

-- Duplicates value check
SELECT *, COUNT(*) AS duplicate_count
FROM cars24data
GROUP BY 
  Model_Name,
  Fuel_type,
  Transmission,
  Manufacturing_year,
  Ownership,
  Engine_capacity,
  KM_driven,
  Price,
  Imperfections,
  Repainted_Parts,
  Spare_key
HAVING COUNT(*) > 1;

-- Total Cars and Average Price
SELECT COUNT(*) AS total_cars, Round(AVG(Price), 2) AS avg_price
FROM cars24data;

-- Number of Cars by Fuel Type
SELECT Fuel_type, COUNT(*) AS count
FROM cars24data
GROUP BY Fuel_type;

-- Filter: Petrol + Manual + After 2018
SELECT *
FROM cars24data
WHERE Fuel_type = 'Petrol' AND Transmission = 'Manual' AND Manufacturing_year > 2018;

-- Top 10 Most Expensive Cars
SELECT Model_Name, Price
FROM cars24data
ORDER BY Price DESC
LIMIT 10;

-- Average Price by Transmission Type
SELECT Transmission, ROUND(AVG(Price), 0) AS avg_price
FROM cars24data
GROUP BY Transmission;

-- Cars Without Spare Key
SELECT COUNT(*) AS no_spare_key
FROM cars24data
WHERE Spare_key = 'No';

-- Average Imperfections per Ownership Count
SELECT Ownership, ROUND(AVG(Imperfections), 0) AS avg_defects
FROM cars24data
GROUP BY Ownership;

-- Average Price by Year
SELECT Manufacturing_year, ROUND(AVG(Price), 0) AS avg_price
FROM cars24data
GROUP BY Manufacturing_year
ORDER BY Manufacturing_year;

-- Top 1% highest price
WITH ranked_prices AS (
  SELECT *, 
         ROW_NUMBER() OVER (ORDER BY Price DESC) AS rn,
         COUNT(*) OVER () AS total_rows
  FROM cars24data
)
SELECT * 
FROM ranked_prices
WHERE rn <= total_rows * 0.01;

-- Pricing Gap by Model Trim
SELECT SUBSTRING(Model_Name, 6) AS Model_Trim,
       COUNT(*) AS Listings,
       MAX(Price) AS Max_Price,
       MIN(Price) AS Min_Price,
       MAX(Price) - MIN(Price) AS Gap
FROM cars24data
GROUP BY Model_Trim
HAVING COUNT(*) > 3
ORDER BY Gap DESC;

