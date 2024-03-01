/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */

SELECT
    "rank",
    title,
    revenue,
    SUM(revenue) OVER (ORDER BY revenue DESC) AS "total revenue",
to_char(SUM(revenue) OVER (ORDER BY revenue DESC) / SUM(revenue) OVER () * 100, 
	CASE
            WHEN SUM(revenue) OVER (ORDER BY revenue DESC) / SUM(revenue) OVER () * 100 >= 100 THEN 'FM000.00'
            ELSE 'FM00.00'
        END) AS "percent revenue"    

FROM (
    SELECT
        RANK () OVER (ORDER BY revenue DESC) AS "rank",
        title,
        revenue
    FROM (
        SELECT film.title, COALESCE(SUM(payment.amount), 0.00) AS revenue
        FROM film
        LEFT JOIN inventory USING (film_id)
        LEFT JOIN rental USING (inventory_id)
        LEFT JOIN payment USING (rental_id)
        GROUP BY film.title
    ) AS revenue_table
) AS ranked_revenue
ORDER BY "rank" ASC, title;
