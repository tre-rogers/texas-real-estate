-- AVG, MAX, MIN of listing prices for ranges of year built (NOTE: Excludes an outlier with a list price of over $28m

-- First, we will determine the max and min years for deciding how to divide ranges
SELECT
	MAX(year_built),
    MIN(year_built)
FROM
	housing_desc;

-- Will split between 5 segments of 27 years, encapsulates mid-war and post-war periods for WWI, WWII, Cold War, and 
-- the birth of the internet era and tools like zillow

SELECT
	CASE 
		WHEN hd.year_built BETWEEN 1890 AND 1917 THEN '1890-1917' -- Peak and end of WWI
        WHEN hd.year_built BETWEEN 1918 AND 1945 THEN '1918-1945' -- post WWI, stock market crash 1929, majority of WWII
        WHEN hd.year_built BETWEEN 1946 AND 1973 THEN '1946-1973' -- Post WWII
        WHEN hd.year_built BETWEEN 1974 AND 2001 THEN '1974-2001' -- Beginning of modern era of computing
        WHEN hd.year_built > 2002 THEN '2002+' -- modernized real estate estimate services
	ELSE 'Unknown'
	END AS year_built_range,
	##year_built, -- more of a check than anything, don't care if there are null values here (initiated as test without grouping
	-- to assure years were falling into correct categories
    ROUND(AVG(hd.list_price), 2) AS avg_list_price,
    ROUND(MAX(hd.list_price), 2) AS max_list_price,
    ROUND(MIN(hd.list_price), 2) AS min_list_price
FROM
	housing_desc_mod hd
GROUP BY year_built_range
ORDER BY year_built_range;

-- For the purpose of visualization, we will exclude the $28950000 listing as an outlier,
-- but will be sure to make note of it in write up
-- We will create a modified housing_desc table without the record for this case only

CREATE TABLE housing_desc_mod(
	SELECT * FROM housing_desc WHERE list_price != 28950000);
    
SELECT * FROM housing_desc_mod;
-- check data, now this table will be used in above query to form CSV for use in Tableau



