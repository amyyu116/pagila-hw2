/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT DISTINCT film.title
FROM film
JOIN inventory USING (film_id)
LEFT JOIN (
        SELECT inventory.film_id
        FROM inventory
        JOIN rental USING (inventory_id)
        JOIN customer USING (customer_id)
        JOIN address USING (address_id)
        JOIN city USING (city_id)
        JOIN country USING (country_id)
        WHERE country.country = 'United States'
) AS rented_US ON inventory.film_id = rented_US.film_id
WHERE rented_US.film_id IS NULL
ORDER BY film.title;
