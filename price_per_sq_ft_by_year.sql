-- Price per square foot over the years of each housing_type
-- 65 cases where no sq_ft given in data set. All of which are categorized as farm/land except for 3
-- single family cases, two of which did not have a listing price either.
-- We will ignore these records to prevent housing_type categorical calculations from faultering,
-- as these calculations will be done at the record level and not aggregate.

SELECT
	ROUND(hd.list_price/hss.sq_ft, 2) AS pp_sq_ft,  -- price per square foot
    hd.housing_type,
    CASE WHEN hd.year_built IS NULL THEN 'Unknown' ELSE hd.year_built END AS year_built
FROM
	housing_desc hd
		JOIN
	house_specs_size hss ON hd.id = hss.id
WHERE hss.sq_ft IS NOT NULL
ORDER BY hd.year_built;
