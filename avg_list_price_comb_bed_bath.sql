-- Average list price for all combinations of baths_full and no_bedrooms
-- Remember to account for the fact that we have an average listing price 


SELECT
	COUNT(hd.id),
	CASE WHEN hsb.baths_full IS NULL AND hss.no_bedrooms IS NULL THEN '0 baths, 0 beds'  -- mostly farm land or no property has been built (barns, etc.)
	ELSE CONCAT(hsb.baths_full, ' bath(s), ' , hss.no_bedrooms, ' bed(s)') END AS rooms,
    ROUND(AVG(list_price)) AS avg_list_price
FROM
	housing_desc hd
		JOIN
	house_specs_bath hsb ON hd.id = hsb.id
		JOIN
	house_specs_size hss ON hsb.id = hss.id
GROUP BY rooms
ORDER BY rooms;


-- Below is just a data validity check on root data source
SELECT ROUND(AVG(list_price)) FROM main WHERE baths_full = 2 AND no_bedrooms = 3;

SELECT ROUND(AVG(list_price)) FROM main WHERE baths_full = 4 AND no_bedrooms = 9;

SELECT COUNT(*) FROM main WHERE baths_full = 1 AND no_bedrooms = 3;

SELECT * FROM main WHERE baths_full = 4 AND no_bedrooms = 6;