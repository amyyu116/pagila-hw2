/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */

SELECT DISTINCT(actor.first_name || ' ' || actor.last_name) AS "Actor Name"
FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
WHERE film_id IN (
	SELECT film_id
	FROM film, UNNEST(special_features) AS features
	WHERE features = 'Behind the Scenes'	
)
ORDER BY "Actor Name";
