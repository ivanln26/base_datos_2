USE sakila;

-- 1
SELECT CONCAT_WS(" ", c.first_name, c.last_name) as 'name', a.address, ci.city
    FROM customer c
    INNER JOIN address a ON c.address_id = a.address_id
    INNER JOIN city ci ON a.city_id = ci.city_id
    INNER JOIN country co ON ci.country_id = co.country_id
    WHERE co.country = 'Argentina';

-- 2
SELECT f.title, l.name,
    CASE
        WHEN f.rating = 'G' THEN 'G (General Audiences)'
        WHEN f.rating = 'PG' THEN 'PG (Parental Guidance Suggested)'
        WHEN f.rating = 'PG-13' THEN 'PG-13 (Parents Strongly Cautioned)'
        WHEN f.rating = 'R' THEN 'R (Restricted)'
        WHEN f.rating = 'NC-17' THEN 'NC-17 (Adults Only)'
        ELSE f.rating
    END AS 'rating'
    FROM film f
    INNER JOIN `language` l ON f.language_id = l.language_id;

-- 3
SELECT f.title, f.release_year, CONCAT_WS(" ", a.first_name, a.last_name) as 'name'
    FROM film f
    INNER JOIN film_actor fa ON f.film_id = fa.film_id
    INNER JOIN actor a ON fa.actor_id = a.actor_id
    WHERE LOWER(CONCAT_WS(" ", a.first_name, a.last_name)) = 'penelope guiness';

-- 4
SELECT CONCAT_WS(" ", c.first_name, c.last_name) as 'name', r.rental_date,
    CASE
        WHEN r.return_date IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS 'returned'
    FROM customer c
    INNER JOIN rental r ON c.customer_id = r.customer_id
    WHERE MONTH(r.rental_date) BETWEEN 5 AND 6;
