-- Our Database name is "Housing" and the first table name is "Data" 
USE Housing;
SELECT * FROM Data; 

-- First, We are performing Descriptive Statistics on our Data table below:
SELECT
  AVG(longitude) AS avg_longitude,
  AVG(latitude) AS avg_latitude,
  AVG(housing_median_age) AS avg_housing_median_age,
  AVG(total_rooms) AS avg_total_rooms,
  AVG(total_bedrooms) AS avg_total_bedrooms,
  AVG(population) AS avg_population,
  AVG(households) AS avg_households,
  AVG(median_income) AS avg_median_income,
  AVG(median_house_value) AS avg_median_house_value
FROM Data;

-- Now we are performing Grouping and Aggregation of Ocean Proximity
SELECT
  ocean_proximity,
  AVG(median_house_value) AS avg_house_value,
  COUNT(*) AS num_records
FROM Data
GROUP BY ocean_proximity;

-- Now we are doing Filtering and sorting
-- 1. Monthly in thousdands Median Income from (15k - 10k)
SELECT *
FROM Data
WHERE median_income > 10
ORDER BY median_income DESC;

-- 2. Median House value more than 100k
SELECT *
FROM Data
WHERE median_house_value > 100000;

-- Here we are doing Data Distribution on housing median age count
SELECT
  housing_median_age,
  COUNT(*) AS age_count
FROM Data
GROUP BY housing_median_age
ORDER BY housing_median_age;

-- Here we are doing Geospatial analysis by taking latitude, longitude and house values
SELECT
  longitude,
  latitude,
  median_house_value
FROM Data;

