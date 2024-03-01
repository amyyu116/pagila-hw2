/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */
SELECT film.title
FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE film.title IN (
	SELECT title
	FROM FILM, UNNEST(special_features) AS features
	WHERE 'Trailers' = features
) AND film.rating = 'G'
ORDER BY film.title;

