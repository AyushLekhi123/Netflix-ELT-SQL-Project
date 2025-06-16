-- Data Cleaning

--Handling Forein Characters

SELECT * FROM netflix_raw WHERE show_id = 's5023'

--Removing Duplicates

SELECT show_id, COUNT(*)
FROM netflix_raw
GROUP BY show_id
HAVING COUNT(*) > 1


SELECT * FROM netflix_raw
WHERE CONCAT(title, type) IN(
	SELECT CONCAT(title, type)
	FROM netflix_raw
	GROUP BY title, type
	HAVING COUNT(*) > 1
)
ORDER BY title;

--Query
WITH cte AS(
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY title, type ORDER BY show_id) AS rnk
	FROM netflix_raw
)

SELECT *
FROM cte
WHERE rnk = 1;



-- New tables for listed_in, director, country and cast

-- Director
SELECT show_id, TRIM(value) AS director
INTO netflix_directors
FROM netflix_raw
CROSS APPLY STRING_SPLIT(director, ',');

-- Country
SELECT show_id, TRIM(value) AS country
INTO netflix_countries
FROM netflix_raw
CROSS APPLY STRING_SPLIT(country, ',');

-- Cast
SELECT show_id, TRIM(value) AS cast
INTO netflix_cast
FROM netflix_raw
CROSS APPLY STRING_SPLIT(cast, ',');

-- Genre (listed_in)
SELECT show_id, TRIM(value) AS genre
INTO netflix_genre
FROM netflix_raw
CROSS APPLY STRING_SPLIT(listed_in, ',');

SELECT * FROM netflix_genre;



-- Populate missing values in country, duration columns
-- Datatype conversion for date_added
-- Drop columns country, cast, listed_in and director


SELECT * FROM netflix_raw WHERE show_id = 's1001'
SELECT * FROM netflix_raw WHERE director = 'Ahishor Solomon'

--Query
INSERT INTO netflix_countries
SELECT show_id, m.country
FROM netflix_raw nr
JOIN (
	SELECT director, country 
	FROM netflix_countries nc
	JOIN netflix_directors nd
	ON nc.show_id = nd.show_id
	GROUP BY director, country
) m ON nr.director = m.director
WHERE nr.country IS NULL

SELECT * FROM netflix_countries

---------------------------------------------------

SELECT * FROM netflix_raw WHERE duration IS NULL;


--Query
WITH cte AS(
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY title, type ORDER BY show_id) AS rnk
	FROM netflix_raw
)

SELECT show_id, type, CAST(date_added AS DATE) AS date_added, release_year, rating,
	CASE 
		WHEN duration IS NULL THEN rating
		ELSE duration
	END AS duration,
	description
INTO netflix
FROM cte
WHERE rnk = 1

SELECT * FROM netflix






