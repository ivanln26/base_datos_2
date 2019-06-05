USE sakila;

-- 1
SELECT
    CONCAT_WS(" ", c.first_name, c.last_name) AS 'name',
    COUNT(r.rental_id) AS 'movies_rented',
    SUM(p.amount) AS 'amount'
    FROM customer c
    INNER JOIN rental r USING (customer_id)
    INNER JOIN payment p USING (rental_id)
    GROUP BY c.customer_id
    HAVING SUM(p.amount) BETWEEN 100 AND 150;

-- 2
SELECT
    co.country AS 'Pais',
    c.name AS 'Categoria',
    COUNT(f.film_id) AS 'Cantidad'
    FROM film f
    INNER JOIN film_category fc USING (film_id)
    INNER JOIN category c USING (category_id)
    INNER JOIN inventory i USING (film_id)
    INNER JOIN rental r USING (inventory_id)
    INNER JOIN customer cu USING (customer_id)
    INNER JOIN address a USING (address_id)
    INNER JOIN city cy USING (city_id)
    INNER JOIN country co USING (country_id)
    GROUP BY co.country_id, c.category_id;

-- 3
SELECT f.rating, COUNT(r.rental_id) AS 'films_rented'
    FROM film f
    INNER JOIN inventory i ON f.film_id = i.inventory_id
    INNER JOIN rental r ON i.inventory_id = r.inventory_id
    INNER JOIN customer c ON r.customer_id = c.customer_id
    WHERE r.return_date IS NULL
    GROUP BY f.rating;

-- 4
SELECT
    a.actor_id, a.first_name, a.last_name,
    COUNT(a.actor_id) AS 'num_of_films'
    FROM film f
    INNER JOIN film_actor fa ON f.film_id = fa.film_id
    INNER JOIN actor a ON fa.actor_id = a.actor_id
    GROUP BY a.actor_id
    ORDER BY a.last_name;

SELECT
    a.actor_id, a.last_name, a.first_name,
    (SELECT COUNT(fa.film_id)
        FROM actor a2
        INNER JOIN film_actor fa ON a2.actor_id = fa.actor_id
        WHERE a.actor_id = a2.actor_id
        GROUP BY a2.actor_id) AS 'num_of_films',
    c.customer_id, c.first_name, c.last_name
    FROM customer c
    LEFT OUTER JOIN actor a ON c.last_name = a.last_name
    ORDER BY c.last_name;


