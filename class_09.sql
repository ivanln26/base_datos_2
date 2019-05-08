USE sakila;

-- Find customers that rented only one film
SELECT c.customer_id, first_name, last_name, COUNT(*)
    FROM rental r1, customer c
    WHERE c.customer_id = r1.customer_id
    GROUP BY c.customer_id, first_name, last_name
    HAVING COUNT(*) = 1;

-- Show the films ratings where the minimum film duration in that group is greater than 46
SELECT rating, MIN(`length`)
    FROM film
    GROUP BY rating
    HAVING MIN(`length`) > 46;

-- Show ratings that have less than 195 films
SELECT rating, COUNT(*) AS total
    FROM film
    GROUP BY rating
    HAVING COUNT(*) < 195;

-- Same but with subqueries
SELECT DISTINCT rating, (SELECT COUNT(*)
                                FROM film f3
                                WHERE f3.rating = f1.rating) AS total
    FROM film f1
    WHERE (SELECT COUNT(*)
                FROM film f2
                WHERE f1.rating = f2.rating) < 195;

-- Show ratings where their film duration average is grater than all films duration average.
SELECT rating, AVG(`length`)
    FROM film
    GROUP BY rating
    HAVING AVG(`length`) > (SELECT AVG(`length`) FROM film);

-- 1
SELECT country, COUNT(c.city_id) AS cities
    FROM country co INNER JOIN city c
    ON co.country_id = c.country_id
    GROUP BY co.country_id
    ORDER BY co.country, co.country_id;

-- 2
SELECT country, COUNT(c.city_id) AS cities
    FROM country co INNER JOIN city c
    ON co.country_id = c.country_id
    GROUP BY co.country_id
    HAVING cities > 10
    ORDER BY cities desc;

-- 3
SELECT
    CONCAT_WS(" ", last_name, first_name) AS name,
    (SELECT a.address FROM address a WHERE c.address_id = a.address_id) AS address,
    (SELECT COUNT(*) FROM rental r WHERE c.customer_id = r.customer_id GROUP BY c.customer_id) AS films_rented,
    (SELECT SUM(p.amount) FROM payment p WHERE c.customer_id = p.customer_id) AS money_spent
    FROM customer c
    ORDER BY money_spent desc;

-- 4
SELECT c.name, AVG(`length`)
    FROM film f INNER JOIN category c INNER JOIN film_category fc
    ON f.film_id = fc.film_id AND c.category_id = fc.category_id
    GROUP BY c.name
    HAVING AVG(`length`) > (SELECT AVG(`length`) FROM film);

-- 5
SELECT rating, SUM(p.amount)
    FROM film f INNER JOIN inventory i INNER JOIN rental r INNER JOIN payment p
    ON f.film_id = i.film_id AND i.inventory_id = r.inventory_id AND r.rental_id = p.rental_id
    GROUP BY f.rating;
