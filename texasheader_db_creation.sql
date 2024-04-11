-- Script used in creation of tables for Tableau visualizations in dashboard linked below (Also available via clickable link in README file)
-- https://public.tableau.com/views/TexasRealEstateListings/TexasRealEstateListings?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link


-- DATA SOURCE: https://www.kaggle.com/datasets/kanchana1990/texas-real-estate-trends-2024-500-listings
-- Be sure to use 'SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));'
-- if running in MySQL Workbench

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));


-- CREATION OF RELATIONAL DATABASE, AS MOST KAGGLE DATASETS ONLY COME AS ONE TABLE
USE texasrealestate;

DROP TABLE IF EXISTS main;
CREATE TABLE main(
	url VARCHAR(255),  -- url to listing
    stat VARCHAR(20),  -- status of listing
    id VARCHAR(25) PRIMARY KEY,  -- unique id for each listing
    list_price INTEGER,  -- listing price
    no_baths INTEGER,  -- number of bathrooms, full + partial
    baths_full INTEGER,  -- number of full bathrooms
    baths_full_calc INTEGER, -- see below for eventual removal of table
    no_bedrooms INTEGER, -- number of bedrooms
    sq_ft INTEGER,  -- square footage
    stories INTEGER,
    subtype VARCHAR(20),
    descript TEXT,
    housing_type VARCHAR(50),
    year_built INTEGER);
    
    
-- Loading data from CSV file
LOAD DATA INFILE 'real_estate_texas_500_2024.csv'
INTO TABLE main
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'  -- \r\n is used for files that came from windows systems, \n for every other source
IGNORE 1 LINES;

SET SQL_SAFE_UPDATES = 0;


-- NULL in below cases can be assumed as instances of lack of information
UPDATE main SET list_price = NULL WHERE list_price = 0;
UPDATE main SET baths_full = NULL WHERE baths_full = 0;
UPDATE main SET baths_full_calc = NULL WHERE baths_full_calc = 0;
UPDATE main SET no_bedrooms = NULL WHERE no_bedrooms = 0;
UPDATE main SET sq_ft = NULL WHERE sq_ft = 0;
UPDATE main SET stories = NULL WHERE stories = 0;


SELECT COUNT(*) FROM main WHERE baths_full != baths_full_calc;
-- above outputs 0, realize duplicate columns, updating table below

ALTER TABLE main DROP baths_full_calc;

SELECT * FROM main;  -- just a check on validity of data

DROP TABLE IF EXISTS housing_desc;
CREATE TABLE housing_desc(
	SELECT
		id,
        url,
        descript,
        housing_type,
        subtype,
        CASE WHEN year_built = 0 THEN NULL ELSE year_built END AS year_built,
        list_price
	FROM
		main);
        
        
DROP TABLE IF EXISTS house_specs_bath;
CREATE TABLE house_specs_bath(
	SELECT
		id,
        no_baths,
        baths_full
	FROM
		main);
        
        
DROP TABLE IF EXISTS house_specs_size;
CREATE TABLE house_specs_size(
	SELECT
		id,
        no_bedrooms,
        sq_ft,
        stories
	FROM
		main);

