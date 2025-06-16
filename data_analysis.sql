-- Data Analysis

-- Question 1
-- For each Director, count the number of movies and tv shows created by them in separate columns
-- for directors who have created tv shows and movies both

SELECT nd.director, 
	COUNT(CASE 
			WHEN n.type = 'Movie' THEN n.show_id
		  END) AS no_of_movies,
	COUNT(CASE
			WHEN n.type = 'TV Show' THEN n.show_id
		  END) AS no_of_shows
FROM netflix n
JOIN netflix_directors nd
ON n.show_id = nd.show_id
GROUP BY nd.director
HAVING COUNT(DISTINCT n.type) > 1
ORDER BY no_of_shows DESC


-- Question 2
-- Which country has the highest no of comedy movies

WITH cte AS(
	SELECT nc.country, COUNT(DISTINCT nc.show_id) AS no_of_comedy_movies,
		ROW_NUMBER() OVER(ORDER BY COUNT(nc.show_id) DESC) AS rnk
	FROM netflix_countries nc
	JOIN netflix_genre ng
	ON nc.show_id = ng.show_id
	JOIN netflix n
	ON n.show_id = ng.show_id
	WHERE ng.genre = 'Comedies'AND n.type = 'Movie'
	GROUP BY nc.country
)

SELECT country, no_of_comedy_movies
FROM cte
WHERE rnk = 1


--Question 3
-- For each year (as per date added to netflix), which director has the maximum no_of movies released?

WITH cte AS(
	SELECT nd.director, YEAR(n.date_added) AS year, COUNT(n.show_id) AS max_movies,
		ROW_NUMBER() OVER(PARTITION BY YEAR(n.date_added) ORDER BY COUNT(n.show_id) DESC) AS rnk
	FROM netflix n
	JOIN netflix_directors nd
	ON n.show_id = nd.show_id
	WHERE n.type = 'Movie'
	GROUP BY nd.director, YEAR(n.date_added)
)

SELECT director, year, max_movies
FROM cte
WHERE rnk = 1
ORDER BY year DESC, max_movies DESC


-- Question 4
-- What is the average duration of movies in each genre

SELECT ng.genre, AVG(CAST(REPLACE(n.duration, ' min', '') AS INT)) AS avg_duration
FROM netflix n
JOIN netflix_genre ng
ON n.show_id = ng.show_id
WHERE type = 'Movie'
GROUP BY ng.genre
ORDER BY ng.genre


-- Question 5
-- Find the list of directors who have created both horror and comedy movies
-- Display the director names along with the number of those movies directed by them

SELECT director, 
	COUNT(DISTINCT CASE WHEN ng.genre = 'Horror Movies' THEN n.show_id END) AS no_of_horror_movies,
	COUNT(DISTINCT CASE WHEN ng.genre = 'Comedies' THEN n.show_id END) AS no_of_comedy_movies
FROM netflix_directors nd
JOIN netflix_genre ng
ON nd.show_id = ng.show_id
JOIN netflix n
ON n.show_id = ng.show_id
WHERE ng.genre IN ('Horror Movies', 'Comedies') 
	AND n.type = 'Movie'
GROUP BY director
HAVING COUNT(DISTINCT ng.genre) = 2
ORDER BY no_of_horror_movies DESC