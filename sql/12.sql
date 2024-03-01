/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */

SELECT f1.title
FROM (SELECT title, UNNEST(film.special_features) AS features FROM film) as f1
INNER JOIN (
	SELECT title, feature
	FROM film, UNNEST(special_features) AS feature
	WHERE 'Trailers' = feature
	ORDER BY title
) AS f2 ON f2.title = f1.title
WHERE 'Behind the Scenes' = f1.features
ORDER BY f1.title;

