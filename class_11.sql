USE sakila;

-- 1
SELECT *
    FROM film f LEFT JOIN inventory i
    ON f.film_id = i.film_id
    WHERE i.film_id IS NULL;

-- 2
SELECT f.title, i.inventory_id, r.inventory_id
    FROM film f 
    INNER JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    WHERE r.inventory_id IS NULL;

-- 3
SELECT c.first_name, c.last_name, s.store_id, f.title, r.return_date
    FROM film f
    INNER JOIN inventory i ON f.film_id = i.film_id
    INNER JOIN store s ON i.inventory_id = s.store_id
    INNER JOIN customer c ON s.store_id = c.store_id
    INNER JOIN rental r ON c.customer_id = r.customer_id
    WHERE r.return_date IS NOT NULL
    ORDER BY s.store_id, c.last_name;

-- 4
SELECT
    CONCAT_WS(" ", ci.city, co.country) AS 'address',
    CONCAT_WS(" ", st.first_name, st.last_name) AS 'name',
    s.store_id,
    SUM(p.amount)
    FROM store s
    INNER JOIN customer c ON s.store_id = c.store_id
    INNER JOIN rental r ON c.customer_id = r.customer_id
    INNER JOIN payment p ON r.rental_id = p.rental_id
    INNER JOIN address a ON s.address_id = a.address_id
    INNER JOIN city ci ON a.city_id = ci.city_id
    INNER JOIN country co ON ci.country_id = co.country_id
    INNER JOIN staff st ON s.manager_staff_id = st.staff_id
    GROUP BY s.store_id;

-- 5
SELECT CONCAT_WS(" ", a.first_name, a.last_name) AS 'name', a.actor_id, COUNT(*) AS 'times'
    FROM actor a
    INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
    HAVING COUNT(a.actor_id) >= ALL(SELECT COUNT(a2.actor_id)
                                        FROM actor a2
                                        INNER JOIN film_actor fa2
                                        ON a2.actor_id = fa2.actor_id
                                        GROUP BY a2.actor_id);
