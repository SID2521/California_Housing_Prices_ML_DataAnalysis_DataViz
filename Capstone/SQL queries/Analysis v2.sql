-- We will perfrom some Advance queries in this file
USE Housing;
SELECT * FROM Data;

-- Population Density
-- Here we are performing calculations for Population Density
SELECT
  longitude,
  latitude,
  population / households AS population_density
FROM Data;

-- Age Distribution Analysis
-- Calculating the average age and the number of households for different age ranges.
SELECT
  CASE
    WHEN housing_median_age < 30 THEN 'Less than 30'
    WHEN housing_median_age >= 30 AND housing_median_age < 50 THEN '30 to 50'
    ELSE '50 and above'
  END AS age_range,
  AVG(housing_median_age) AS avg_age,
  COUNT(*) AS num_households
FROM Data
GROUP BY age_range;

-- Income Category Analysis:
-- Classifying households into income categories and calculate the average house value for each category.
SELECT
  CASE
    WHEN median_income < 3 THEN 'Low Income'
    WHEN median_income >= 3 AND median_income < 7 THEN 'Moderate Income'
    ELSE 'High Income'
  END AS income_category,
  AVG(median_house_value) AS avg_house_value
FROM Data
GROUP BY income_category;

-- Ranking Within Groups:
-- This query uses the RANK() window function to assign a rank to each house within its ocean_proximity group
-- based on the descending order of median_house_value.
SELECT
  ocean_proximity,
  longitude,
  latitude,
  median_house_value,
  RANK() OVER (PARTITION BY ocean_proximity ORDER BY median_house_value DESC) AS house_rank
FROM Data;

-- Pivot Table for Age Distribution:
-- This query uses a subquery to categorize houses into age ranges and then calculates the count for each range.

SELECT
  age_range,
  COUNT(*) AS num_houses
FROM (
  SELECT
    CASE
      WHEN housing_median_age < 20 THEN '0-19'
      WHEN housing_median_age >= 20 AND housing_median_age < 40 THEN '20-39'
      ELSE '40+'
    END AS age_range
  FROM Data
) AS age_ranges
GROUP BY age_range;

-- Top 3 Records Within Each Group:
-- This query uses the ROW_NUMBER() window function to rank houses based on median_income within each ocean_proximity group 
-- and then selects the top 3 records from each group.
SELECT
  ocean_proximity,
  longitude,
  latitude,
  median_income
FROM (
  SELECT
    ocean_proximity,
    longitude,
    latitude,
    median_income,
    ROW_NUMBER() OVER (PARTITION BY ocean_proximity ORDER BY median_income DESC) AS income_rank
  FROM Data
) AS ranked_data
WHERE income_rank <= 3;
